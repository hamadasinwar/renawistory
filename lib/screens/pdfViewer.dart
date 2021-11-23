 /* import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PdfViewer extends StatefulWidget {
  static String routeName ='Pdf_Viewer';
  @override
  _PdfViewerState createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  getPath ()async{
  // String filePath =  await PDFApi.loadAsset('');
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Container(
        child: PDFView(
  filePath: 'assets/pdfs/book.pdf',
  enableSwipe: true,
  swipeHorizontal: true,
  autoSpacing: false,
  pageFling: false,
  onRender: (_pages) {
    setState(() {
     // pages = _pages;
    //  isReady = true;
    });
  },
  onError: (error) {
    print(error.toString());
  },
  onPageError: (page, error) {
    print('$page: ${error.toString()}');
  },
  onViewCreated: (PDFViewController pdfViewController) {
   // _controller.complete(pdfViewController);
  },
  onPageChanged: (int? page, int? total) {
    print('page change: $page/$total');
  },
),
      ),
    );
  }
} */