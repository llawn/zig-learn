const std = @import("std");

// ============================================================================
// MAIN ENTRY POINT
// ============================================================================
pub fn main() !void {
  var gpa = std.heap.GeneralPurposeAllocator(.{}){};
  defer _ = gpa.deinit();
  const allocator = gpa.allocator();

  std.debug.print("--- Zig Linked List Structures ---\n\n", .{});

  try singlyLinkedLists(allocator);
  try doublyLinkedLists(allocator);
  try circularLinkedLists(allocator);
  try skipLists(allocator);
  try selfOrganizingLists(allocator);
}

// ============================================================================
// SINGLY LINKED LISTS
// ============================================================================
pub fn SinglyLinkedList(comptime T: type) type {
  return struct {
    head: ?*Node = null,
    tail: ?*Node = null,
    len: usize = 0,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub const Node = struct {
      data: T,
      next: ?*Node = null,
    };

    pub fn init(allocator: std.mem.Allocator) Self {
      return Self{ .allocator = allocator };
    }

    pub fn deinit(self: *Self) void {
      var current = self.head;
      while (current) |node| {
        const next = node.next;
        self.allocator.destroy(node);
        current = next;
      }
      self.* = undefined; // Mark the struct as invalid
    }

    pub fn append(self: *Self, data: T) !void {
      const new_node = try self.allocator.create(Node);
      new_node.* = .{ .data = data, .next = null };

      if (self.tail) |tail| {
        tail.next = new_node;
      } else {
        self.head = new_node;
      }
      self.tail = new_node;
      self.len += 1;
    }

    pub fn prepend(self: *Self, data: T) !void {
      const new_node = try self.allocator.create(Node);
      new_node.* = .{ .data = data, .next = self.head };

      if (self.head == null) {
        self.tail = new_node;
      }

      self.head = new_node;
      self.len += 1;
    }

    pub fn find(self: Self, data: T) ?*Node {
      var current = self.head;
      while (current) |node| {
        if (std.meta.eql(node.data, data)) return node;
        current = node.next;
      }
      return null;
    }

    pub fn remove(self: *Self, data: T) bool {
      var prev: ?*Node = null;
      var current = self.head;
      var is_removed = false;

      while (current) |node| {
        if (std.meta.eql(node.data, data)) {

          if (prev) |p| {
            p.next = node.next;
          } else {
            self.head = node.next;
          }

          if (node == self.tail) {
            self.tail = prev;
          }

          self.allocator.destroy(node);
          self.len -= 1;
          is_removed = true;
          break;
        }
        prev = node;
        current = node.next;
      }

      return is_removed;
    }

    pub fn deleteAt(self: *Self, index: usize) bool {

      if (index >= self.len) return false;
      var prev: ?*Node = null;
      var current = self.head;
      var i: usize = 0;

      while (i < index) : (i += 1) {
        prev = current;
        current = current.?.next;
      }

      const node_to_delete = current.?;
      if (prev) |p| {
        p.next = node_to_delete.next;
      } else {
        self.head = node_to_delete.next;
      }

      if (node_to_delete == self.tail) {
        self.tail = prev;
      }

      self.allocator.destroy(node_to_delete);
      self.len -= 1;
      return true;
    }

    pub fn deleteNode(self: *Self, node_to_delete: *Node) bool {
      if (self.head == node_to_delete) {
        self.head = node_to_delete.next;
        if (self.tail == node_to_delete) {
            self.tail = null;
        }
        self.allocator.destroy(node_to_delete);
        self.len -= 1;
        return true;
      }
      // We must find the node BEFORE node_to_delete
      var current = self.head;
      var succeed = false;
      while (current) |c| {
        if (c.next == node_to_delete) {
          c.next = node_to_delete.next;
          if (self.tail == node_to_delete) {
            self.tail = c;
          }
          self.allocator.destroy(node_to_delete);
          self.len -= 1;
          succeed = true;
          break;
        }
        current = c.next;
      }
      return succeed;
    }

    pub fn display(self: Self) void {
      var current = self.head;
      std.debug.print("Singly List [", .{});
      while (current) |node| {
        std.debug.print("{any}", .{node.data});
        if (node.next != null) std.debug.print(" -> ", .{});
        current = node.next;
      }
      std.debug.print("] (len: {d})\n", .{self.len});
    }
  };
}

