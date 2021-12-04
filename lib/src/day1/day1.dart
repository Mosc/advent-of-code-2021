import 'dart:io';

Future<void> calculate() async {
  List<String> lines = await File('./lib/assets/day1/input').readAsLines();
  List<int> depths = lines.map(int.parse).toList();
  _part1(depths);
  _part2(depths);
}

void _part1(List<int> depths) {
  int? previousDepth;
  int increases = 0;

  for (final int depth in depths) {
    if (previousDepth != null && depth > previousDepth) {
      increases++;
    }

    previousDepth = depth;
  }

  print('Part 1: $increases');
}

void _part2(List<int> depths) {
  const int windowSize = 3;
  int? previousDepth;
  int increases = 0;

  for (int i = 0; i < depths.length - windowSize + 1; i++) {
    final List<int> window = depths.sublist(i, i + windowSize);
    final int depth = window.fold(0, (previous, current) => previous + current);

    if (previousDepth != null && depth > previousDepth) {
      increases++;
    }

    previousDepth = depth;
  }

  print('Part 2: $increases');
}
