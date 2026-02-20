const std = @import("std");

const ModelType = enum { power_law, log_linear };

const SortFn = struct {
  name: []const u8,
  func: *const fn (allocator: std.mem.Allocator, items: []i32) anyerror!void,
  model: ModelType,
};

const RegressionResult = struct {
  c: f64, // The constant
  r2: f64, // R-square
};

const wrappers = struct {
  fn bubble(_: std.mem.Allocator, items: []i32) anyerror!void { bubbleSortOptimized(i32, items); }
  fn insertion(_: std.mem.Allocator, items: []i32) anyerror!void { insertionSort(i32, items); }
  fn selection(_: std.mem.Allocator, items: []i32) anyerror!void { selectionSort(i32, items); }
  fn mergeRecursive(alloc: std.mem.Allocator, items: []i32) anyerror!void { try mergeSortRecursive(i32, alloc, items); }
  fn mergeIterative(alloc: std.mem.Allocator, items: []i32) anyerror!void { try mergeSortIterative(i32, alloc, items); }
  fn quick(_: std.mem.Allocator, items: []i32) anyerror!void { quickSort(i32, items); }
  fn quickHybrid(_: std.mem.Allocator, items: []i32) anyerror!void { quickSortHybrid(i32, items); }
  fn quickIterative(_: std.mem.Allocator, items: []i32) anyerror!void {quickSortIterative(i32, items); }
  fn heap(_: std.mem.Allocator, items: []i32) anyerror!void {heapSort(i32, items); }
  fn intro(_: std.mem.Allocator, items: []i32) anyerror!void {introSort(i32, items); }
  fn tim(alloc: std.mem.Allocator, items: []i32) anyerror!void {try timSort(i32, alloc, items); }
  fn pdq(_: std.mem.Allocator, items: []i32) anyerror!void {pdqSort(i32, items); }
};

fn performRegression(sizes: []const usize, times: []u64, model: ModelType) RegressionResult {
  const n = @as(f64, @floatFromInt(sizes.len));

  switch (model) {
    .log_linear => {
      var sum_ty: f64 = 0;
      var sum_yy: f64 = 0;
      var sum_t: f64 = 0;

      for (sizes, times) |size, time| {
        const x = @as(f64, @floatFromInt(size));
        const t = @as(f64, @floatFromInt(time));
        const y = x * std.math.log2(x);

        sum_ty += t*y;
        sum_yy += y*y;
        sum_t  += t;
      }

      const c = sum_ty / sum_yy;
      const mean_t = sum_t / n;

      var ss_res: f64 = 0;
      var ss_tot: f64 = 0;
      for (sizes, times) |size, time| {
        const x = @as(f64, @floatFromInt(size));
        const t = @as(f64, @floatFromInt(time));
        const pred = c * (x * std.math.log2(x));

        ss_res += (t - pred) * (t - pred);
        ss_tot += (t - mean_t) * (t - mean_t);
      }

      const r2 = 1.0 - (ss_res / ss_tot);
      return .{ .c = c, .r2 = r2 };
    },
    .power_law => {
      var sum_ty: f64 = 0;
      var sum_yy: f64 = 0;
      var sum_t: f64 = 0;

      for (sizes, times) |size, time| {
        const x = @as(f64, @floatFromInt(size));
        const t = @as(f64, @floatFromInt(time));
        const y = x*x;
        sum_ty += t*y;
        sum_yy += y*y;
        sum_t += t;
      }

      const c = sum_ty / sum_yy;
      const mean_t = sum_t / n;

      var ss_res: f64 = 0;
      var ss_tot: f64 = 0;
      for (sizes, times) |size, time| {
        const x = @as(f64, @floatFromInt(size));
        const t = @as(f64, @floatFromInt(time));
        const pred = c * (x * x);

        ss_res += (t - pred) * (t - pred);
        ss_tot += (t - mean_t) * (t - mean_t);
      }

      const r2 = 1.0 - (ss_res / ss_tot);
      return .{ .c = c, .r2 = r2 };
    },
  }
}

