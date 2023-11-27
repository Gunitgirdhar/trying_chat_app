import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trying_chat_app/Chat_Screens/chat_bubbles_widget.dart';
import 'package:trying_chat_app/Models/Message_Model.dart';
import 'package:trying_chat_app/firebase/firebase_provider.dart';

import '../CustomWidgets/mCustom_Texttiles.dart';

class DetailChattingSreen extends StatefulWidget {
  String toId;

  DetailChattingSreen({super.key, required this.toId});

  @override
  State<DetailChattingSreen> createState() => _DetailChattingSreenState();
}

class _DetailChattingSreenState extends State<DetailChattingSreen> {
  var sendingTextController = TextEditingController();
  Stream<QuerySnapshot<Map<String, dynamic>>>? chatstream;

  @override
  void initState() {
    super.initState();
    getchatStream();
  }

  getchatStream() async {
    chatstream = await FirebaseProvider.getAllMessages(widget.toId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        leadingWidth: 40,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              child: Image.asset(
                "assets/Flat_Icons/man.png",
                height: 30,
                width: 30,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Gunit Girdhar",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: mTextStyle12(
                      mFontColor: Colors.greenAccent, mWeight: FontWeight.w500),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.video_call,
                  size: 22,
                  color: Colors.greenAccent,
                )),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.call,
                  size: 22,
                  color: Colors.greenAccent,
                ))
          ],
        ),
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.black),
      ),
      body: Column(
        children: [
          Expanded(
              child: StreamBuilder(
            stream: chatstream,
            builder: (context, snapshot) {
              print("${snapshot.data}");
              return snapshot.hasData && snapshot.data!.docs.isNotEmpty
                  ? ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var currMsg=MessageModel.fromJson(snapshot.data!.docs[index].data());
                        return ChatBubbles(msg: currMsg);
                      },
                    )
                  : Container();
              return Container();
            },
          )),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: sendingTextController,
                  ),
                ),
                InkWell(
                    onTap: () {
                      if(sendingTextController.text != Null){
                        FirebaseProvider.sendMsg(
                            sendingTextController.text.toString(), widget.toId);
                      }

                    },
                    child: Icon(Icons.send))
              ],
            ),
          )
        ],
      ),
    );
  }
}
