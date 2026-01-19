import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

import '../widgets/custom_text.dart';

class DefaultTemplate {
  Future<Uint8List> generatePDF() async {
    final pdf = pw.Document();
    List<pw.Widget> widgets = [];
    final statusimgae = (await rootBundle.load(
      "assets/icons/logo.png",
    )).buffer.asUint8List();
    final logo = (await rootBundle.load(
      "assets/icons/logo.png",
    )).buffer.asUint8List();

    // final sstatusarea = pw.Container(
    //   height: 120,
    //   width: 120,
    //   child: pw.Image(pw.MemoryImage(statusimgae), height: 60),
    // );

    // final statusarea = pw.Transform.rotate(
    //   angle: 25 * 3.1415927 / 170, // Rotate by 45 degrees in radians
    //   child: pw.Container(
    //     height: 150,
    //     width: 150,
    //     child: pw.Image(pw.MemoryImage(statusimgae), height: 60),
    //   ),
    // );

    final bgImage = pw.MemoryImage(
      (await rootBundle.load("assets/images/mili.png")).buffer.asUint8List(),
    );
    final busImage = pw.MemoryImage(
      (await rootBundle.load("assets/images/bus3.png")).buffer.asUint8List(),
    );

    final mainbody = pw.Container(
      height: 250,
      width: double.maxFinite,
      decoration: pw.BoxDecoration(
        image: pw.DecorationImage(image: bgImage),

        border: pw.Border.all(
          color: PdfColors.grey900,
          width: 1,
          style: pw.BorderStyle.dashed,
        ),
        borderRadius: pw.BorderRadius.circular(4),
      ),
      child: pw.Padding(
        padding: pw.EdgeInsets.all(1),
        child: pw.Row(
          children: [
            pw.Expanded(
              flex: 1,
              child: pw.Container(
                decoration: pw.BoxDecoration(
                  borderRadius: pw.BorderRadius.circular(4),
                ),

                child: pw.Column(
                  children: [
                    pw.Expanded(
                      flex: 1,
                      child: pw.Container(
                        decoration: pw.BoxDecoration(
                          color: PdfColor.fromHex("6B21A8"),
                          borderRadius: pw.BorderRadius.only(
                            topLeft: pw.Radius.circular(4),
                          ),
                        ),
                        alignment: pw.Alignment.bottomRight,
                        child: pw.Padding(
                          padding: pw.EdgeInsets.all(4),
                          child: pw.Text(
                            "Vendor/ Agent / Bus Operator",
                            style: pw.TextStyle(
                              color: PdfColors.white,
                              fontSize: 8,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    pw.Expanded(
                      flex: 7,
                      child: pw.Padding(
                        padding: pw.EdgeInsets.all(10),
                        child: pw.Container(
                          child: pw.Column(
                            children: [
                              pw.Container(
                                height: 25,
                                width: double.maxFinite,
                                decoration: pw.BoxDecoration(
                                  color: PdfColor.fromHex("E5E7EB"),
                                  borderRadius: pw.BorderRadius.circular(2),
                                ),
                                child: pw.Column(
                                  mainAxisAlignment: pw.MainAxisAlignment.end,
                                  children: [
                                    pw.Padding(
                                      padding: pw.EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      child: pw.Row(
                                        mainAxisAlignment:
                                            pw.MainAxisAlignment.spaceBetween,
                                        children: [
                                          pw.Text(
                                            "Taloqan",
                                            style: pw.TextStyle(
                                              fontSize: 8,
                                              color: PdfColors.black,
                                              fontWeight: pw.FontWeight.bold,
                                            ),
                                          ),
                                          pw.Image(busImage, height: 20),
                                          pw.Text(
                                            "Kabul",
                                            style: pw.TextStyle(
                                              fontSize: 8,
                                              color: PdfColors.black,
                                              fontWeight: pw.FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              pw.SizedBox(height: 15),
                              pw.Row(
                                children: [
                                  pw.Text(
                                    "Bus",
                                    style: pw.TextStyle(
                                      fontSize: 8,
                                      color: PdfColors.grey,
                                    ),
                                  ),
                                  pw.Spacer(),
                                  pw.Text(
                                    "Name of Service",
                                    style: pw.TextStyle(
                                      fontSize: 8,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                  pw.SizedBox(width: 20),
                                ],
                              ),
                              pw.SizedBox(height: 8),
                              pw.Row(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceBetween,
                                children: [
                                  pw.Text(
                                    "Traveler",
                                    style: pw.TextStyle(
                                      fontSize: 8,
                                      color: PdfColors.grey,
                                    ),
                                  ),
                                  pw.Spacer(),
                                  pw.Text(
                                    "Zabihullah Sirat",
                                    style: pw.TextStyle(
                                      fontSize: 8,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                  pw.SizedBox(width: 20),
                                ],
                              ),
                              pw.SizedBox(height: 8),
                              pw.Row(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceBetween,
                                children: [
                                  pw.Text(
                                    "Total Amount",
                                    style: pw.TextStyle(
                                      fontSize: 8,
                                      color: PdfColors.grey,
                                    ),
                                  ),
                                  pw.Spacer(),
                                  pw.Text(
                                    "700",
                                    style: pw.TextStyle(
                                      fontSize: 8,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                  pw.SizedBox(width: 20),
                                ],
                              ),
                              pw.SizedBox(height: 8),
                              pw.Row(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceBetween,
                                children: [
                                  pw.Text(
                                    "Remaining Amount",
                                    style: pw.TextStyle(
                                      fontSize: 8,
                                      color: PdfColors.grey,
                                    ),
                                  ),
                                  pw.Spacer(),
                                  pw.Text(
                                    "0",
                                    style: pw.TextStyle(
                                      fontSize: 8,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                  pw.SizedBox(width: 20),
                                ],
                              ),
                              pw.SizedBox(height: 8),
                              pw.Row(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceBetween,
                                children: [
                                  pw.Text(
                                    "Seat Number",
                                    style: pw.TextStyle(
                                      fontSize: 8,
                                      color: PdfColors.grey,
                                    ),
                                  ),
                                  pw.Spacer(),
                                  pw.Text(
                                    "D4",
                                    style: pw.TextStyle(
                                      fontSize: 8,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                  pw.SizedBox(width: 20),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    pw.Expanded(
                      flex: 2,
                      child: pw.Container(
                        color: PdfColor.fromHex("E5E7EB"),

                        child: seatNumberWithBarcode(seatNumber: "BUS-47-L"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            pw.VerticalDivider(width: 1, thickness: 1, color: PdfColors.grey),
            // pw.Container(width: 2, height: 50, color: PdfColors.white),
            pw.Expanded(
              flex: 2,
              child: pw.Container(
                // color: PdfColor.fromHex("6B21A8"),
                child: pw.Column(
                  children: [
                    pw.Expanded(
                      flex: 1,
                      child: pw.Container(
                        decoration: pw.BoxDecoration(
                          color: PdfColor.fromHex("6B21A8"),
                          borderRadius: pw.BorderRadius.only(
                            topRight: pw.Radius.circular(4),
                          ),
                        ),
                        alignment: pw.Alignment.bottomRight,
                        child: pw.Padding(
                          padding: pw.EdgeInsets.all(4),
                          child: pw.Text(
                            "Customer",
                            style: pw.TextStyle(
                              color: PdfColors.white,
                              fontSize: 8,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    pw.Expanded(flex: 7, child: pw.Container()),
                    pw.Expanded(
                      flex: 2,
                      child: pw.Container(color: PdfColor.fromHex("E5E7EB")),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

    final bodyarea = pw.Container(
      height: 350,
      color: PdfColors.grey,
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          // pw.Image(pw.MemoryImage(logo), height: 60),
          pw.Container(
            width: 200,

            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [],
            ),
          ),
        ],
      ),
    );
    final divider = pw.Divider(thickness: 1, color: PdfColors.grey);

    final footerarea = pw.Container(
      height: 5,
      color: PdfColors.grey.shade(0.20),
      child: pw.Row(children: []),
    );
    final gap15 = pw.SizedBox(height: 15);
    final fullgap = pw.Expanded(
      flex: 1,
      fit: pw.FlexFit.tight,
      child: pw.Container(),
    );

    // widgets.add(headerarea);

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.only(left: 40, right: 40, top: 40),
        build: (pw.Context context) {
          return [mainbody];
        },

        // footer: (context) {
        //   if (context.pageNumber == context.pagesCount) {
        //     return pw.Container(
        //       padding: const pw.EdgeInsets.only(top: 8),
        //       child: totaprice,
        //     );
        //   }
        //   return pw.SizedBox();
        // },
      ),
    );

    return pdf.save();
  }

  Future<void> savePdfFile(String fileName, Uint8List byteList) async {
    final output = await getTemporaryDirectory();
    var filePath = "${output.path}/$fileName.pdf";
    final file = File(filePath);
    await file.writeAsBytes(byteList);
    await OpenFile.open(filePath);
  }
}

pw.Widget seatNumberWithBarcode({required String seatNumber}) {
  final barcode = Barcode.code128();

  return pw.Row(
    mainAxisAlignment: pw.MainAxisAlignment.end,
    children: [
      pw.Padding(
        padding: pw.EdgeInsets.all(4),
        child: pw.Container(
          color: PdfColors.white,
          child: pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.end,
            children: [
              // Barcode
              pw.Padding(
                padding: pw.EdgeInsets.symmetric(horizontal: 4),
                child: pw.Container(
                  width: 80,
                  height: 30,
                  child: pw.BarcodeWidget(
                    barcode: barcode,
                    data: seatNumber,
                    drawText: false,
                  ),
                ),
              ),
              pw.SizedBox(height: 2),
              pw.Text(
                seatNumber,
                style: pw.TextStyle(
                  fontSize: 6,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