fn generateRandomArray(allocator: std.mem.Allocator, size: usize, rand: std.Random) ![]i32 {
  const array = try allocator.alloc(i32, size);
  for (array) |*v| {
    v.* = rand.int(i32);
  }
  return array;
}

fn benchmarkAlgorithm(allocator: std.mem.Allocator, alg: SortFn, base_arrays: [][]i32) !u64 {
  var total: u128 = 0;
  const iterations = base_arrays.len;

  for (base_arrays) |base| {
    const arr = try allocator.dupe(i32, base);
    defer allocator.free(arr);

    var timer = try std.time.Timer.start();
    try alg.func(allocator, arr);
    const elapsed = timer.read();
    total += elapsed;
  }

  return @intCast(total / iterations);
}

fn plotAll(allocator: std.mem.Allocator, sizes: []const usize, results: [][]u64, algorithms: []const SortFn) !void {
  var child = std.process.Child.init(&.{ "gnuplot" }, allocator);
  child.stdin_behavior = .Pipe;
  try child.spawn();

  var script = std.ArrayList(u8){};
  defer script.deinit(allocator);

  const w = script.writer(allocator);

  try w.writeAll(
    \\set terminal pngcairo size 1000,600
    \\set output "benchmark.png"
    \\set title "Sorting Algorithms Benchmark (Log-Log)"
    \\set xlabel "Array Size"
    \\set ylabel "Time (ns)"
    \\set logscale xy
    \\set grid
    \\plot
  );

  // plot headers
  for (algorithms, 0..) |alg, i| {
    try w.print("'-' with linespoints linewidth 2 title '{s}'", .{alg.name});
    if (i < algorithms.len - 1) {
      try w.writeAll(", \\\n"); // The \ is followed immediately by \n
    } else {
      try w.writeAll("\n");
    }
  }

  // data blocks
  for (results) |res| {
    for (sizes, 0..) |n, i| {
      try w.print("{d} {d}\n", .{ n, res[i] });
    }
    try w.writeAll("e\n");
  }

  try child.stdin.?.writeAll(script.items);
  child.stdin.?.close();
  child.stdin = null;

  _ = try child.wait();
}