fn singlyLinkedLists(allocator: std.mem.Allocator) !void {
  std.debug.print("Singly Linked Lists\n", .{});

  var list = SinglyLinkedList(u32).init(allocator);
  defer list.deinit();

  try list.append(3);
  try list.append(4);
  try list.append(5);
  try list.prepend(2);
  try list.prepend(1);
  try list.prepend(0);
  _ = list.deleteAt(4); // 4
  _ = list.remove(3); // 3
  const node = list.find(2) orelse unreachable;
  _ = list.deleteNode(node); //2
  list.display();
  std.debug.print("\n", .{});
}

// ============================================================================
// DOUBLY LINKED LISTS
// ============================================================================
pub fn DoublyLinkedList(comptime T: type) type {
  return struct {
    head: ?*Node = null,
    tail: ?*Node = null,
    len: usize = 0,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub const Node = struct {
      data: T,
      next: ?*Node = null,
      prev: ?*Node = null,
    };

    pub fn init(allocator: std.mem.Allocator) Self {
      return Self{ .allocator = allocator };
    }

    pub fn deinit(self: *Self) void {
      while (self.head) |node| {
        const next = node.next;
        self.allocator.destroy(node);
        self.head = next;
      }
      self.len = 0;
      self.tail = null;
    }

    pub fn append(self: *Self, data: T) !void {
      const new_node = try self.allocator.create(Node);
      new_node.* = .{ .data = data, .next = null, .prev = self.tail };

      if (self.tail) |tail| {
        tail.next = new_node;
      } else {
        self.head = new_node;
      }
      self.tail = new_node;
      self.len += 1;
    }

    pub fn prepend(self: *Self, data: T) !void {
      const new_node = try self.allocator.create(Node);
      new_node.* = .{ .data = data, .next = self.head, .prev = null };

      if (self.head) |head| {
        head.prev = new_node;
      } else {
        self.tail = new_node;
      }
      self.head = new_node;
      self.len += 1;
    }

    pub fn find(self: Self, data: T) ?*Node {
      var current = self.head;
      while (current) |node| {
        if (std.meta.eql(node.data, data)) {
          return node;
        }
        current = node.next;
      }
      return null;
    }

    pub fn remove(self: *Self, data: T) bool {
      var current = self.head;
      var is_removed = false;

      while (current) |node| {
        if (std.meta.eql(node.data, data)) {
          is_removed = self.deleteNode(node);
          break;
        }
        current = node.next;
      }
      return is_removed;
    }

    pub fn deleteAt(self: *Self, index: usize) bool {

      if (index >= self.len) return false;
      var current = self.head;
      var i: usize = 0;

      while (i < index) : (i += 1) {
        current = current.?.next;
      }

      const node_to_delete = current.?;
      return self.deleteNode(node_to_delete);
    }

    pub fn deleteNode(self: *Self, node_to_delete: *Node) bool {

      if (node_to_delete.prev) |p| {
        p.next = node_to_delete.next;
      } else {
        self.head = node_to_delete.next;
      }

      if (node_to_delete.next) |n| {
        n.prev = node_to_delete.prev;
      } else {
        self.tail = node_to_delete.prev;
      }

      self.allocator.destroy(node_to_delete);
      self.len -= 1;
      return true;
    }

    pub fn displayForward(self: Self) void {
      var current = self.head;
      std.debug.print("Doubly List Forward [", .{});
      while (current) |node| {
        std.debug.print("{any}", .{node.data});
        if (node.next != null) std.debug.print(" <-> ", .{});
        current = node.next;
      }
      std.debug.print("]\n", .{});
    }

    pub fn displayBackward(self: Self) void {
      var current = self.tail;
      std.debug.print("Doubly List Backward [", .{});
      while (current) |node| {
        std.debug.print("{any}", .{node.data});
        if (node.prev != null) std.debug.print(" <-> ", .{});
        current = node.prev;
      }
      std.debug.print("]\n", .{});
    }
  };
}

