import 'dart:async';
import 'dart:io';
import 'package:first_app/home.dart';
import 'package:first_app/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
Platform.isAndroid? await Firebase.initializeApp(
  options:const FirebaseOptions(
      apiKey: "AIzaSyAqdXlfKc9qBV8qQ7iqeb156WHC4u7t4dk",
      appId: "1:831776051847:android:5f5e4d97ae3c1b6ed31e22",
      messagingSenderId: "831776051847",
      projectId: "first-app-c5553",
      storageBucket: "gs://first-app-c5553.appspot.com",
  )):await Firebase.initializeApp();

  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SHASHANK BMI',
      debugShowCheckedModeBanner: false,
      color: Colors.purple,
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
        useMaterial3: true,
      ),
      home: const SplashPage(),
    );
  }
}

class SplashPage extends StatefulWidget {
  const SplashPage({super.key,});

  @override
  State<SplashPage> createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  static const String keyLog ="Login";

  @override
  void initState(){
    super.initState();
    whereToGo(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.blue,
          child: const Icon(Icons.account_circle,color: Colors.white,size: 200,),
        ),
      ),
    );
  }
}

void whereToGo(BuildContext context) async{
  var sharedPref=await SharedPreferences.getInstance();
  var isLoggedIn = sharedPref.getBool(SplashPageState.keyLog);

  Timer(const Duration(seconds: 2),(){

    if(isLoggedIn != null){
      if(isLoggedIn){
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const MyHomePage(),));
      }
      else{
        Navigator.pushReplacement(context ,
            MaterialPageRoute(builder: (context) =>  const LoginPage(),));
      }
    }else{
      Navigator.pushReplacement(context ,
          MaterialPageRoute(builder: (context) =>  const LoginPage(),));
    }

  }

  );

}