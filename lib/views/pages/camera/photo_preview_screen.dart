import 'package:blnk_task/views/components/main_appBar.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';

class PhotoPreviewScreen extends StatelessWidget {
  const PhotoPreviewScreen({super.key, required this.options});
  final Map<String, dynamic> options;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(
        title: "",
        isBack: true,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          height: 400,
          color: Colors.white.withOpacity(0.1),
          padding: const EdgeInsets.all(16),
          child: PDFViewer(
              showPicker: false,
              enableSwipeNavigation: false,
              showNavigation: false,
              showIndicator: false,
              document: options["doc"]), // PdfView(path: pdfFile.toString())
        ),
      ),
    );
  }
}
