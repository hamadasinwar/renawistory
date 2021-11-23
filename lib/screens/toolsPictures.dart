import 'package:flutter/material.dart';

class ToolsPictures extends StatefulWidget {
   static String routeName = 'Tools_Pictures';

  @override
  _ToolsPicturesState createState() => _ToolsPicturesState();
}

class _ToolsPicturesState extends State<ToolsPictures> {
   List images = [
  'assets/images/الجاروشة.jpeg',
  'assets/images/الببور.jpeg',
  'assets/images/الزبدية.jpeg',
  'assets/images/السفرطاس.jpeg',
  'assets/images/الصاج.jpeg',
  'assets/images/الطابون.jpeg',
   'assets/images/الفانوس.jpeg',
  'assets/images/القرطلة.jpeg',
  'assets/images/الكبة.jpeg',
  'assets/images/المنخل.jpeg',
  'assets/images/الهاون.jpeg',
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