void main() {
  List<double> vector = [5, 10, 15, 20, 25, 30, 35, 40, 45, 50];
  
  print('Вхідний вектор: $vector');
  
  replaceAboveAverage(vector);
  
  print('Вектор після заміни: $vector');
}

void replaceAboveAverage(List<double> vector) {
  double sum = 0;
  int count = 0;
  
  for (double element in vector) {
    sum += element;
    count++;
  }
  double average = sum / count;
  
  for (int i = 0; i < vector.length; i++) {
    if (vector[i] > average) {
      vector[i] = 0;
    }
  }
}
