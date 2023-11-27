
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trying_chat_app/Chat_Screens/chat_bubbles_widget.dart';
import 'package:trying_chat_app/Models/User_Model.dart';
import 'package:trying_chat_app/Onbording_Screens/Login_Screen.dart';
import 'package:trying_chat_app/firebase/firebase_provider.dart';

import '../CustomWidgets/mCustom_Texttiles.dart';
import '../Models/Message_Model.dart';
import 'Detail_chatting_screen.dart';

class ChatScreen extends StatefulWidget {
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool isRead = true;

  Stream<QuerySnapshot<Map<String, dynamic>>>? chatStream;

  @override
  void initState() {
    super.initState();
  }

  //region BuildMethod
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //ChatListView
            Expanded(
              flex: 2,
              child:FutureBuilder<List<UserModel>>(
                future: FirebaseProvider.getAllUsers(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    print("error*/////////////////////////");
                    print("${snapshot.error}");
                    return Text("${snapshot.error}");
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          var currUser = snapshot.data![index];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailChattingSreen(
                                        toId: currUser.userid.toString(),
                                      )));

                            },
                            child: ListTile(
                              horizontalTitleGap: 8,
                              leading: CircleAvatar(
                                radius: 30,
                                child: Image.asset("assets/Flat_Icons/man.png"),
/*NetworkImage(
                                /////////////////////logic for profile picture yaha pe aaega/////////////////////////
                              snapshot.data![index].profilepic !="" ?  "" : "data:image/jpeg;base64,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"
                              ),*/
                              ),
                              title: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      "${snapshot.data![index].name}",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: mTextStyle16(

                                          mWeight: isRead
                                              ? FontWeight.w500
                                              : FontWeight.bold),
                                    ),
                                  ),
                                  Text(
                                    "4:10 PM",
                                    style: mTextStyle12(
                                        mFontColor: isRead
                                            ? Colors.blueGrey
                                            : Colors.black,

                                        mWeight: isRead
                                            ? FontWeight.w500
                                            : FontWeight.bold),
                                  )
                                ],
                              ),
                              subtitle: Row(

                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text("User",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: mTextStyle12(
                                            mFontColor: isRead
                                                ? Colors.blueGrey
                                                : Colors.black,

                                            mWeight: isRead
                                                ? FontWeight.w500
                                                : FontWeight.bold)),
                                  ),
                                  CircleAvatar(
                                    backgroundColor: Colors.white54,

                                    radius: 10,
                                    child: Text(
                                      "2",
                                      style: mTextStyle12(

                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  }
                  return Container();
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
       // print("${FirebaseProvider.mAuth.currentUser.uid!}");
        FirebaseProvider.mAuth.signOut();

        Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
      },
      child:Icon(Icons.follow_the_signs_outlined) ,),
    );

  }
//endregion
}
//endregion
//changes made .toString to user id

