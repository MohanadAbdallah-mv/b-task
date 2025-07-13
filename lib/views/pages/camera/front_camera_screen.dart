import 'dart:developer';
import 'dart:io';
import 'package:blnk_task/providers/user_provider.dart';
import 'package:blnk_task/util/app_theme.dart';
import 'package:blnk_task/util/navigator_helper.dart';
import 'package:blnk_task/util/routes.dart';
import 'package:blnk_task/views/components/custom_button.dart';
import 'package:blnk_task/views/components/main_appBar.dart';
import 'package:blnk_task/views/pages/address_screen.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_doc_scanner/flutter_doc_scanner.dart';
import 'package:provider/provider.dart';

class FrontCameraScreen extends StatefulWidget {
  const FrontCameraScreen({super.key});

  @override
  State<FrontCameraScreen> createState() => _FrontCameraScreenState();
}

class _FrontCameraScreenState extends State<FrontCameraScreen> {
  File? _scannedDocuments;
  PDFDocument? pdfDocument;
  Future<File?> scanDocument() async {
    try {
      dynamic scannedDocuments =
          await FlutterDocScanner().getScannedDocumentAsPdf();
      if (scannedDocuments == null) return null;
      final uriData = scannedDocuments["pdfUri"];
      final path = Uri.parse(uriData).toFilePath();
      Provider.of<UserProvider>(context, listen: false).setFrontIDPath(path);
      return File(path);
    } catch (e) {
      log("error:$e");
      return null;
    }
  }

  void _disposePdfDocument() {
    if (pdfDocument != null) {
      pdfDocument = null;
    }
  }

  @override
  void initState() {
    super.initState();
    String? path =
        Provider.of<UserProvider>(context, listen: false).frontIDPath;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      log("checked");
      if (path != null) {
        _scannedDocuments = File(path);
        log("_scannedDocuments at init state");
        log(_scannedDocuments.toString());
        final doc = await PDFDocument.fromFile(_scannedDocuments!);
        log("path exists");
        setState(() {
          pdfDocument = doc;
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _disposePdfDocument();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(
        isBack: true,
        title: "Front ID",
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: (_scannedDocuments == null && pdfDocument == null)
          ? Padding(
              padding: const EdgeInsets.only(bottom: 120, left: 65, right: 65),
              child: CustomButton(
                isActive: isActive,
                onTap: () async {
                  _scannedDocuments = await scanDocument();
                  final doc = await PDFDocument.fromFile(_scannedDocuments!);
                  setState(() {
                    pdfDocument = doc;
                  });
                },
                child: Text(
                  "Scan",
                  style: AppTheme.activeProgress,
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(bottom: 70, left: 65, right: 65),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomButton(
                    onTap: () async {
                      _scannedDocuments = await scanDocument();
                      final doc =
                          await PDFDocument.fromFile(_scannedDocuments!);
                      setState(() {
                        pdfDocument = doc;
                      });
                    },
                    child: Text(
                      "Rescan",
                      style: AppTheme.buttonText,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomButton(
                    isActive: isActive,
                    onTap: () async {
                      PlatformNavigator.pushNamed(
                          context, Routes.backCameraScreen);
                    },
                    child: Text(
                      "Next",
                      style: AppTheme.activeProgress,
                    ),
                  ),
                ],
              ),
            ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              _scannedDocuments != null && pdfDocument != null
                  ? Container(
                      //todo make a gesture detector here, if u want to rescan just press on the picture
                      margin: const EdgeInsets.symmetric(horizontal: 24),
                      height: 400,
                      color: Colors.white.withOpacity(0.1),
                      padding: const EdgeInsets.all(16),
                      child: PDFViewer(
                          showPicker: false,
                          enableSwipeNavigation: false,
                          showNavigation: false,
                          showIndicator: false,
                          document:
                              pdfDocument!), // PdfView(path: pdfFile.toString())
                    )
                  : Container(
                      margin: const EdgeInsets.symmetric(horizontal: 24),
                      height: 400,
                      color: Colors.white.withOpacity(0.1),
                      alignment: Alignment.center,
                      child: const Text("No Documents Scanned")),
            ],
          ),
        ),
      ),
    );
  }
}
