import 'dart:io';

class TArProgression {
  late double _firstElement;
  late double _difference;

  TArProgression() {
    this._firstElement = 0.0;
    this._difference = 0.0;
  }

  TArProgression.withParams(double firstElement, double difference) {
    this._firstElement = firstElement;
    this._difference = difference;
  }

  TArProgression.copy(TArProgression other) {
    this._firstElement = other._firstElement;
    this._difference = other._difference;
  }

  void input() {
    print("Введіть перший член арифметичної прогресії:");
    _firstElement = double.parse(stdin.readLineSync()!);

    print("Введіть різницю арифметичної прогресії:");
    _difference = double.parse(stdin.readLineSync()!);
  }

  void output() {
    print("Перший член: $_firstElement");
    print("Різниця: $_difference");
  }

  double getEleventhElement() {
    return _firstElement + 10 * _difference;
  }

  double getSumOfElevenElements() {
    double n = 11;
    return n / 2 * (_firstElement + getEleventhElement());
  }
}

void main() {
  var progression = TArProgression();

  progression.input();

  progression.output();

  var eleventhElement = progression.getEleventhElement();
  print("11-й член: $eleventhElement");

  var sumOfElevenElements = progression.getSumOfElevenElements();
  print("Сума 11 перших членів: $sumOfElevenElements");
}
