import 'dart:math';

class Point {
  final double x;
  final double y;

  Point(this.x, this.y);
}

class Polygon {
  List<Point> _vertices;

  Polygon(this._vertices);

  Point operator [](int index) => _vertices[index];

  void printVertices() {
    for (int i = 0; i < _vertices.length; i++) {
      print("Вершина ${i + 1}: (${_vertices[i].x}, ${_vertices[i].y})");
    }
  }

  void inputVertices(List<Point> vertices) {
    _vertices = vertices;
  }

  double perimeter() {
    double perimeter = 0.0;
    for (int i = 0; i < _vertices.length - 1; i++) {
      perimeter += _distance(_vertices[i], _vertices[i + 1]);
    }
    perimeter += _distance(_vertices.last, _vertices.first); // Додавання довжини останньої сторони
    return perimeter;
  }

  double area() {
    double area = 0.0;
    int j = _vertices.length - 1;
    for (int i = 0; i < _vertices.length; i++) {
      area += (_vertices[j].x + _vertices[i].x) * (_vertices[j].y - _vertices[i].y);
      j = i;
    }
    return area.abs() / 2;
  }

  double _distance(Point p1, Point p2) {
    return sqrt(pow(p2.x - p1.x, 2) + pow(p2.y - p1.y, 2));
  }
}

void main() {
  List<Point> vertices = [Point(0, 0), Point(3, 0), Point(3, 4), Point(0, 4)];
  Polygon polygon = Polygon(vertices);

  print("Вершини багатокутника:");
  polygon.printVertices();

  print("Периметр багатокутника: ${polygon.perimeter()}");
  print("Площа багатокутника: ${polygon.area()}");
}
