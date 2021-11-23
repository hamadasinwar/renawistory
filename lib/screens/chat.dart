import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:renawistory/widgets/bubbleMessage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:renawistory/widgets/newMessage.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  var currentuser = FirebaseAuth.instance.currentUser;
  updatehUnreadMessages(String docid) async {
    await firebaseFirestoreInstance
        .collection('centers')
        .doc('renawi')
        .collection('chats')
        .doc(docid)
        .collection('messages')
        .where('fromcenter', isEqualTo: true)
        .where('isRead', isEqualTo: false)
        .get()
        .then((value) {
      value.docs.forEach((element) async {
        await firebaseFirestoreInstance
            .collection('chats')
            .doc(docid)
            .collection('messages')
            .doc(element.id)
            .update({'isRead': true});
      });
    });
  }

  var firebaseFirestoreInstance = FirebaseFirestore.instance;
  List chatList = [];
  var chats;
  bool isNew = false;
  String doc = '';
  bool getComplete = false;
  var exist;

  getData() async {
    firebaseFirestoreInstance
        .collection('centers')
        .doc('renawi')
        .collection('chats')
        .where('from', isEqualTo: currentuser!.uid)
        .get()
        .then((value) {
      if (value.size == 0) {
        setState(() {
          isNew = true;
          getComplete = true;
        });
        return;
      } else {
        setState(() {
          doc = value.docs.first.id;
        });
      }
    }).then((_) async {
      chats = firebaseFirestoreInstance
          .collection('centers')
          .doc('renawi')
          .collection('chats')
          .doc(doc)
          .collection('messages')
          .orderBy('createdAt', descending: true);
      print(chats.toString());
      await chats.snapshots().listen((event) {
        chatList.clear();
        event.docs.forEach((element) {
          setState(() {
            chatList.add(element.data());
          });
        });
      });
      setState(() {
        getComplete = true;
      });
      updatehUnreadMessages(doc);
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: !getComplete
          ? Container(
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                automaticallyImplyLeading: false,
                title: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/icons/icon.jpeg'),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'ريناوي',
                      style: TextStyle(color: Colors.black),
                    )
                  ],
                ),
              ),
              body: Column(
                children: [
                  Container(
                    child: isNew
                        ? Expanded(
                            child: Center(
                                child: Text(
                              'تواصل مع ريناوي',
                              style: TextStyle(color: Colors.black),
                            )),
                          )
                        : Expanded(
                            child: ListView.builder(
                                reverse: true,
                                shrinkWrap: true,
                                itemCount: chatList.length,
                                itemBuilder: (context, index) {
                                  return MessageBubble(
                                      isImage: chatList[index]['isImage'],
                                      message: chatList[index]['content'],
                                      isMe: !chatList[index]['fromcenter']);
                                }),
                          ),
                  ),
                  NewMessage(
                    doc: doc,
                    isNew: isNew,
                    sender: currentuser!.uid,
                  )
                ],
              ),
            ),
    );
  }
}
