import 'dart:io';

Future<void> calculate() async {
  List<String> lines = await File('./lib/assets/day1/input').readAsLines();
  int? previousDepth;
  int increases = 0;

  for (final String line in lines) {
    int currentDepth = int.parse(line);

    if (previousDepth != null && currentDepth > previousDepth) {
      increases++;
    }

    previousDepth = currentDepth;
  }

  print(increases);
}