fn doublyLinkedLists(allocator: std.mem.Allocator) !void {
  std.debug.print("Doubly Linked Lists\n", .{});

  var list = DoublyLinkedList(u32).init(allocator);
  defer list.deinit();

  try list.append(4);
  try list.append(5);
  try list.append(6);
  try list.append(7);
  try list.prepend(3);
  try list.prepend(2);
  try list.prepend(1);
  try list.prepend(0);

  list.displayForward();
  list.displayBackward();

  _ = list.remove(3);
  const node = list.find(4);
  if (node) |n| {
    _ = list.deleteNode(n);
  }
  _ = list.deleteAt(3);
  list.displayForward();
  std.debug.print("\n", .{});
}

// ============================================================================
// CIRCULAR LINKED LISTS
// ============================================================================
pub fn CircularLinkedList(comptime T: type) type {
  return struct {
    tail: ?*Node = null,
    len: usize = 0,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub const Node = struct {
      data: T,
      next: ?*Node = null,
    };

    pub fn init(allocator: std.mem.Allocator) Self {
      return Self{ .allocator = allocator };
    }

    pub fn deinit(self: *Self) void {
      if (self.tail) |tail| {
        var current = tail.next; // Start at the head
        var i: usize = 0;
        while (i < self.len) : (i+=1) {
          if (current) |node_to_destroy| {
            const next_node = node_to_destroy.next;
            self.allocator.destroy(node_to_destroy);
            current = next_node;
          } else break;
        }
      }
      self.len = 0;
      self.tail = null;
    }

    pub fn append(self: *Self, data: T) !void {
      const new_node = try self.allocator.create(Node);
      new_node.* = .{ .data = data };

      if (self.tail) |tail| {
        new_node.next = tail.next;
        tail.next = new_node;
        self.tail = new_node;
      } else {
        new_node.next = new_node;
        self.tail = new_node;
      }
      self.len += 1;
    }

    pub fn prepend(self: *Self, data: T) !void {
      const new_node = try self.allocator.create(Node);
      new_node.* = .{ .data = data };

      if (self.tail) |tail| {
        new_node.next = tail.next;
        tail.next = new_node;
      } else {
        // 1 node long
        new_node.next = new_node;
        self.tail = new_node;
      }
      self.len += 1;
    }

    pub fn find(self: Self, data: T) ?*Node {
      var node: ?*Node = null;
      if (self.tail) |tail| {
        var current = tail.next;
        var i: usize = 0;
        while (i < self.len) : (i+=1) {
          if (current) |n| {
            if (std.meta.eql(n.data, data)) {
              node = n;
              break;
            }
            current = n.next;
          } else break;
        }
      }
      return node;
    }

    pub fn display(self: Self) void {
      if (self.tail) |tail| {
        var current = tail.next;
        var i: usize = 0;
        std.debug.print("Circular List [", .{});
        while (i < self.len) {
          std.debug.print("{any}", .{current.?.data});
          if (i < self.len - 1) std.debug.print(" -> ", .{});
          current = current.?.next;
          i += 1;
        }
        std.debug.print("] (len: {d})\n", .{self.len});
      } else {
        std.debug.print("Circular List [] (len: 0)\n", .{});
      }
    }
  };
}

fn circularLinkedLists(allocator: std.mem.Allocator) !void {
  std.debug.print("Circular Linked Lists\n", .{});

  var list = CircularLinkedList(u32).init(allocator);
  defer list.deinit();

  try list.append(1);
  try list.append(2);
  try list.append(3);
  try list.prepend(0);

  list.display();
  if (list.find(2)) |node| {
    std.debug.print("Found: {d}\n", .{node.data});
  }
  std.debug.print("\n", .{});
}

