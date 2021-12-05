import 'dart:io';

Future<void> calculate() async {
  final List<String> lines =
      await File('./lib/assets/day3/input').readAsLines();
  final List<List<int>> parsedLines = lines
      .map((String line) => line.split('').map(int.parse).toList())
      .toList();

  assert(lines.isNotEmpty);
  assert(lines.map((String line) => line.length).toSet().length == 1);

  for (final String line in lines) {
    assert(RegExp(r'^[01]+$').hasMatch(line));
  }

  _part1(parsedLines);
  _part2(parsedLines);
}

void _part1(List<List<int>> bitLines) {
  final int columnLength = bitLines.first.length;
  int gamma = 0;
  int epsilon = 0;

  for (int column = 0; column < columnLength; column++) {
    final Prevalence<int> prevalence = _calculatePrevalence(bitLines, column);
    final int shift = columnLength - column - 1;
    gamma += prevalence.most.key << shift;
    epsilon += prevalence.least.key << shift;
  }

  final int result = gamma * epsilon;
  print('Part 1: $result');
}

void _part2(List<List<int>> bitLines) {
  final int columnLength = bitLines.first.length;
  int oxygenRating = 0;
  int co2Rating = 0;
  List<List<int>> oxygenCandidates = <List<int>>[...bitLines];
  List<List<int>> co2Candidates = <List<int>>[...bitLines];

  for (int column = 0; column < columnLength; column++) {
    final Prevalence<int> oxygenPrevalence =
        _calculatePrevalence(oxygenCandidates, column);
    final Prevalence<int> co2Prevalence =
        _calculatePrevalence(co2Candidates, column);

    if (oxygenCandidates.length > 1) {
      oxygenCandidates = oxygenCandidates
          .where((List<int> bitLine) =>
              bitLine[column] ==
              (oxygenPrevalence.same ? 1 : oxygenPrevalence.most.key))
          .toList();
    }

    if (co2Candidates.length > 1) {
      co2Candidates = co2Candidates
          .where((List<int> bitLine) =>
              bitLine[column] ==
              (co2Prevalence.same ? 0 : co2Prevalence.least.key))
          .toList();
    }
  }

  for (int column = 0; column < columnLength; column++) {
    final int shift = columnLength - column - 1;
    oxygenRating += oxygenCandidates.single[column] << shift;
    co2Rating += co2Candidates.single[column] << shift;
  }

  final int result = oxygenRating * co2Rating;
  print('Part 2: $result');
}

Prevalence<int> _calculatePrevalence(List<List<int>> bitLines, int column) {
  final Map<int, int> occurences = {
    0: 0,
    1: 0,
  };

  for (int row = 0; row < bitLines.length; row++) {
    final int bit = bitLines[row][column];
    occurences[bit] = occurences[bit]! + 1;
  }

  final List<MapEntry<int, int>> sortedOccurences = occurences.entries.toList()
    ..sort((MapEntry<int, int> a, MapEntry<int, int> b) =>
        b.value.compareTo(a.value));
  return Prevalence(
    most: sortedOccurences.first,
    least: sortedOccurences.last,
  );
}

class Prevalence<T> {
  const Prevalence({required this.most, required this.least});

  final MapEntry<T, int> most;
  final MapEntry<T, int> least;

  bool get same => most.value == least.value;
}