fn benchmarkAll(iterations: usize) !void {
  var gpa = std.heap.GeneralPurposeAllocator(.{}){};
  defer _ = gpa.deinit();
  const allocator = gpa.allocator();

  var seed: u64 = undefined;
  try std.posix.getrandom(std.mem.asBytes(&seed));
  var prng = std.Random.DefaultPrng.init(seed);
  const rand = prng.random();

  const algorithms = [_]SortFn{
    .{ .name = "Bubble", .func = wrappers.bubble, .model = ModelType.power_law },
    .{ .name = "Insertion", .func = wrappers.insertion, .model = ModelType.power_law },
    .{ .name = "Selection", .func = wrappers.selection, .model = ModelType.power_law },
    .{ .name = "Merge", .func = wrappers.mergeRecursive, .model = ModelType.log_linear },
    .{ .name = "Merge Iterative", .func = wrappers.mergeIterative, .model = ModelType.log_linear },
    .{ .name = "Quick", .func = wrappers.quick, .model = ModelType.log_linear },
    .{ .name = "Quick Hybrid", .func = wrappers.quickHybrid, .model = ModelType.log_linear },
    .{ .name = "Quick Iterative", .func = wrappers.quickIterative, .model = ModelType.log_linear },
    .{ .name = "Heap", .func = wrappers.heap, .model = ModelType.log_linear },
    .{ .name = "Intro", .func = wrappers.intro, .model = ModelType.log_linear },
    .{ .name = "Tim", .func = wrappers.tim, .model = ModelType.log_linear },
    .{ .name = "PDQ", .func = wrappers.pdq, .model = ModelType.log_linear },
  };

  const sizes = [_]usize{16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192};

  // results[algorithm][size]
  var results = try allocator.alloc([]u64, algorithms.len);
  defer allocator.free(results);
  for (results) |*r| r.* = try allocator.alloc(u64, sizes.len);
  defer for (results) |r| allocator.free(r);

  for (sizes, 0..) |n, si| {
    std.debug.print("\nArray size: {d}\n", .{n});

    // Pre-generate identical test cases for this size
    const test_cases = try allocator.alloc([]i32, iterations);
    for (test_cases) |*t| t.* = try generateRandomArray(allocator, n, rand);
    defer {
      for (test_cases) |t| allocator.free(t);
      allocator.free(test_cases);
    }

    for (algorithms, 0..) |alg, ai| {
      const avg = try benchmarkAlgorithm(allocator,alg, test_cases);
      results[ai][si] = avg;
      std.debug.print("{s:<15} {d:>12} ns\n", .{ alg.name, avg });
    }
  }

  std.debug.print("\n--- Complexity Analysis ---\n\n", .{});
  std.debug.print("{s:<15} | {s:<12} | {s:>1} (C) | {s:>1} (R²) |\n", .{ "Algorithm", "Model", "Constant", "Fit" });
  std.debug.print("{s:-<15}-|-{s:-<12}-|-{s:-<12}-|-{s:-<8}-|\n", .{ "", "", "", "" });

  for (algorithms, 0..) |alg, ai| {
    const reg = performRegression(sizes[0..], results[ai], alg.model);
    const model_name = switch (alg.model) {
      .power_law => "C*n²",
      .log_linear => "C*n*log(n)",
    };
    std.debug.print("{s:<15} | {s:<12} | {e:>12.2} | {d:>8.3} |\n", .{
      alg.name, model_name, reg.c, reg.r2
    });
  }

  try plotAll(allocator, sizes[0..], results, algorithms[0..]);

  std.debug.print(
    "\nBenchmark complete. Output written to benchmark.png\n",
    .{},
  );
}

fn checkSorted(comptime T: type, items: []const T, name: []const u8) !void {
  for (items[0 .. items.len - 1], 0..) |val, i| {
    if (val > items[i + 1]) {
      std.debug.print("❌ {s} failed! Index {d}: {d} > {d}\n", .{ name, i, val, items[i + 1] });
      return error.TestFailed;
    }
  }
}

fn verifyAlgorithms() !void {
  const allocator = std.heap.page_allocator;
  const items = [_]i8{ 42, -10, 0, 120, -128, 55, 3, 9, 11, -1, 4, 8, 2, 7, 6, 5 };

  // List of functions that don't require an allocator
  const simple_sorts = .{
    .{ .name = "Bubble", .f = bubbleSortOptimized },
    .{ .name = "Insertion", .f = insertionSort },
    .{ .name = "Selection", .f = selectionSort },
    .{ .name = "Quick", .f = quickSort },
    .{ .name = "Quick Hybrid", .f = quickSortHybrid },
    .{ .name = "Quick Iterative", .f = quickSortIterative },
    .{ .name = "Heap", .f = quickSortIterative },
    .{ .name = "Intro", .f = introSort },
    .{ .name = "PDQ", .f = pdqSort },
  };

  inline for (simple_sorts) |sort| {
    var data = items;
    sort.f(i8, &data);
    try checkSorted(i8, &data, sort.name);
  }

  // List of functions that DO require an allocator
  const alloc_sorts = .{
    .{ .name = "Merge Recursive", .f = mergeSortRecursive },
    .{ .name = "Merge Iterative", .f = mergeSortIterative },
    .{ .name = "Tim", .f = timSort },
  };

  inline for (alloc_sorts) |sort| {
    var data = items;
    try sort.f(i8, allocator, &data);
    try checkSorted(i8, &data, sort.name);
  }

  std.debug.print("✅ All algorithms verified correctly on i8[16]\n", .{});
}

