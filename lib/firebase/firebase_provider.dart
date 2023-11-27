import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trying_chat_app/Models/User_Model.dart';

import '../Models/Message_Model.dart';

class FirebaseProvider{

  static final FirebaseFirestore mFirestore=FirebaseFirestore.instance;
      static final FirebaseAuth mAuth= FirebaseAuth.instance;

     static Future<List<UserModel>> getAllUsers()async{
        List<UserModel> arrUsers=[];
    // try{
      var arrUserData=await mFirestore.collection("users").get();

      for(QueryDocumentSnapshot<Map<String,dynamic>> eachUser in arrUserData.docs){
        var datamodel=UserModel.fromJson(eachUser.data());
         print("${eachUser.data()}");
        if(datamodel.userid != mAuth.currentUser!.uid){
          arrUsers.add(datamodel);
        }
      }
      return arrUsers;
    }
    // catch (e){
    //   // Handle specific types of exceptions
    //   if (e is FirebaseException) {
    //     print("FirebaseException: ${e.message}");
    //   } else if (e is FirebaseAuthException) {
    //     print("FirebaseAuthException: ${e.message}");
    //   } else {
    //     print("Unexpected error: $e");
    //   }
    //    }

  
       static String getChatID(String fromId, String toId) {
    if (fromId.hashCode <= toId.hashCode) {
      return "${fromId}_$toId";
    } else {
      return "${toId}_$fromId";
    }
  }

  static void sendMsg(String msg, String toId) async{

    var chatId = await getChatID(mAuth.currentUser!.uid, toId);

    var sentTime = DateTime.now().millisecondsSinceEpoch;

    var newMessage = MessageModel(fromId: mAuth.currentUser!.uid, mId: sentTime.toString(), message: msg, sent: sentTime.toString(), toId: toId);

    mFirestore
        .collection("chatroom").doc(chatId).collection("messages").doc(sentTime.toString()).set(newMessage.toJson());



  }

  static Future<Stream<QuerySnapshot<Map<String,dynamic>>>> getAllMessages(String toId)async{
       var chatId=await getChatID(mAuth.currentUser!.uid, toId);
       return mFirestore.collection("chatroom").doc(chatId).collection("messages").snapshots();
  }

}


