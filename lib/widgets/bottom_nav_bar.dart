/* import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'package:ourstory/screens/pdfView.dart';
import 'dart:io';
import 'dart:typed_data';

class BottomNavBar extends StatefulWidget {
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
   double kDefaultPadding = 20.0;

 var kPrimaryColor = Color(0xFF0C9869);

   final String _documentPath = 'assets/pdfs/book.pdf';

   Future<String> prepareTestPdf() async {
    final ByteData bytes =
        await DefaultAssetBundle.of(context).load(_documentPath);
    final Uint8List list = bytes.buffer.asUint8List();

    final tempDir = await getTemporaryDirectory();
    final tempDocumentPath = '${tempDir.path}/$_documentPath';

    final file = await File(tempDocumentPath).create(recursive: true);
    file.writeAsBytesSync(list);
    return tempDocumentPath;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: kDefaultPadding * 2,
        right: kDefaultPadding * 2,
        bottom: kDefaultPadding,
      ),
    //  height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -10),
            blurRadius: 35,
            color: Theme.of(context).primaryColor.withOpacity(0.38),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          InkWell(
            child: Text('حكايتنا',style: TextStyle(color: Color.fromRGBO(30, 62, 135, 1) , fontWeight: FontWeight.bold),),
            onTap: () => {
        // We need to prepare the test PDF, and then we can display the PDF.
        prepareTestPdf().then((path) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FullPdfViewerScreen(path)),
          );
        })
      } ,
          ),
           InkWell(
            child: Text('دورات مركز دبورية',style: TextStyle(color: Color.fromRGBO(30, 62, 135, 1) , fontWeight: FontWeight.bold),),
            onTap: () => {
        // We need to prepare the test PDF, and then we can display the PDF.
        prepareTestPdf().then((path) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FullPdfViewerScreen(path)),
          );
        })
      } ,
          ),
        ],
      ),
    );
  }
} */