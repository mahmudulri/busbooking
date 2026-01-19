import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import '../pdftemplate/default_template.dart';

class Draftticketviewscreen extends StatefulWidget {
  final Uint8List pdfBytes;
  const Draftticketviewscreen({super.key, required this.pdfBytes});

  @override
  State<Draftticketviewscreen> createState() => _DraftticketviewscreenState();
}

class _DraftticketviewscreenState extends State<Draftticketviewscreen> {
  late Uint8List _currentPdfBytes;

  @override
  void initState() {
    super.initState();
    _currentPdfBytes = widget.pdfBytes;
  }

  void _loadNewPdf(Uint8List newPdfBytes) {
    setState(() {
      _currentPdfBytes = newPdfBytes;
    });
  }

  Future<void> _printPdf() async {
    await Printing.layoutPdf(onLayout: (_) => _currentPdfBytes);
  }

  Future<bool> _requestPermission() async {
    if (Platform.isAndroid) {
      var status = await Permission.manageExternalStorage.request();
      return status.isGranted;
    } else {
      return true;
    }
  }

  Future<void> _savePdf() async {
    try {
      final directory = await getExternalStorageDirectory();
      if (directory == null) return;

      final fileName = 'busticket_${DateTime.now().millisecondsSinceEpoch}.pdf';

      final file = File('${directory.path}/$fileName');
      await file.writeAsBytes(_currentPdfBytes);

      final folderName = directory.path.split('/').last;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.check_circle, color: Colors.green),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Saved successfully\nFolder: $folderName\nFile: $fileName',
                ),
              ),
            ],
          ),
          duration: const Duration(seconds: 4),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('❌ Error saving file')));
    }
  }

  Future<void> _sharePdf() async {
    final directory = await getTemporaryDirectory();
    final filePath = '${directory.path}/busticket.pdf';
    final file = File(filePath);
    await file.writeAsBytes(_currentPdfBytes);
    // ignore: deprecated_member_use
    await Share.shareXFiles([
      XFile(filePath),
    ], text: 'Here is your invoice PDF!');
  }

  final DefaultTemplate defaultTemplate = DefaultTemplate();
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () async {
                _loadNewPdf(await defaultTemplate.generatePDF());
              },
              child: Text("Reload", style: TextStyle(fontSize: 14)),
            ),
            GestureDetector(
              onTap: _printPdf,

              child: Text("Print", style: TextStyle(fontSize: 14)),
            ),
            GestureDetector(
              onTap: _sharePdf,

              child: Text("Share", style: TextStyle(fontSize: 14)),
            ),
            GestureDetector(
              onTap: _savePdf,

              child: Text("Save", style: TextStyle(fontSize: 14)),
            ),
          ],
        ),
      ),
      body: Container(
        height: screenHeight,
        width: screenWidth,
        child: SfPdfViewerTheme(
          data: SfPdfViewerThemeData(
            // backgroundColor: Colors.red,
            backgroundColor: Colors.white,
          ),
          child: SfPdfViewer.memory(
            _currentPdfBytes,
            canShowScrollHead: true,
            canShowScrollStatus: true,
          ),
        ),
      ),
    );
  }
}
