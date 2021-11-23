/* import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class FullPdfViewerScreen extends StatelessWidget {
  static String routeName = 'PdfViewerScreen';
  final String pdfPath;

  FullPdfViewerScreen(this.pdfPath);

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
        appBar: AppBar(
          title: Text("Document"),
        actions: [
           IconButton(onPressed:() async{
           //Load the existing PDF document. 
PdfDocument document =
PdfDocument(inputBytes: await _readDocumentData('‘pdf_succinctly.pdf’')); 
//Create the new instance of the PdfTextExtractor. 
PdfTextExtractor extractor = PdfTextExtractor(document); 
//Find text from the PDF document 
List<MatchedItem> findResult = extractor.findText(['‘PDF’']); 
if (findResult.length == 0) { 
document.dispose(); 
_showResult('‘The text is not found’' , context); 
} else { 
//Highlight the searched text from the document. 
for (int i = 0; i < findResult.length; i++) { 
MatchedItem item = findResult[i]; 
//Get page. 
PdfPage page = document.pages[item.pageIndex]; 
//Set transparency to the page graphics. 
page.graphics.save(); 
page.graphics.setTransparency(0.5); 
//Draw rectangle to highlight the text. 
page.graphics
 .drawRectangle(bounds: item.bounds, brush: PdfBrushes.yellow); page.graphics.restore(); 
} 
//Save and launch the document. 
final List<int> bytes = document.save(); 
//Dispose the document. 
document.dispose(); 
//Get the storage folder location using path_provider package. 
  final Directory directory = await getApplicationDocumentsDirectory(); 
  final String path = directory.path; 
  final File file = File('‘$path/output.pdf’'); 
  await file.writeAsBytes(bytes); 
//Launch the file (used open_file package) 
  await OpenFile.open('‘$path/output.pdf’');
         } }, icon: Icon(Icons.search))], 
        
        ),
        path: pdfPath ,
        
        
        );
  }

Future<List<int>> _readDocumentData(String name) async { 
final ByteData data = await rootBundle.load('‘assets/$name’'); 
return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes); 
}
  void _showResult(String text , context) { 
showDialog( 
context: context, 
builder: (BuildContext context) { 
return AlertDialog( 
title: Text('‘Find Text’'), 
content: Scrollbar( 
child: SingleChildScrollView( 
child: Text(text), 
physics: BouncingScrollPhysics( 
parent: AlwaysScrollableScrollPhysics()), 
), 
), 
actions: [ 
FlatButton( 
child: Text('‘Close’'), 
onPressed: () { 
Navigator.of(context).pop(); 
}, 
) 
], 
); 
}); 
}
} */