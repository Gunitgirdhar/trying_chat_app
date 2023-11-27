import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:trying_chat_app/Chat_Screens/Chat_Screen.dart';
import 'package:trying_chat_app/firebase/firebase_provider.dart';

import 'Signup_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var cred;
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login Screen",
        style: TextStyle(
            fontWeight: FontWeight.bold
        ),),
        centerTitle: true,),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                  height: 320,
                  alignment: Alignment.center,
                  child:Lottie.asset("assets/lottie/gunit2.json")
              ),
              Container(
                margin: EdgeInsets.fromLTRB(40,0,40,0),
                child: TextFormField(
                  decoration:InputDecoration(
                      prefixIcon: Icon(Icons.email_rounded),
                      labelText: "Email",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18)
                      )

                  ) ,
                ),
              ),
              SizedBox(height: 15,),
              Container(
                margin: EdgeInsets.fromLTRB(40,0,40,0),
                child: TextFormField(
                  decoration:InputDecoration(
                      prefixIcon: Icon(Icons.email_rounded),
                      labelText: "Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18)
                      )

                  ) ,
                ),
              ),
              SizedBox(height: 15,),
              ElevatedButton(onPressed: (){

                var email= emailController.text.trim().toString();
                var password= passwordController.text.trim().toString();
                try {
                  FirebaseProvider.mAuth.signInWithEmailAndPassword(
                    email: email,
                    password: password,
                  );

                  Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen(),));

                } on FirebaseAuthException catch (e) {
                  if (e.code == 'user-not-found') {
                    print('No user found for that email.');
                  } else if (e.code == 'wrong-password') {
                    print('Wrong password provided for that user.');
                  } else {
                    print('Firebase authentication error: ${e.message}');
                  }

                } on Exception catch (e) {
                  print('An unexpected error occurred: $e');
                }


              }, child: Text("Login")),

              SizedBox(height: 10,),
              GestureDetector(
                onTap: (){
                  Navigator.push(
                      context,MaterialPageRoute(
                      builder: (context)=>  SignUP()));
                },
                child: Container(
                  child: Card(
                    elevation: 2,
                    child: Padding(
                      padding: EdgeInsets.all(6),
                      child: Text("Don't remeber password | Sign Up",
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
