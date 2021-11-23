import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
//  final Function onTap ;
  const RoundedButton({
    required this.title,
   // required this.onTap
  }) ;

  final String title;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return    ElevatedButton(  
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                  EdgeInsets.symmetric(vertical: 12 , horizontal: size.width*.28)),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                   Theme.of(context).primaryColor),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                   Theme.of(context).primaryColorLight),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ))),
                          onPressed: (){} ,
                          child: Text(title),
                        );
  }
}
