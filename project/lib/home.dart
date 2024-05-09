import 'dart:developer';
import 'dart:io';
import 'userdata.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:first_app/login.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var wtController = TextEditingController();
  var ftController = TextEditingController();
  var inController = TextEditingController();

  final emailC=UserData().email?? "";

  @override
  void initState() {
    super.initState();
    print(emailC);
  }

  var result = "";

  File? pickedImage;

  pickimage(ImageSource imageSource) async{
    try{
      final photo=await ImagePicker().pickImage(source: imageSource);
      if(photo==null)return;
      final tempImage=File(photo.path);
      setState(() {
        pickedImage=tempImage;
      });
    }catch(ex){
      log(ex.toString());
    }

  }
  uploadImage() async {
    try {
      if (pickedImage == null) {
        throw Exception("No image selected");
      }
      final uploadTask =
      FirebaseStorage.instance.ref("Profile Pics").child(emailC).putFile(pickedImage!);
      final TaskSnapshot taskSnapshot = await uploadTask;
      final String url = await taskSnapshot.ref.getDownloadURL();
      await FirebaseFirestore.instance.collection("Users").doc(emailC).set({
        "Email": emailC,
        "Image": url,
      });
      log("Image uploaded successfully");
    } catch (ex) {
      log("Failed to upload image: $ex");
    }
  }


  showALertBox(){
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: const Text("Pick Image From"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              onTap: () {
                pickimage(ImageSource.camera);
                Navigator.pop(context);
              },
              leading: const Icon(Icons.camera_alt),
              title: const Text("Camera"),
            ),
            ListTile(
              onTap: () {
                pickimage(ImageSource.gallery);
                Navigator.pop(context);
              },
              leading: const Icon(Icons.image),
              title: const Text("Gallery"),
            )
          ],
        ),
      );
    });
  }

  logout() async {
    var sharedPref = await SharedPreferences.getInstance();
    sharedPref.setBool(SplashPageState.keyLog, false);

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Shashank BMI"),
        ),
        body: Center(
          
          child: SingleChildScrollView(
            child: SizedBox(
              width: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "BMI",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: (){
                      showALertBox();
                    },
                  child :pickedImage != null? CircleAvatar(
                    radius: 45,
                   backgroundImage: FileImage(pickedImage!),):
                    const CircleAvatar(
                      radius: 45,
                      child: Icon(
                        Icons.person,
                        size: 45,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: wtController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        label: Text('Enter Your weight in kg'),
                        prefixIcon: Icon(Icons.line_weight)),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: ftController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        label: Text('Enter Your Height in feet'),
                        prefixIcon: Icon(Icons.height)),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: inController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        label: Text('Enter yours height in inch'),
                        prefixIcon: Icon(Icons.height)),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      var wt = wtController.text.toString();
                      var ft = ftController.text.toString();
                      var inh = inController.text.toString();
            
                      if (wt != "" && ft != "" && inh != "") {
                        uploadImage();
                        var wei = int.parse(wt);
                        var feet = int.parse(ft);
                        var inch = int.parse(inh);
            
                        var tinch = (feet * 12) + inch;
                        var tcm = tinch * 2.54;
                        var tm = tcm / 100;
                        var bm1 = wei / (tm * tm);
            
                        setState(() {
            
                          result = "Your BMI is ${bm1.toStringAsFixed(2)}";
                        });
                      } else {
                        setState(() {
                          result = "Please fill all the required blanks";
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyan,
                    ),
                    child: const Text('Calculate'),
                  ),
                  Text(
                    result,
                    style: const TextStyle(fontSize: 25),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  TextButton(
                    onPressed: () {
                      logout();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyan,
                    ),
                    child: const Text(
                      "Logout",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),


                ],
              ),
            ),
          ),
        ));
  }
}
