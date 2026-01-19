import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../draftpage/draftticketviewscreen.dart';
import '../pdftemplate/default_template.dart';

class Draftseatscreen extends StatelessWidget {
  Draftseatscreen({super.key});

  final DefaultTemplate defaultTemplate = DefaultTemplate();

  int row = 3; // seats per row
  int colum = 4;
  int totalseat = 23;

  @override
  Widget build(BuildContext context) {
    int leftSeatCount = 0;
    int rightSeatCount = 0;

    if (row == 4) {
      leftSeatCount = 2;
      rightSeatCount = 2;
    } else if (row == 3) {
      leftSeatCount = 1;
      rightSeatCount = 2;
    }

    int totalRows = (totalseat / row).ceil();

    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: totalRows,
        itemBuilder: (context, rowIndex) {
          int seatsUsed = rowIndex * row;
          int remainingSeats = totalseat - seatsUsed;

          int currentRowSeats = remainingSeats >= row ? row : remainingSeats;

          int currentLeftSeats = currentRowSeats >= leftSeatCount
              ? leftSeatCount
              : currentRowSeats;

          int currentRightSeats = currentRowSeats - currentLeftSeats;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                /// LEFT SIDE
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      currentLeftSeats,
                      (index) => Padding(
                        padding: EdgeInsets.all(6),
                        child: GestureDetector(
                          onTap: () async {
                            Uint8List data;
                            data = await defaultTemplate.generatePDF();

                            // Get.to(() => Draftticketviewscreen(pdfBytes: data));
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    Draftticketviewscreen(pdfBytes: data),
                              ),
                            );
                          },

                          child: Image.asset(
                            'assets/icons/seat.png',
                            height: 40,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                /// RIGHT SIDE
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      currentRightSeats,
                      (index) => Padding(
                        padding: const EdgeInsets.all(6),
                        child: Image.asset('assets/icons/seat.png', height: 40),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
