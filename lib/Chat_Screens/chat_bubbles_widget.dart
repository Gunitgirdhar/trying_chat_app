import 'package:flutter/material.dart';
import 'package:trying_chat_app/Models/Message_Model.dart';
import 'package:trying_chat_app/firebase/firebase_provider.dart';

class ChatBubbles extends StatefulWidget {
  MessageModel msg;
   ChatBubbles({required this.msg});

  @override
  State<ChatBubbles> createState() => _ChatBubblesState();
}

class _ChatBubblesState extends State<ChatBubbles> {
  @override
  Widget build(BuildContext context) {
    var currUserid= FirebaseProvider.mAuth.currentUser!.uid;
    return widget.msg.fromId == currUserid ? fromMsgWidgett() : ToMsgWidgett();
      ;
  }
  Widget fromMsgWidgett(){
    return Container(
      margin: EdgeInsets.all(11),
      padding: EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: Colors.amber.shade100,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(21),
            topRight:Radius.circular(21),
        bottomLeft: Radius.circular(21))
      ),

      child: Text(widget.msg.message),
    );
  }
  Widget ToMsgWidgett(){
    var sentTIme=TimeOfDay.fromDateTime(DateTime.fromMicrosecondsSinceEpoch(int.parse(widget.msg.sent) ));
   return  Row(
     mainAxisAlignment: MainAxisAlignment.spaceBetween ,
     children: [
       Flexible(
         child: Container(
           margin: EdgeInsets.all(11),
           padding: EdgeInsets.all(11),
           decoration: BoxDecoration(
               color: Colors.greenAccent.shade100,
               borderRadius: BorderRadius.only(topLeft: Radius.circular(21),
                   topRight:Radius.circular(21),
                   bottomLeft: Radius.circular(21)
          ),
          ),
           child: Text(widget.msg.message),
         ),
       ),
       Padding(
         padding: EdgeInsets.only(right: 8.0),
           child: Text("${sentTIme.format(context)}"))
     ],
   );
  }
}