// ============================================================================
// SKIP LISTS
// ============================================================================
pub fn SkipList(comptime T: type) type {
  return struct {
    header: Node,
    level: usize,
    len: usize,
    allocator: std.mem.Allocator,
    rng: std.Random.DefaultPrng,

    const Self = @This();
    const MAX_LEVEL = 16;

    pub const Node = struct {
      data: T,
      forward: [MAX_LEVEL]?*Node = [_]?*Node{null} ** MAX_LEVEL,
    };

    pub fn init(allocator: std.mem.Allocator) Self {
      return Self{
        .header = Node{ .data = undefined },
        .level = 0,
        .len = 0,
        .allocator = allocator,
        .rng = std.Random.DefaultPrng.init(@intCast(std.time.timestamp())),
      };
    }

    pub fn deinit(self: *Self) void {
      var current = self.header.forward[0];
      while (current) |node| {
        const next = node.forward[0];
        self.allocator.destroy(node);
        current = next;
      }
      self.len = 0;
      self.level = 0;
    }

    fn randomLevel(self: *Self) usize {
      var level: usize = 0;
      while (self.rng.random().float(f32) < 0.5 and level < MAX_LEVEL-1) {
        level += 1;
      }
      return level;
    }

    pub fn insert(self: *Self, data: T) !void {
      var update = [_]?*Node{null} ** MAX_LEVEL;
      var current = &self.header;

      var i: isize = @intCast(self.level);
      while (i >= 0) : (i -= 1) {
        const idx = @as(usize, @intCast(i));
        while (current.forward[idx]) |forward| {
          if (forward.data >= data) break;
          current = forward;
        }
        update[idx] = current;
      }

      const new_level = self.randomLevel();
      if (new_level > self.level) {
        for (self.level + 1..new_level + 1) |lvl| {
          update[lvl] = &self.header;
        }
        self.level = new_level;
      }

      const new_node = try self.allocator.create(Node);
      new_node.* = Node{ .data = data };

      for (0..new_level + 1) |lvl| {
        new_node.forward[lvl] = update[lvl].?.forward[lvl];
        update[lvl].?.forward[lvl] = new_node;
      }
      self.len += 1;
    }

    pub fn find(self: *Self, data: T, verbose: bool) ?*Node {
      if (self.len == 0) return null;
      var current = &self.header;
      var i: isize = @intCast(self.level);
      var steps: usize = 0;

      while (i >= 0): (i -= 1) {
        const idx = @as(usize, @intCast(i));

        while (current.forward[idx]) |forward| {
          steps += 1;

          if (verbose) {
            std.debug.print("Checking {d} at Lvl {d}\n", .{forward.data, idx});
          }
          if (forward.data < data) {
            current = forward;
          } else if (forward.data == data) {
            if (verbose) {
              std.debug.print("Found {d}! Total steps: {d}\n", .{data, steps});
            }
            return forward;
          } else {
            break;
          }
        }
      }

      if (verbose) {
        std.debug.print("Search for {d} failed after {d} steps\n", .{data, steps});
      }
      return null;
    }

    pub fn display(self: *const Self) void {
      std.debug.print("Skip List (max_idx: {d}, len: {d})\n", .{ self.level, self.len });
      var i: isize = @intCast(self.level);

      while (i >= 0) : (i -= 1) {
        const lvl = @as(usize, @intCast(i));
        std.debug.print("  Level {d: >2}: ", .{lvl});

        var base_node = self.header.forward[0];
        var level_node = self.header.forward[lvl];
        var started = false;

        while (base_node) |bn| {
          const is_last_base = bn.forward[0] == null;
          if (level_node) |ln| {
            if (ln == bn) {
              started = true;
              const has_next_at_lvl = ln.forward[lvl] != null;
              if (bn.data < 10) {
                if (has_next_at_lvl) {
                  std.debug.print("{d}--", .{bn.data});
                } else {
                  std.debug.print("{d}  ", .{bn.data});
                }
              } else {
                if (has_next_at_lvl) {
                  std.debug.print("{d}-", .{bn.data});
                } else {
                  std.debug.print("{d} ", .{bn.data});
                }
              }
              level_node = ln.forward[lvl];
            } else {
              if (started) {
                std.debug.print("---", .{});
              } else {
                std.debug.print("   ", .{});
              }
            }
          } else {
            std.debug.print("   ", .{});
          }
          if (is_last_base) break;
          base_node = bn.forward[0];
        }
        std.debug.print("\n", .{});
      }
    }
  };
}

