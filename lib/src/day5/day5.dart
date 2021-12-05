import 'dart:io';
import 'dart:math';

Future<void> calculate() async {
  final List<String> lines =
      await File('./lib/assets/day5/input').readAsLines();
  final Iterable<Iterable<Coordinate>> vents = lines.map(
    (String line) {
      return line.split(' -> ').map(
        (String section) {
          var coordinate = section.split(',').map(int.parse);
          return Coordinate(x: coordinate.first, y: coordinate.last);
        },
      );
    },
  );
  final int width = 1 +
      vents
          .map((Iterable<Coordinate> vent) =>
              vent.map((Coordinate coordinate) => coordinate.x).fold(0, max))
          .fold(0, max);
  final int height = 1 +
      vents
          .map((Iterable<Coordinate> vent) =>
              vent.map((Coordinate coordinate) => coordinate.y).fold(0, max))
          .fold(0, max);
  _part1(vents, _getGrid(height, width));
  _part2(vents, _getGrid(height, width));
}

void _part1(Iterable<Iterable<Coordinate>> vents, List<List<int>> ventGrid) {
  for (Iterable<Coordinate> vent in vents) {
    if (vent.first.x == vent.last.x || vent.first.y == vent.last.y) {
      final int length = max(
        (vent.first.x - vent.last.x).abs(),
        (vent.first.y - vent.last.y).abs(),
      );
      final int xDirection = vent.last.x.compareTo(vent.first.x);
      final int yDirection = vent.last.y.compareTo(vent.first.y);

      for (int offset = 0; offset <= length; offset++) {
        ventGrid[vent.first.y + yDirection * offset]
            [vent.first.x + xDirection * offset]++;
      }
    }
  }

  final int points = ventGrid
      .map((List<int> row) => row.where((int count) => count >= 2).length)
      .fold(0, (int total, int current) => total + current);
  print('Part 1: $points');
}

void _part2(Iterable<Iterable<Coordinate>> vents, List<List<int>> ventGrid) {
  for (Iterable<Coordinate> vent in vents) {
    final int length = max(
      (vent.first.x - vent.last.x).abs(),
      (vent.first.y - vent.last.y).abs(),
    );
    final int xDirection = vent.last.x.compareTo(vent.first.x);
    final int yDirection = vent.last.y.compareTo(vent.first.y);

    for (int offset = 0; offset <= length; offset++) {
      ventGrid[vent.first.y + yDirection * offset]
          [vent.first.x + xDirection * offset]++;
    }
  }

  final int points = ventGrid
      .map((List<int> row) => row.where((int count) => count >= 2).length)
      .fold(0, (int total, int current) => total + current);
  print('Part 2: $points');
}

List<List<int>> _getGrid(int height, int width) {
  return List.generate(
    height,
    (_) => List.generate(
      width,
      (_) => 0,
    ),
  );
}

class Coordinate {
  const Coordinate({required this.x, required this.y});

  final int x;
  final int y;
}