pub fn main() !void {
  try verifyAlgorithms();
  try benchmarkAll(100);
  try std.fs.File.stdout().writeAll("\nPress Enter to exit...");

  var buffer: [10]u8 = undefined;
  var stdin_reader = std.fs.File.stdin().reader(&buffer);

   _ = stdin_reader.interface.takeDelimiterExclusive('\n') catch |err| switch (err) {
    error.EndOfStream => {},
    else => return err,
  };
}

fn bubbleSortOptimized(comptime T: type, items: []T) void {
  const n = items.len;
  if (n < 2) return;

  var i: usize = 0;
  while ( i < n-1 ) : ( i += 1 ) {
    var swapped = false;
    var j: usize = 0;
    while (j < n-i-1): (j += 1) {
      if (items[j] > items[j+1]) {
        const temp = items[j];
        items[j] = items[j+1];
        items[j+1] = temp;
        swapped = true;
      }
    }
    // Optimized: If no elements were swapped, then break;
    if (!swapped) break;
  }
}

fn insertionSort(comptime T: type, items: []T) void {
  const n = items.len;
  if (n < 2) return;

  for (1..n) |i| {
    const key = items[i];
    var j = i;
    while (j > 0 and items[j-1] > key) : (j -= 1) {
      items[j] = items[j-1];
    }
    items[j] = key;
  }
}

fn selectionSort(comptime T: type, items: []T) void {
  const n = items.len;
  if (n < 2) return;

  for (0..n-1) |i| {
    var id_min = i;
    for (i+1..n) |j| {
      if (items[j] < items[id_min]) {
        id_min = j;
      }
    }
    if (id_min != i) {
      const temp = items[i];
      items[i] = items[id_min];
      items[id_min] = temp;
    }
  }
}

fn mergeSortRecursive(comptime T: type, allocator: std.mem.Allocator, items: []T) !void {
  const n = items.len;
  if (n < 2) return;

  const buffer = try allocator.alloc(T, n);
  defer allocator.free(buffer);

  @memcpy(buffer, items);
  // We merge FROM buffer INTO items.
  tryMerge(T, buffer, items, 0, n);
}

fn tryMerge(comptime T: type, source: []T, dest: []T, start: usize, end: usize) void {
    if (end - start < 2) return;

    const mid = start + (end - start) / 2;

    // Flip source/dest so the children merge into the 'source'
    tryMerge(T, dest, source, start, mid);
    tryMerge(T, dest, source, mid, end);

    // Now merge from source into dest
    var i = start;
    var j = mid;
    var k = start;

    while (i < mid and j < end) : (k += 1) {
      if (source[i] <= source[j]) {
        dest[k] = source[i];
        i += 1;
      } else {
        dest[k] = source[j];
        j += 1;
      }
    }

    while (i < mid) : ({ i += 1; k += 1; }) dest[k] = source[i];
    while (j < end) : ({ j += 1; k += 1; }) dest[k] = source[j];
}

fn mergeSortIterative(comptime T: type, allocator: std.mem.Allocator, items: []T) !void {
  const n = items.len;
  if (n < 2) return;

  const buffer = try allocator.alloc(T, n);
  defer allocator.free(buffer);

  var src = items;
  var dst = buffer;

  var width: usize = 1;
  while (width < n) : (width *= 2) {
    var i: usize = 0;
    while (i < n) : (i += 2 * width) {
      const left = i;
      const mid = @min(i + width, n);
      const right = @min(i + 2 * width, n);

      // Merge logic
      var l = left;
      var r = mid;
      var k = left;

      while (l < mid and r < right) : (k += 1) {
        if (src[l] <= src[r]) {
          dst[k] = src[l];
          l += 1;
        } else {
          dst[k] = src[r];
          r += 1;
        }
      }
      while (l < mid) : ({ l += 1; k += 1; }) dst[k] = src[l];
      while (r < right) : ({ r += 1; k += 1; }) dst[k] = src[r];
    }

    // Swap roles for the next level: what was destination becomes source
    const temp = src;
    src = dst;
    dst = temp;
  }

  // After the loop, the sorted data might be in the 'buffer'.
  if (src.ptr != items.ptr) {
    @memcpy(items, src);
  }
}

