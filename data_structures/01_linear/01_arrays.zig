const std = @import("std");

// ============================================================================
// MAIN ENTRY POINT
// ============================================================================
pub fn main() !void {
  var gpa = std.heap.GeneralPurposeAllocator(.{}){};
  defer _ = gpa.deinit();
  const allocator = gpa.allocator();

  std.debug.print("--- Zig Array Structures ---\n\n", .{});

  staticArrays();
  try dynamicArrays(allocator);
  multiDimensional();
  try circularArrays();
}

// ============================================================================
// STATIC 1D ARRAYS
// ============================================================================
fn staticArrays() void {
  std.debug.print("Static 1D Arrays\n", .{});

  const array = [5]i32{ 1, 2, 3, 4, 5 };
  const slice = array[1..3];
  const repeated = [_]u8{0} ** 10;

  std.debug.print(
    "Array: {any}, Slice: {any}, Repeated size: {d}\n\n",
    .{ array, slice, repeated.len },
  );
}

// ============================================================================
// DYNAMIC ARRAYS (ArrayList)
// ============================================================================
fn dynamicArrays(allocator: std.mem.Allocator) !void {
  std.debug.print("Dynamic Arrays\n", .{});

  var list = std.ArrayList(u8){};
  defer list.deinit(allocator);

  try list.append(allocator, 10);
  try list.appendSlice(allocator, &[_]u8{ 20, 30, 40 });

  std.debug.print(
    "List length: {d}, Item at index 1: {d}\n\n",
    .{ list.items.len, list.items[1] },
  );
}

// ============================================================================
// MULTI-DIMENSIONAL ARRAYS
// ============================================================================
fn multiDimensional() void {
  std.debug.print("Multi-dimensional\n", .{});

  const matrix = [2][3]u8{
    .{ 1, 2, 3 },
    .{ 4, 5, 6 },
  };

  const tensor3 = [2][2][3]u8{
    .{
      .{ 255, 0, 0 },
      .{ 0, 255, 0 },
    },
    .{
      .{ 0, 0, 255 },
      .{ 255, 255, 0 },
    },
  };

  std.debug.print("Matrix (1,2): {d}\n", .{matrix[1][2]});
  std.debug.print("Tensor (1,0,2): {d}\n\n", .{tensor3[1][0][2]});
}

// ============================================================================
// CIRCULAR ARRAYS (Ring Buffer - FIFO)
// ============================================================================

pub fn CircularBuffer(comptime T: type, comptime capacity: usize) type {
  return struct {
    data: [capacity]T = undefined,
    head: usize = 0,
    tail: usize = 0,
    size: usize = 0,

    const Self = @This();

    pub fn append(self: *Self, item: T) !void {
      if (self.size == capacity) return error.BufferFull;
      self.data[self.head] = item;
      self.head = (self.head + 1) % capacity;
      self.size += 1;
    }

    pub fn pop(self: *Self) ?T {
      if (self.size == 0) return null;
      const item = self.data[self.tail];
      self.tail = (self.tail + 1) % capacity;
      self.size -= 1;
      return item;
    }

    pub fn at(self: *const Self, index: usize) ?T {
      if (index >= self.size) return null;
      return self.data[(self.tail + index) % capacity];
    }

    pub fn len(self: *const Self) usize {
      return self.size;
    }

    pub fn format(self: Self, writer: anytype) !void {
      try writer.writeAll("{ ");
      var i: usize = 0;
      while (i < self.size) : (i += 1) {
        const idx = (self.tail + i) % capacity;
        try writer.print("{}", .{self.data[idx]});
        if (i + 1 < self.size) try writer.writeAll(", ");
      }
      try writer.writeAll(" }");
    }
  };
}

fn circularArrays() !void {
  std.debug.print("Circular Buffer\n", .{});
  var ring = CircularBuffer(u8, 4){};

  try ring.append(1);
  try ring.append(2);
  try ring.append(3);
  try ring.append(4);
  _ = ring.pop();
  try ring.append(5);
  std.debug.print("Circular Array (FIFO order): {f}\n", .{ring});
}
