import 'dart:io';

Future<void> calculate() async {
  final List<String> lines =
      await File('./lib/assets/day4/input').readAsLines();
  final Iterable<int> draws = lines.first.split(',').map(int.parse);
  final List<List<Map<int, bool>>> boards = <List<Map<int, bool>>>[];
  List<Map<int, bool>>? winningBoard;
  int? winningDraw;

  for (int i = 2; i < lines.length; i += 6) {
    final List<Map<int, bool>> board = lines
        .sublist(i, i + 5)
        .map(
          (String line) =>
              line.trimLeft().split(RegExp(r'\s+')).map(int.parse).toList(),
        )
        .map(
          (List<int> row) => <int, bool>{for (int number in row) number: false},
        )
        .toList();
    boards.add(board);
  }

  for (final int draw in draws) {
    for (final List<Map<int, bool>> board in boards) {
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
    (int previous, Map<int, bool> current) =>
        previous +
        current.entries.fold(
          0,
          (int previous, MapEntry<int, bool> current) =>
              previous + (current.value ? 0 : current.key),
        ),
  );
  final int result = unmarkedSum * winningDraw!;
  print('Part 1: $result');
}

bool _hasMarkedRow(List<Map<int, bool>> board) => board.any(
      (Map<int, bool> row) => row.values.every(
        (bool marked) => marked,
      ),
    );

bool _hasMarkedColumn(List<Map<int, bool>> board) {
  for (int column = 0; column < board.first.length; column++) {
    if (board.every((Map<int, bool> row) => row.values.elementAt(column))) {
      return true;
    }
  }

  return false;
}
