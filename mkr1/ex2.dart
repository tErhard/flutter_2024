import 'dart:io';

void main() {
  print('Введіть номер дня тижня (1-7):');
  int dayNumber = int.parse(stdin.readLineSync()!);

  String dayName = getDayName(dayNumber);
  print('Назва дня тижня: $dayName');
}

String getDayName(int dayNumber) {
  switch (dayNumber) {
    case 1:
      return 'Понеділок';
    case 2:
      return 'Вівторок';
    case 3:
      return 'Середа';
    case 4:
      return 'Четвер';
    case 5:
      return 'П`ятниця';
    case 6:
      return 'Субота';
    case 7:
      return 'Неділя';
    default:
      return 'Невірний номер дня';
  }
}
