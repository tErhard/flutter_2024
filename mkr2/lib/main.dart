import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Що слід відвідати в Ужгороді',
      theme: ThemeData(
        primarySwatch: Colors.green,
         scaffoldBackgroundColor: Colors.yellow, // Задній фон жовтий
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  List<Map<String, dynamic>> places = [
    {
      'image': 'images/zamok-grafiv-shenborniv-01-900@.jpg',
      'title': 'Замок Палац',
      'description':
          'Замок Палац - одна з головних визначних пам\'яток міста Ужгород. '
              'Знаходиться на пагорбі над річкою Уж біля його злиття з річкою Ужок.'
    },
    {
      'image': 'images/stare_misto.jpg',
      'title': 'Старе Місто',
      'description':
          'Старе Місто - історичний центр Ужгорода, який вражає своєю архітектурою '
              'та колоритом. Тут можна знайти багато старовинних будівель, кафе '
              'та магазинчиків.'
    },
    {
      'image': 'images/Palats-grafiv-SHenborniv-1.jpg',
      'title': 'Парк замку Палац',
      'description':
          'Парк замку Палац - чудове місце для прогулянок та відпочинку. '
              'Тут можна насолоджуватися красивими краєвидами та зеленими насадженнями.'
    },
    {
      'image': 'images/lixtarnyk-rist1.jpg',
      'title': 'Ліхтарик Короля',
      'description':
          'Ліхтарик Короля - символ міста Ужгород. Розташований біля замку Палац, '
              'цей ліхтарик став популярною туристичною визначною точкою.'
    },
  ];

  void _nextPlace() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % places.length;
    });
  }

  void _previousPlace() {
    setState(() {
      _currentIndex = (_currentIndex - 1 + places.length) % places.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Що слід відвідати в Ужгороді'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Card(
                color: Colors.green, // Колір віджета Card зелений
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 5,
                child: Column(
                  children: [
                    Image.asset(
                      places[_currentIndex]['image'],
                      fit: BoxFit.cover,
                      height: 200,
                      width: double.infinity,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        places[_currentIndex]['title'],
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        places[_currentIndex]['description'],
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _previousPlace,
                     style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(Colors.blue), // Колір кнопки "Попередня" червоний
  ),
                    child: Text('Попередня'),
                  ),
                  ElevatedButton(
                    onPressed: _nextPlace,
                     style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(Colors.blue), // Колір кнопки "Попередня" червоний
  ),
                    child: Text('Наступна'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