fn partition(comptime T: type, items: []T) usize {
  const n = items.len;
  const mid = n/2;

  // median of three
  if (items[0] > items[mid]) std.mem.swap(T, &items[0], &items[mid]);
  if (items[0] > items[n-1]) std.mem.swap(T, &items[0], &items[n-1]);
  if (items[n-1] > items[mid]) std.mem.swap(T, &items[mid], &items[n-1]);

  // items[0] <= items[n-1] <= items[mid]
  const pivot = items[n-1];
  var i: usize = 0;

  for (0..n-1) |j| {
    if (items[j] < pivot) {
      if (i != j) {
        std.mem.swap(T, &items[j], &items[i]);
      }
      i += 1;
    }
  }

  std.mem.swap(T, &items[i], &items[n-1]);
  return i;
}

fn quickSort(comptime T: type, items: []T) void {
  const n = items.len;
  if (n < 2) return;

  const pivot_idx = partition(T, items);
  quickSort(T, items[0..pivot_idx]);
  quickSort(T, items[pivot_idx+1..]);
}

fn quickSortHybrid(comptime T: type, items: []T) void {
  const n = items.len;
  const MIN_RUN = 16;
  if (n <= MIN_RUN) {
    insertionSort(T, items);
    return;
  }

  const pivot_idx = partition(T, items);
  quickSortHybrid(T, items[0..pivot_idx]);
  quickSortHybrid(T, items[pivot_idx+1..]);

}

fn quickSortIterative(comptime T: type, items: []T) void {
  const n = items.len;
  if (n < 2) return;

  const Range = struct { low: usize, high: usize };
  // A stack of 64 can handle 2^64 elements with log(n) depth
  var stack: [64]Range = undefined;
  var top: usize = 0;

  stack[top] = .{ .low = 0, .high = n - 1 };
  top += 1;

  while (top > 0) {
    top -= 1;
    const range = stack[top];
    const low = range.low;
    const high = range.high;

    // Partition the current slice
    const p_idx = partition(T, items[low .. high + 1]) + low;

    // Calculate partition sizes
    const left_len = if (p_idx > low) p_idx - low else 0;
    const right_len = if (high > p_idx) high - p_idx else 0;

    // Smaller-side first optimization:
    // Push the LARGER side to the stack, process the SMALLER side next.
    if (left_len > right_len) {
      if (left_len > 1) {
        stack[top] = .{ .low = low, .high = p_idx - 1 };
        top += 1;
      }
      if (right_len > 1) {
        stack[top] = .{ .low = p_idx + 1, .high = high };
        top += 1;
      }
    } else {
      if (right_len > 1) {
        stack[top] = .{ .low = p_idx + 1, .high = high };
        top += 1;
      }
      if (left_len > 1) {
        stack[top] = .{ .low = low, .high = p_idx - 1 };
        top += 1;
      }
    }
  }
}

fn heapSort(comptime T: type, items: []T) void {
    const n = items.len;
    if (n < 2) return;

    // Build Max-Heap (rearrange array)
    // We start from the last non-leaf node and sift down
    var i: usize = n / 2;
    while (i > 0): (i -= 1) {
        siftDown(T, items, i-1, n);
    }

    // Extract elements from heap one by one
    var end: usize = n - 1;
    while (end > 0): (end -= 1) {
        // Move current root to end (it's the largest)
        std.mem.swap(T, &items[0], &items[end]);
        // Sift down the new root to maintain heap property
        siftDown(T, items, 0, end);
    }
}

fn siftDown(comptime T: type, items: []T, start: usize, end: usize) void {
  var root = start;

  while (root * 2 + 1 < end) {
    const left_child = root * 2 + 1;
    const right_child = left_child + 1;
    var swap_idx = root;

    // Compare root with left child
    if (items[swap_idx] < items[left_child]) {
      swap_idx = left_child;
    }
    // Compare with right child (if it exists)
    if (right_child < end and items[swap_idx] < items[right_child]) {
      swap_idx = right_child;
    }
    // If root is larger than children, we are done
    if (swap_idx == root) return;
    std.mem.swap(T, &items[root], &items[swap_idx]);
    root = swap_idx; // Continue sifting down
    }
}

