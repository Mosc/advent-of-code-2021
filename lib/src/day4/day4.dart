import 'dart:io';

Future<void> calculate() async {
  final List<String> lines =
      await File('./lib/assets/day4/input').readAsLines();
  final Iterable<int> draws = lines.first.split(',').map(int.parse);
  _part1(draws, _getBoards(lines));
  _part2(draws, _getBoards(lines));
}

void _part1(Iterable<int> draws, Set<Set<Map<int, bool>>> boards) {
  Set<Map<int, bool>>? winningBoard;
  int? winningDraw;

  for (final int draw in draws) {
    for (final Set<Map<int, bool>> board in boards) {
      for (final Map<int, bool> row in board) {
        for (final int number in row.keys) {
          if (number == draw) {
            row[number] = true;
          }
        }
      }

      if (_hasMarkedRow(board) || _hasMarkedColumn(board)) {
        winningBoard = board;
        winningDraw = draw;
        break;
      }
    }

    if (winningBoard != null) {
      break;
    }
  }

  final int unmarkedSum = winningBoard!.fold(
    0,
    (int total, Map<int, bool> current) =>
        total +
        current.entries.fold(
          0,
          (int total, MapEntry<int, bool> current) =>
              total + (current.value ? 0 : current.key),
        ),
  );
  final int score = unmarkedSum * winningDraw!;
  print('Part 1: $score');
}

void _part2(Iterable<int> draws, Set<Set<Map<int, bool>>> boards) {
  Set<Set<Map<int, bool>>> winningBoards = <Set<Map<int, bool>>>{};
  Set<Map<int, bool>>? lastWinningBoard;
  int? lastWinningDraw;

  for (final int draw in draws) {
    for (final Set<Map<int, bool>> board in boards) {
      for (final Map<int, bool> row in board) {
        for (final int number in row.keys) {
          if (number == draw) {
            row[number] = true;
          }
        }
      }

      if (_hasMarkedRow(board) || _hasMarkedColumn(board)) {
        winningBoards.add(board);

        if (winningBoards.length == boards.length) {
          lastWinningBoard = board;
          lastWinningDraw = draw;
          break;
        }
      }
    }

    if (lastWinningBoard != null) {
      break;
    }
  }

  final int unmarkedSum = lastWinningBoard!.fold(
    0,
    (int total, Map<int, bool> current) =>
        total +
        current.entries.fold(
          0,
          (int total, MapEntry<int, bool> current) =>
              total + (current.value ? 0 : current.key),
        ),
  );
  final int score = unmarkedSum * lastWinningDraw!;
  print('Part 2: $score');
}

Set<Set<Map<int, bool>>> _getBoards(List<String> lines) {
  final Set<Set<Map<int, bool>>> boards = <Set<Map<int, bool>>>{};

  for (int i = 2; i < lines.length; i += 6) {
    final Set<Map<int, bool>> board = lines
        .sublist(i, i + 5)
        .map(
          (String line) =>
              line.trimLeft().split(RegExp(r'\s+')).map(int.parse).toList(),
        )
        .map(
          (List<int> row) => <int, bool>{for (int number in row) number: false},
        )
        .toSet();
    boards.add(board);
  }
  return boards;
}

bool _hasMarkedRow(Set<Map<int, bool>> board) => board.any(
      (Map<int, bool> row) => row.values.every(
        (bool marked) => marked,
      ),
    );

bool _hasMarkedColumn(Set<Map<int, bool>> board) {
  for (int column = 0; column < board.first.length; column++) {
    if (board.every((Map<int, bool> row) => row.values.elementAt(column))) {
      return true;
    }
  }

  return false;
}
