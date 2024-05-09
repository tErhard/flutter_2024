import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/home.dart';
import 'package:first_app/main.dart';
import 'package:first_app/phoneauth.dart';
import 'package:first_app/uihelper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'signUp.dart';
import 'forgotpasswd.dart';
import 'userdata.dart';

void main(){
  runApp(const MyApp());
}
class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'login page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  const LoginPage(),
    );
  }}

class LoginPage extends StatefulWidget{
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {
  var email=TextEditingController();
  var password=TextEditingController();

  login(String email, String password) async {
    if (email == "" || password == "") {
     customalertBox(context, "Enter Required Fields");
    }
    else{
      UserCredential? userCredential;
      try{
        userCredential=await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> const MyHomePage()));
          return null;
        });
      }
      on FirebaseAuthException catch(ex){
        return customalertBox(context, ex.code.toString());
      }

    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: email,
                  decoration: InputDecoration(
                      label:const Text('Email'),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(21)
                      )
                  ),
                ),
                const SizedBox(
                  height: 11,
                ),
          
                TextField(
                  controller: password,
                  obscureText: true,
                  decoration: InputDecoration(
                      label:const Text('Password'),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(21)
                      )
                  ),
                ),
          
          
                const SizedBox(
                  height: 11,
                ),
          
          
                ElevatedButton(onPressed: () async{
                  UserData().email = email.text.toString();
                  login(email.text.toString(), password.text.toString());
          
                  var sharedPref= await SharedPreferences.getInstance();
                  sharedPref.setBool(SplashPageState.keyLog, true);
          
          
                },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                  ), child: const Text('Login',style: TextStyle(color: Colors.white),),),
          
                const SizedBox(
                  height: 11,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(onPressed: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const Signup(),));
                    }, child: const Text("Sign Up"))
                  ],
                ),
                const SizedBox(
                  height: 11,
                ),
                TextButton(onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const ForgotPassword(),));
                },child: const Text("Forgot Password?",style: TextStyle(fontSize: 20,),)),
          
                const SizedBox(
                  height: 11,
                ),
          
                const Text("OR",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.red)),
          
                const SizedBox(
                  height: 11,
                ),
          
                TextButton(onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>const PhoneAuth(),));
                },child: const Text("Login With Mobile",style: TextStyle(fontSize: 20,),)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}