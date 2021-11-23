import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:renawistory/login/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:renawistory/widgets/roundedInput.dart';
import 'package:renawistory/widgets/video.dart';

import 'chat.dart';

class VeHandNew extends StatefulWidget {
  @override
  _VeHandNewState createState() => _VeHandNewState();
}

class _VeHandNewState extends State<VeHandNew> {
  @override
  void initState() {
    getPosts();
    super.initState();
  }

  bool getComplete = false;
  List listPosts = [];
  getPosts() async {
    var courses = FirebaseFirestore.instance
        .collection('centers')
        .doc('renawi')
        .collection('posts')
        .orderBy('createdAt', descending: true);
    courses.snapshots().listen((event) {
      listPosts.clear();
      event.docs.forEach((element) {
        setState(() {
          listPosts.add({'data': element.data(), 'id': element.id});
        });
      });
    });
    setState(() {
      getComplete = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.of(context)
                          .pushReplacementNamed(LoginScreen.routeName);
                    },
                    icon: Icon(
                      Icons.logout,
                      color: Colors.white,
                    )),
                Text(
                  'ريناوي',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) => new Chat()));
                  },
                  icon: Icon(
                    Icons.message,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0)),
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color.fromRGBO(234, 46, 98, 1),
                  Color.fromRGBO(3, 154, 156, 1),
                ],
              ),
            ),
            height: MediaQuery.of(context).size.height / 8,
          ),
          SizedBox(
            height: 20,
          ),
          !getComplete
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : listPosts.isEmpty
                  ? Center(
                      child: Text('لا يوجد منشورات لحد الأن'),
                    )
                  : Expanded(
                      child: ListView.builder(
                          itemCount: listPosts.length,
                          itemBuilder: (context, index) {
                            return Container(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border:
                                        Border.all(color: Colors.blueAccent)),
                                margin: EdgeInsets.all(3),
                                padding: EdgeInsets.all(5),
                                child: Column(
                                  children: [
                                    Text(
                                        '${listPosts[index]['data']['title']}'),
                                    Text(
                                        '${listPosts[index]['data']['describe']}'),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    listPosts[index]['data']['image'].isNotEmpty
                                        ? Container(
                                            child: Image.network(
                                                '${listPosts[index]['data']['image']}'))
                                        : video(
                                            videoUrl:
                                                '${listPosts[index]['data']['videoLink']}',
                                          ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
        ],
      ),
    );
  }
}
