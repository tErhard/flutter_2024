import 'package:first_app/home.dart';
import 'uihelper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();

  signUp(String email, String password) async {
    if (email == "" || password == "") {
     customalertBox(context, "Enter Required Fields");
    }
    else{
       UserCredential? userCredential;
       try{
         userCredential=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value){
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
        title: const Text("Sign Up"),
      ),
      body: Center(
        child: SizedBox(
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: emailC,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(21),
                  ),
                ),
              ),
              const SizedBox(
                height: 11,
              ),
              TextField(
                controller: passwordC,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(21),
                  ),
                ),
              ),
              const SizedBox(
                height: 11,
              ),
              ElevatedButton(
                onPressed: () {
                  signUp(emailC.text.toString(), passwordC.text.toString());
                },
                child: const Text('Sign Up'),
              ),
              const SizedBox(
                height: 11,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
