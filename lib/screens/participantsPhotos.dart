import 'package:flutter/material.dart';

class ParticipantsPhotos extends StatefulWidget {
  static String routeName = 'participants_Photos';
  @override
  _ParticipantsPhotosState createState() => _ParticipantsPhotosState();
}

class _ParticipantsPhotosState extends State<ParticipantsPhotos> {
  List images = [
  'assets/images/أنيس يوسف.png',
  'assets/images/حسين.png',
  'assets/images/زهير يوسفية.png',
  'assets/images/محمد مصالحة.png',
  'assets/images/نجدية.png',
  'assets/images/وجيهة.png',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(itemBuilder: (context, index) {
        return Container(
        child: Image.asset(images[index]),  
        );
      } ,
      itemCount: images.length,
      ),
    );
  }
}
