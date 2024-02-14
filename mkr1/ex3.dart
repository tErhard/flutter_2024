void main() {
  print('Число   |  Остача від ділення на 3');
  print('-------------------------------');
  
  for (int i = 3; i <= 50; i++) {
    int remainder = i % 3;
    print('$i       |  $remainder');
  }
}
