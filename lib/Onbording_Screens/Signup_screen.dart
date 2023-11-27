import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../CustomWidgets/Custom_Container.dart';
import '../Models/User_Model.dart';
import '../firebase/firebase_provider.dart';

class SignUP extends StatelessWidget {
  var usernamecontroller=TextEditingController();
  var userphonecontroller=TextEditingController();
  var useremailcontroller=TextEditingController();
  var userpasswordcontroller=TextEditingController();
  var usergendercontroller=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SignUp Screen",
        style: TextStyle(
            fontWeight: FontWeight.bold
        ),),
        centerTitle: true,),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                  height: 300,
                  alignment: Alignment.center,
                  child:Lottie.asset("assets/lottie/gunit.json")
              ),
              myContainer(mController: usernamecontroller, mIcon: Icons.person, data: "User Name"),
              SizedBox(height: 10,),
              myContainer(mController: userphonecontroller, mIcon: Icons.call, data: "Phone Number"),
              SizedBox(height: 10,),
              myContainer(mController: useremailcontroller, mIcon: Icons.email, data: "Enter your Email"),
              SizedBox(height: 10,),
              myContainer(mController: userpasswordcontroller, mIcon: Icons.password, data: "Enter your Password"),
              SizedBox(height: 10,),
              myContainer(mController: usergendercontroller, mIcon: Icons.man, data: "Gender"),
              SizedBox(height: 10,),
              ElevatedButton(onPressed: ()async{
                var username= usernamecontroller.text.trim().toString();
                var userphoneno= userphonecontroller.text.trim().toString();
                var useremail= useremailcontroller.text.trim().toString();
                var userpassword= userpasswordcontroller.text.trim().toString();
                var usergender=usergendercontroller.text.trim().toString();

                ///onTap we will perform signUp Task
                try {
                  final cred = await  FirebaseProvider.mAuth.createUserWithEmailAndPassword(
                    email: useremail,
                    password: userpassword,
                  );

                  //after creating account
                  FirebaseProvider.mFirestore.collection("users").doc(cred.user!.uid).set(UserModel(
                      password: userpassword,
                      name: username,
                      email: useremail,
                      phone: userphoneno,
                      userid: cred.user!.uid,
                      gender: usergender).toJson());
    print("HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH");
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'weak-password') {
                    print('The password provided is too weak.');
                  } else if (e.code == 'email-already-in-use') {
                    print('The account already exists for that email.');
                  }
                } catch (e) {
                  print(e);
                }


              }, child: Text("Sign Up")),
              SizedBox(height: 10,),
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);

                },
                child: Container(
                  child: Card(
                    elevation: 2,
                    child: Padding(
                      padding: EdgeInsets.all(6),
                      child: Text("Already have an acoount | Login",
                        style: TextStyle(color: Colors.blue),),),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}






