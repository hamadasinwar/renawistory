/* import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class firebaseMessaging extends StatefulWidget {

  @override
  _firebaseMessagingState createState() => _firebaseMessagingState();
}

class _firebaseMessagingState extends State<firebaseMessaging> {
 List<Message> messagesList = [];
 var tokenId ;
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
_configureFirebaseListeners() {
  FirebaseMessaging.onMessage.listen(( message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
        print('onMessage: ${notification!.body}');
        _setMessage(message.data);
    });

    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    sound: true, badge: true, alert: true ,
    );
    /*
          const IosNotificationSettings(sound: true, badge: true, alert: true),
 */
}
      _getToken() {
    _firebaseMessaging.getToken().then((token) {
      setState(() {
        tokenId = token ;
      });
      print("Device Token: $token");
    });
}
@override
void initState() { 
  super.initState();
 _configureFirebaseListeners();
  _getToken();
}
 
_setMessage(Map<String, dynamic> message) {
    final notification = message['notification'];
    final data = message['data'];
    final String title = notification['title'];
    final String body = notification['body'];
    String mMessage = data['message'];
    print("Title: $title, body: $body, message: $mMessage");
    setState(() {
      Message msg = Message(title, body, mMessage);
      messagesList.add(msg);
    });
}
 
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: ListView.builder(
        itemCount: null == messagesList ? 0 : messagesList.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                messagesList[index].message,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
            ),
          );
        },
      ),
    );
  } }
 
 
class Message {
  final String title;
  String body;
  String message;

  Message( this.title ,  this.body ,  this.message);
 
} */
