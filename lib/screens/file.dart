/* import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';

class FilePdf extends StatefulWidget {
  static String routeName = 'pdf_file';
  const FilePdf({ Key? key }) : super(key: key);

  @override
  _FilePdfState createState() => _FilePdfState();
}

class _FilePdfState extends State<FilePdf> {
  bool _isLoading = true;
  late PDFDocument document;
   @override
  void initState() {
    super.initState();
    loadDocument();
  }

  loadDocument() async {
    document = await PDFDocument.fromAsset('assets/pdfs/book.pdf');

    setState(() => _isLoading = false);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Center(
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : PDFViewer(
                  document: document,
                  zoomSteps: 1,
                ),
        ),
      
   
    );
  }
} */