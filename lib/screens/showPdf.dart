/* import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';

class PdfShow extends StatefulWidget {
  const PdfShow({Key? key}) : super(key: key);

  @override
  _PdfShowState createState() => _PdfShowState();
}

class _PdfShowState extends State<PdfShow> {
  bool _isLoading = true;
  late PDFDocument document;
  loadDocument() async {
    document = await PDFDocument.fromAsset('assets/pdfs/book.pdf');

    setState(() => _isLoading = false);
  }

  @override
  void initState() {
    loadDocument();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:_isLoading ? Center(child: CircularProgressIndicator(),): Container(
  height: MediaQuery.of(context).size.height*.9,
  child: PDFViewer(document: document),
),
    );
  }
}
*/
