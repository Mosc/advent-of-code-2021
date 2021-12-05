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
  final List<List<int>> ventGrid = List.generate(
    height,
    (_) => List.generate(
      width,
      (_) => 0,
    ),
  );

  for (Iterable<Coordinate> vent in vents) {
    if (vent.first.x == vent.last.x) {
      final int x = vent.first.x;
      final int yStart = min(vent.first.y, vent.last.y);
      final int yEnd = max(vent.first.y, vent.last.y);

      for (int y = yStart; y <= yEnd; y++) {
        ventGrid[y][x]++;
      }
    } else if (vent.first.y == vent.last.y) {
      final int y = vent.first.y;
      final int xStart = min(vent.first.x, vent.last.x);
      final int xEnd = max(vent.first.x, vent.last.x);

      for (int x = xStart; x <= xEnd; x++) {
        ventGrid[y][x]++;
      }
    }
  }

  final int points = ventGrid
      .map((List<int> row) => row.where((int count) => count >= 2).length)
      .fold(0, (int total, int current) => total + current);
  print('Part 1: $points');
}

class Coordinate {
  const Coordinate({required this.x, required this.y});

  final int x;
  final int y;
}
