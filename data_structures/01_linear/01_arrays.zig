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
  try sparseArrays(allocator);
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

pub fn CircularBuffer(comptime T: type, comptime size: usize) type {
  return struct {
    data: [size]T = undefined,
    head: usize = 0,
    tail: usize = 0,
    count: usize = 0,

    const Self = @This();

    pub fn append(self: *Self, item: T) !void {
      if (self.count == size) return error.BufferFull;
      self.data[self.head] = item;
      self.head = (self.head + 1) % size;
      self.count += 1;
    }

    pub fn pop(self: *Self) ?T {
      if (self.count == 0) return null;
      const item = self.data[self.tail];
      self.tail = (self.tail + 1) % size;
      self.count -= 1;
      return item;
    }

    pub fn at(self: *const Self, index: usize) ?T {
      if (index >= self.count) return null;
      return self.data[(self.tail + index) % size];
    }

    pub fn len(self: *const Self) usize {
      return self.count;
    }

    pub fn format(self: Self, writer: anytype) !void {
      try writer.writeAll("{ ");
      var i: usize = 0;
      while (i < self.count) : (i += 1) {
        const idx = (self.tail + i) % size;
        try writer.print("{}", .{self.data[idx]});
        if (i + 1 < self.count) try writer.writeAll(", ");
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

// ============================================================================
// SPARSE ARRAYS & MATRICES
// ============================================================================
fn sparseArrays(allocator: std.mem.Allocator) !void {
  std.debug.print("Sparse Structures\n", .{});

  var sparse = std.AutoHashMap(u32, i32).init(allocator);
  defer sparse.deinit();

  try sparse.put(99999, 777);
  std.debug.print(
    "Sparse value at index 99999: {d}\n",
    .{sparse.get(99999).?},
  );

  var matrix = SparseMatrix(f32).init();
  defer matrix.deinit(allocator);

  try matrix.set(allocator, 10, 20, 3.14);
  if (matrix.get(10, 20)) |v| {
    std.debug.print("Sparse Matrix (10,20): {d:.2}\n", .{v});
  }
}

// ============================================================================
// SPARSE MATRIX TYPE
// ============================================================================
pub fn SparseMatrix(comptime T: type) type {
  return struct {
    indices: std.ArrayList(Key) = .{},
    values: std.ArrayList(T) = .{},
    lookup: std.AutoHashMap(Key, usize),

    const Self = @This();
    const Key = struct { x: u32, y: u32 };

    pub fn init() Self {
      return .{
        .lookup = std.AutoHashMap(Key, usize).init(std.heap.page_allocator),
      };
    }

    pub fn deinit(self: *Self, allocator: std.mem.Allocator) void {
      self.indices.deinit(allocator);
      self.values.deinit(allocator);
      self.lookup.deinit();
    }

    pub fn set(
      self: *Self,
      allocator: std.mem.Allocator,
      x: u32,
      y: u32,
      value: T,
    ) !void {
      const key = Key{ .x = x, .y = y };
      if (self.lookup.get(key)) |idx| {
        self.values.items[idx] = value;
      } else {
        const idx = self.values.items.len;
        try self.indices.append(allocator, key);
        try self.values.append(allocator, value);
        try self.lookup.put(key, idx);
      }
    }

    pub fn get(self: Self, x: u32, y: u32) ?T {
      const idx = self.lookup.get(.{ .x = x, .y = y }) orelse return null;
      return self.values.items[idx];
    }
  };
}
