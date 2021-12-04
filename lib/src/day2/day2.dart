import 'dart:io';

Future<void> calculate() async {
  List<String> lines = await File('./lib/assets/day2/input').readAsLines();
  int horizontal = 0;
  int depth = 0;

  for (final String line in lines) {
    final List<String> split = line.split(' ');
    final String direction = split[0];
    final int amount = int.parse(split[1]);

    switch (direction) {
      case 'forward':
        horizontal += amount;
        break;
      case 'down':
        depth += amount;
        break;
      case 'up':
        depth -= amount;
        break;
    }
  }

  final int result = horizontal * depth;
  print('Part 1: $result');
}
