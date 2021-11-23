import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:math' as math;

const double degrees2Radians = math.pi / 180.0;

class Library extends StatefulWidget {
  @override
  _LibraryState createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .06),
                height: MediaQuery.of(context).size.height * .18,
                width: MediaQuery.of(context).size.width * .38,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(208, 54, 125, 1),
                    borderRadius: BorderRadius.circular(40)),
                child: Text(
                  'طلاب الجامعات',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white),
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .06),
                height: MediaQuery.of(context).size.height * .18,
                width: MediaQuery.of(context).size.width * .38,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(250, 36, 78, 1),
                    borderRadius: BorderRadius.circular(40)),
                child: Text(
                  'متطوعين',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white),
                ),
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .06),
                height: MediaQuery.of(context).size.height * .18,
                width: MediaQuery.of(context).size.width * .38,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(88, 218, 205, 1),
                    borderRadius: BorderRadius.circular(40)),
                child: Text(
                  'تطوير الذات',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white),
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .06),
                height: MediaQuery.of(context).size.height * .18,
                width: MediaQuery.of(context).size.width * .38,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(6, 153, 162, 1),
                    borderRadius: BorderRadius.circular(40)),
                child: Text(
                  'مكتبة الفيديو',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white),
                ),
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .06),
                height: MediaQuery.of(context).size.height * .18,
                width: MediaQuery.of(context).size.width * .38,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 132, 2, 1),
                    borderRadius: BorderRadius.circular(40)),
                child: Text(
                  'قيادة محلية',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white),
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .06),
                height: MediaQuery.of(context).size.height * .18,
                width: MediaQuery.of(context).size.width * .38,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(253, 72, 53, 1),
                    borderRadius: BorderRadius.circular(40)),
                child: Text(
                  'ريناويات',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white),
                ),
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .03),
                height: MediaQuery.of(context).size.height * .1,
                width: MediaQuery.of(context).size.width * .38,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(17, 87, 195, 1),
                    borderRadius: BorderRadius.circular(40)),
                child: Text(
                  'اخرى',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
