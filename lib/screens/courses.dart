import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:renawistory/widgets/video.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Courses extends StatefulWidget {
  @override
  _CoursesState createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  List listCourses = [];
  late String CurrentUser;

  initUser() {
    setState(() {
      CurrentUser = FirebaseAuth.instance.currentUser!.uid;
    });
  }

  bool getComplete = false;

  getCourses() async {
    var courses = FirebaseFirestore.instance
        .collection('centers')
        .doc('renawi')
        .collection('courses')
        .orderBy('createdAt', descending: true);
    courses.snapshots().listen((event) {
      listCourses.clear();
      event.docs.forEach((element) {
        setState(() {
          listCourses.add({'data': element.data(), 'id': element.id});
        });
      });
    });
    setState(() {
      getComplete = true;
    });
  }

  @override
  void initState() {
    getCourses();
    initUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: !getComplete
            ? Center(
                child: CircularProgressIndicator(),
              )
            : listCourses.isEmpty
                ? Center(
                    child: Text('لا يوجد كورسات حتى الأن'),
                  )
                : ListView.builder(
                    itemCount: listCourses.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.blueAccent)),
                          margin: EdgeInsets.all(3),
                          padding: EdgeInsets.all(5),
                          child: Column(
                            children: [
                              Text('${listCourses[index]['data']['title']}'),
                              Text('${listCourses[index]['data']['describe']}'),
                              SizedBox(
                                height: 7,
                              ),
                              listCourses[index]['data']['image'].isNotEmpty
                                  ? Container(
                                      child: Image.network(
                                          '${listCourses[index]['data']['image']}'))
                                  : video(
                                      videoUrl:
                                          '${listCourses[index]['data']['videoLink']}',
                                    ),
                              RaisedButton(
                                onPressed: () {
                                  _showMessageDialog(
                                      context,
                                      listCourses[index]['id'],
                                      listCourses[index]['data']['users']
                                          .contains(CurrentUser));
                                },
                                color: Theme.of(context).primaryColorLight,
                                child: Text(
                                  listCourses[index]['data']['users']
                                          .contains(CurrentUser)
                                      ? 'إلغاء الإشتراك في الكورس'
                                      : 'اشتراك في الكورس',
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
      ),
    );
  }

  _showMessageDialog(BuildContext context, String docId, bool isRegister) =>
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            isRegister ? 'إلغاء الإشتراك بالدورة ' : "الإلتحاق بالدورة",
            textAlign: TextAlign.right,
          ),
          content: Text(
            isRegister
                ? 'هل تريد إلغاء الإشتراك بهذه الدورة '
                : "هل تريد الإلتحاق بهذه الدورة ؟",
            textAlign: TextAlign.right,
          ),
          actions: <Widget>[
            FlatButton(
                child: Text("نعم"),
                onPressed: isRegister
                    ? () {
                        FirebaseFirestore.instance.collection('centers')
                            .doc('renawi')
                            .collection('courses')
                            .doc(docId)
                            .update({
                          'users': FieldValue.arrayRemove([CurrentUser])
                        }).then((_) {
                          Navigator.of(context).pop();
                        });
                      }
                    : () {
                        FirebaseFirestore.instance.collection('centers')
                            .doc('renawi')
                            .collection('courses')
                            .doc(docId)
                            .update({
                          'users': FieldValue.arrayUnion([CurrentUser])
                        }).then((_) {
                          Navigator.of(context).pop();
                        });
                      }),
            FlatButton(
              child: Text("لا"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
}
