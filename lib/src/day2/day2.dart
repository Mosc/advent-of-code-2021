import 'dart:io';

Future<void> calculate() async {
  final List<String> lines =
      await File('./lib/assets/day2/input').readAsLines();
  final List<Command> commands = lines.map((String line) {
    final List<String> split = line.split(' ');
    return Command(
      direction: split[0],
      amount: int.parse(split[1]),
    );
  }).toList();
  _part1(commands);
  _part2(commands);
}

void _part1(List<Command> commands) {
  int horizontal = 0;
  int depth = 0;

  for (final Command command in commands) {
    switch (command.direction) {
      case 'forward':
        horizontal += command.amount;
        break;
      case 'down':
        depth += command.amount;
        break;
      case 'up':
        depth -= command.amount;
        break;
    }
  }

  final int result = horizontal * depth;
  print('Part 1: $result');
}

void _part2(List<Command> commands) {
  int aim = 0;
  int horizontal = 0;
  int depth = 0;

  for (final Command command in commands) {
    switch (command.direction) {
      case 'forward':
        horizontal += command.amount;
        depth += aim * command.amount;
        break;
      case 'down':
        aim += command.amount;
        break;
      case 'up':
        aim -= command.amount;
        break;
    }
  }

  final int result = horizontal * depth;
  print('Part 2: $result');
}

class Command {
  const Command({required this.direction, required this.amount});

  final String direction;
  final int amount;
}
