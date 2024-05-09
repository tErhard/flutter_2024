
import 'userdata.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/otpscreen.dart';
import 'package:first_app/uihelper.dart';
import 'package:flutter/material.dart';

class PhoneAuth extends StatefulWidget{
  const PhoneAuth({super.key});
  @override
  State<PhoneAuth> createState() => _PhoneAuthState();

}

class  _PhoneAuthState extends State<PhoneAuth>{
  TextEditingController mobile = TextEditingController();
  @override
  Widget build(BuildContext context){
    return Scaffold(

      appBar: AppBar(
        title: const Text("Phone Auth"),
        centerTitle: true,
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child:
              TextField(
                controller: mobile,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Enter Your phone number",
                      suffixIcon: const Icon(Icons.phone),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24)
                  )
                ),
              )
            ,
          ),

          const SizedBox(
            height: 30,
          ),

          ElevatedButton(onPressed: ()  async {
            try{

              String mobileNo="+91${mobile.text}";


              if (mobileNo.length != 13) { // Length of "+91" + 10 digits
                customalertBox(context, "Mobile number should be 10 digits long.");
                return; // Exit the function if the mobile number is not valid
              }

            await FirebaseAuth.instance.verifyPhoneNumber(
                verificationCompleted: (PhoneAuthCredential credential){},
                verificationFailed: (FirebaseAuthException ex){},
                codeSent: (String verificationid,int? resendtoken){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Otpscreen(verificationid: verificationid,)));
                },
                codeAutoRetrievalTimeout: (String verificationId ){},
              phoneNumber: mobileNo
            );
              UserData().email = mobileNo.toString();
            } catch(ex){
              customalertBox(context, ex.toString());
            }

          }, child: const Text("Send OTP")),

        ],),
    );

  }
}
