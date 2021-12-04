import 'dart:io';

Future<void> calculate() async {
  final List<String> lines =
      await File('./lib/assets/day3/input').readAsLines();

  assert(lines.isNotEmpty);
  assert(lines.map((String line) => line.length).toSet().length == 1);

  for (final String line in lines) {
    assert(RegExp(r'^[01]+$').hasMatch(line));
  }

  final int columnLength = lines.first.length;
  int gamma = 0;
  int epsilon = 0;

  for (int column = 0; column < columnLength; column++) {
    final Map<int, int> occurences = {
      0: 0,
      1: 0,
    };

    for (int row = 0; row < lines.length; row++) {
      final int bit = int.parse(lines[row][column]);
      occurences[bit] = occurences[bit]! + 1;
    }

    final List<MapEntry<int, int>> sortedOccurences = occurences.entries
        .toList()
      ..sort((MapEntry<int, int> a, MapEntry<int, int> b) =>
          b.value.compareTo(a.value));
    final int shift = columnLength - column - 1;
    gamma += sortedOccurences.first.key << shift;
    epsilon += sortedOccurences.last.key << shift;
  }

  final int result = gamma * epsilon;
  print(result);
}
