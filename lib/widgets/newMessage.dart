import 'dart:io';
import 'package:renawistory/screens/chat.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class NewMessage extends StatefulWidget {
  final bool isNew;
  final doc;
  final sender;
  const NewMessage({this.doc, required this.isNew, this.sender});

  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = TextEditingController();
  var _enteredMessage = '';

  void sendMessage(context, bool isImage, content) async {
    FocusScope.of(context).unfocus();
    var chats = FirebaseFirestore.instance
        .collection('centers')
        .doc('renawi')
        .collection('chats');
    if (!widget.isNew) {
      var changeTime = Timestamp.now();
      await chats.doc(widget.doc).collection('messages').add({
        'content': content,
        'createdAt': changeTime,
        'fromcenter': false,
        'isRead': false,
        'isImage': isImage
      }).then((_) async {
        await chats.doc(widget.doc).update({'lastupdate': changeTime});
      });
    } else {
      var docid = chats.doc().id;
      var changeTime = Timestamp.now();
      await chats.doc(docid).set(
          {'lastupdate': changeTime, 'from': widget.sender}).then((_) async {
        await chats.doc(docid).collection('messages').add({
          'content': content,
          'createdAt': changeTime,
          'fromcenter': false,
          'isRead': false,
          'isImage': isImage
        });
      });
      Navigator.pushReplacement(context,
          new MaterialPageRoute(builder: (BuildContext context) => new Chat()));
    }

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        margin: EdgeInsets.only(top: 8),
        padding: EdgeInsets.all(8),
        child: Row(
          children: <Widget>[
            Expanded(
                child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                  hintText: 'ارسال رسالة .....',
                  suffixIcon: IconButton(
                    onPressed: () {
                      showBottomSheet(context);
                    },
                    icon: Icon(Icons.image),
                  )),
              onChanged: (value) {
                setState(() {
                  _enteredMessage = value;
                });
              },
            )),
            IconButton(
              icon: Icon(Icons.send),
              onPressed: _enteredMessage.trim().isEmpty
                  ? null
                  : () {
                      sendMessage(context, false, _enteredMessage);
                    },
              color: Theme.of(context).primaryColor,
            )
          ],
        ),
      ),
    );
  }

  late File file;
  late String url;
  late Reference ref;
  showBottomSheet(context) async {
    var picked = await ImagePicker().getImage(source: ImageSource.gallery);
    if (picked != null) {
      file = File(picked.path);
      var imagename = basename(picked.path);
      ref = FirebaseStorage.instance.ref("images").child("$imagename");
      await ref.putFile(file);
      await ref.getDownloadURL().then((value) {
        sendMessage(context, true, value);
      });
    }
  }
}