fn introSort(comptime T: type, items: []T) void {
  const n = items.len;
  if (n < 2) return;
  const max_depth = std.math.log2(n) * 2;
  introsortRecursive(T, items, max_depth);
}

fn introsortRecursive(comptime T: type, items: []T, depth_limit: usize) void {
  const n = items.len;
  const MIN_RUN = 16;
  if (n <= MIN_RUN) {
    insertionSort(T, items);
    return;
  }

  if (depth_limit == 0) {
    heapSort(T, items);
    return;
  }

  const p_idx = partition(T, items);
  introsortRecursive(T, items[0..p_idx], depth_limit - 1);
  introsortRecursive(T, items[p_idx + 1 ..], depth_limit - 1);
}

fn timSort(comptime T: type, allocator: std.mem.Allocator, items: []T) !void {
  const n = items.len;
  if (n < 2) return;

  const MIN_RUN: usize = 16;

  // Initial insertionSort
  var i: usize = 0;
  while (i < n) : (i += MIN_RUN) {
    insertionSort(T, items[i..@min(i + MIN_RUN, n)]);
  }

  // Prepare buffer (Ping-Pong strategy)
  const buffer = try allocator.alloc(T, n);
  defer allocator.free(buffer);

  var src = items;
  var dst = buffer;

  var size = MIN_RUN;
  while (size < n) : (size *= 2) {
    var left: usize = 0;
    while (left < n) : (left += 2 * size) {
      const mid = @min(left + size, n);
      const right = @min(left + 2 * size, n);

      if (mid < right) {
        mergeNoCopy(T, src, dst, left, mid, right);
      } else {
        @memcpy(dst[left..right], src[left..right]);
      }
    }

    // Swap src et dst for next level (Ping-Pong)
    const temp = src;
    src = dst;
    dst = temp;
  }

  // Ensure sort data in src
  if (src.ptr != items.ptr) {
    @memcpy(items, src);
  }
}

// Tim Fusion
fn mergeNoCopy(comptime T: type, source: []T, dest: []T, l: usize, m: usize, r: usize) void {
  var i = l; // index left in source
  var j = m; // index right in source
  var k = l; // index write in dest

  while (i < m and j < r) : (k += 1) {
    if (source[i] <= source[j]) {
      dest[k] = source[i];
      i += 1;
    } else {
      dest[k] = source[j];
      j += 1;
    }
  }

  // Don't forget
  while (i < m) : ({ i += 1; k += 1; }) dest[k] = source[i];
  while (j < r) : ({ j += 1; k += 1; }) dest[k] = source[j];
}

fn pdqSort(comptime T: type, items: []T) void {
  const n = items.len;
  if (n < 2) return;
  const limit = std.math.log2(n);
  pdqSortRecursive(T, items, limit, true);
}

fn pdqSortRecursive(comptime T: type, items: []T, limit: usize, was_balanced: bool) void {
  var slice = items;
  while (slice.len > 16) {
    if (limit == 0) {
      heapSort(T, slice);
      return;
    }

    const p_idx = partition(T, slice);
    const left = slice[0..p_idx];
    const right = slice[p_idx + 1 ..];

    // Détection de déséquilibre (si une partition est trop petite)
    const is_unbalanced = left.len < slice.len / 8 or right.len < slice.len / 8;

    if (is_unbalanced) {
      // Si on est trop déséquilibré, on réduit la limite de profondeur
      // et on mélange légèrement ou on change de pivot (stratégie PDQ)
      std.mem.swap(T, &slice[0], &slice[slice.len/4]);
      pdqSortRecursive(T, left, limit - 1, false);
      slice = right;
    } else {
      pdqSortRecursive(T, left, limit - 1, was_balanced);
      slice = right;
    }
  }
  insertionSort(T, slice);
}
