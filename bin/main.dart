import 'package:advent_of_code_2021/src/day1/day1.dart' as day1;
import 'package:advent_of_code_2021/src/day2/day2.dart' as day2;
import 'package:advent_of_code_2021/src/day3/day3.dart' as day3;

Future<void> main(List<String> arguments) async {
  print('Day 1');
  await day1.calculate();
  print('Day 2');
  await day2.calculate();
  print('Day 3');
  await day3.calculate();
}