fn skipLists(allocator: std.mem.Allocator) !void {
  std.debug.print("Skip Lists\n", .{});

  var list = SkipList(u32).init(allocator);
  defer list.deinit();
  var i: u32 = 0;
  while (i < 50) : (i += 1) {
    try list.insert(i);
  }

  list.display();

  const targets = [_]u32{ 0, 28, 32, 51 };
  for (targets) |t| {
   _ =  list.find(t, true);
  }
  std.debug.print("\n", .{});
}

// ============================================================================
// SELF-ORGANIZING LISTS
// ============================================================================
pub const Heuristic = enum {
    move_to_front,
    transpose,
    frequency_count,
};

pub fn SelfOrganizingList(comptime T: type, comptime strategy: Heuristic) type {
  return struct {

    head: ?*Node = null,
    tail: ?*Node = null,
    len: usize = 0,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub const Node = struct {
      data: T,
      next: ?*Node = null,
      access_count: u32 = 0,
    };

    pub fn init(allocator: std.mem.Allocator) Self {
      return Self{ .allocator = allocator };
    }

    pub fn deinit(self: *Self) void {
      var current = self.head;
      while (current) |node| {
        const next = node.next;
        self.allocator.destroy(node);
        current = next;
      }
      self.* = undefined;
    }

    pub fn append(self: *Self, data: T) !void {
      const new_node = try self.allocator.create(Node);
      new_node.* = .{ .data = data };

      if (self.tail) |tail| {
        tail.next = new_node;
        self.tail = new_node;
      } else {
        self.head = new_node;
        self.tail = new_node;
      }
      self.len += 1;
    }

    fn insertByFrequency(self: *Self, node: *Node) void {
      var f_prev: ?*Node = null;
      var f_curr = self.head;

      while (f_curr) |curr| {
        if (node.access_count > curr.access_count) break;
        f_prev = f_curr;
        f_curr = curr.next;
      }

      if (f_prev) |p| {
        node.next = p.next;
        p.next = node;
      } else {
        node.next = self.head;
        self.head = node;
      }
      if (node.next == null) self.tail = node;
    }

    pub fn find(self: *Self, data: T) ?*Node {
      var grandparent: ?*Node = null;
      var parent: ?*Node = null;
      var current = self.head;

      while (current) |node| {
        if (std.meta.eql(node.data, data)) {
          node.access_count += 1;

          if (parent) |p| {
            switch (strategy) {
              .move_to_front => {
                p.next = node.next;
                if (node == self.tail) self.tail = p;
                node.next = self.head;
                self.head = node;
              },
              .transpose => {
                p.next = node.next;
                if (node == self.tail) self.tail = p;
                if (grandparent) |gp| {
                  gp.next = node;
                } else {
                  self.head = node;
                }
              },
              .frequency_count => {
                p.next = node.next;
                if (node == self.tail) self.tail = p;
                self.insertByFrequency(node);
              },
            }
          }
          return node;
        }
        grandparent = parent;
        parent = current;
        current = node.next;
      }
      return null;
    }

    pub fn display(self: Self) void {
      var current = self.head;
      std.debug.print("Self-Organizing List [", .{});
      while (current) |node| {
        std.debug.print("{d}({d})", .{ node.data, node.access_count });
        if (node.next != null) std.debug.print(" -> ", .{});
        current = node.next;
      }
      std.debug.print("] (len: {d})\n", .{self.len});
    }
  };
}

fn selfOrganizingLists(allocator: std.mem.Allocator) !void {
  std.debug.print("Self-Organizing Lists\n", .{});

  var list = SelfOrganizingList(u32, Heuristic.frequency_count).init(allocator);
  defer list.deinit();

  try list.append(1);
  try list.append(2);
  try list.append(3);
  try list.append(4);
  try list.append(5);

  list.display();

  // Access some elements multiple times
  _ = list.find(3);
  _ = list.find(3);
  _ = list.find(2);
  _ = list.find(3);
  _ = list.find(5);
  _ = list.find(2);

  list.display();
  std.debug.print("\n", .{});
}
