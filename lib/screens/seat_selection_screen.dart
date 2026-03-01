import 'package:busbooking/controllers/seat_plan_controller.dart';
import 'package:busbooking/utils/colors.dart';
import 'package:busbooking/widgets/auth_textfield.dart';
import 'package:busbooking/widgets/default_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../controllers/create_ticket_controller.dart';
import '../controllers/customer_profile_controller.dart';
import '../controllers/seat_select_controller.dart';
import '../globalcontroller/languages_controller.dart';
import '../globalcontroller/page_controller.dart';
import '../widgets/custom_text.dart';

double kSeatSize = 52;
double kSeatGap = 8;

class SeatSelectionScreen extends StatefulWidget {
  SeatSelectionScreen({super.key, this.tripId});
  final String? tripId;

  @override
  State<SeatSelectionScreen> createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen> {
  final mypagecontroller = Get.find<Mypagecontroller>();
  final SeatSelectionController seatSelectionController = Get.put(
    SeatSelectionController(),
  );

  final SeatPlanController seatPlanController = Get.put(SeatPlanController());

  CreateTicketController createTicketController = Get.put(
    CreateTicketController(),
  );
  final languagesController = Get.find<LanguagesController>();
  final box = GetStorage();

  @override
  void initState() {
    super.initState();

    createTicketController.tickets.clear();

    seatSelectionController.clearSelection();
  }

  // ───────────────── Seat layout config ─────────────────
  ({int left, int right}) splitConfig(int column) => switch (column) {
    3 => (left: 1, right: 2),
    4 => (left: 2, right: 2),
    5 => (left: 2, right: 3),
    _ => (left: 2, right: 2),
  };

  double aisleGap(int column) => column == 5 ? 20 : 32;

  // ───────────────── Single seat widget (image based) ─────────────────
  Widget buildSeat(dynamic data) {
    final int row = data.row ?? 0;
    final int col = data.column ?? 0;

    final seatLabel = "${String.fromCharCode(64 + row)}$col";

    final double seatPrice = data.price is num
        ? (data.price as num).toDouble()
        : double.tryParse(data.price?.toString() ?? "0") ?? 0;

    final seatPrices =
        seatPlanController.allseatlist.value.body?.item?.seatPrices ?? [];

    final seatPriceObj = seatPrices.firstWhere(
      (sp) => sp["seat_number"] == data.seatNumber,
      orElse: () => null,
    );

    final int? seatPriceId = seatPriceObj != null
        ? seatPriceObj["id"] as int?
        : null;

    final bool isBooked =
        seatPriceObj != null &&
        (seatPriceObj["status"] != "available" ||
            seatPriceObj["is_avaiable"] == false);

    final bool isSelected = seatSelectionController.isSelected(seatLabel);

    return GestureDetector(
      onTap: () {
        if (isBooked) return;

        seatSelectionController.toggleSeat(
          seatLabel: seatLabel,
          price: seatPrice,
        );

        if (isSelected) {
          // DESELECT
          createTicketController.removeSeat(seatPriceId!);
        } else {
          // SELECT
          createTicketController.addSeat(seatPriceId!);
        }

        print(createTicketController.tickets.toJson());
      },
      child: Container(
        width: kSeatSize,
        height: kSeatSize,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              isBooked
                  ? "assets/icons/seatbooked.png"
                  : isSelected
                  ? "assets/icons/seatfill.png"
                  : "assets/icons/seat.png",
            ),
            fit: BoxFit.contain,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          seatLabel,
          style: TextStyle(
            color: (isBooked || isSelected) ? Colors.white : Color(0xff8576FF),
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  // ───────────────── Row builder ─────────────────
  Widget buildRow(List seats, int startIndex, int count, int column) {
    final (:left, :right) = splitConfig(column);
    final leftCount = count < left ? count : left;
    final rightCount = count - leftCount;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: List.generate(left, (i) {
              if (i >= leftCount) {
                return SizedBox(width: kSeatSize);
              }
              return Padding(
                padding: EdgeInsets.only(right: i < left - 1 ? kSeatGap : 0),
                child: buildSeat(seats[startIndex + i]),
              );
            }),
          ),
          SizedBox(width: aisleGap(column)),
          Row(
            children: List.generate(right, (i) {
              if (i >= rightCount) {
                return SizedBox(width: kSeatSize);
              }
              return Padding(
                padding: EdgeInsets.only(left: i > 0 ? kSeatGap : 0),
                child: buildSeat(seats[startIndex + leftCount + i]),
              );
            }),
          ),
        ],
      ),
    );
  }

  // ───────────────── Full seat grid ─────────────────
  List<Widget> buildSeatGrid(List seats, int column) {
    final rows = <Widget>[];
    final fullRows = seats.length ~/ column;
    final lastRowSeats = seats.length % column;

    for (int i = 0; i < fullRows; i++) {
      rows.add(buildRow(seats, i * column, column, column));
    }

    if (lastRowSeats > 0) {
      rows.add(buildRow(seats, fullRows * column, lastRowSeats, column));
    }

    return rows;
  }

  // ───────────────── BUILD ─────────────────
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        mypagecontroller.goBack();
      },
      child: Scaffold(
        body: Container(
          height: screenHeight,
          width: screenWidth,
          child: Stack(
            children: [
              Container(
                height: 250,
                width: screenWidth,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/buspageheader.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: Colors.white,
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                FontAwesomeIcons.chevronLeft,
                                color: Colors.white,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: KText(
                                text: languagesController.tr("SELECT_SEAT"),
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text(
                                        languagesController.tr("LANGUAGES"),
                                      ),
                                      content: SizedBox(
                                        height: 350,
                                        width: MediaQuery.of(
                                          context,
                                        ).size.width,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: languagesController
                                              .alllanguagedata
                                              .length,
                                          itemBuilder: (context, index) {
                                            final data = languagesController
                                                .alllanguagedata[index];

                                            return GestureDetector(
                                              onTap: () {
                                                final languageName =
                                                    data["name"].toString();

                                                final matched =
                                                    languagesController
                                                        .alllanguagedata
                                                        .firstWhere(
                                                          (lang) =>
                                                              lang["name"] ==
                                                              languageName,
                                                          orElse: () => {
                                                            "isoCode": "en",
                                                            "direction": "ltr",
                                                          },
                                                        );

                                                final languageISO =
                                                    matched["isoCode"]!;
                                                final languageDirection =
                                                    matched["direction"]!;

                                                // Save & apply
                                                languagesController
                                                    .changeLanguage(
                                                      languageName,
                                                    );
                                                box.write(
                                                  "language",
                                                  languageName,
                                                );
                                                box.write(
                                                  "direction",
                                                  languageDirection,
                                                );

                                                // Map iso → Locale
                                                Locale locale;
                                                switch (languageISO) {
                                                  case "fa":
                                                    locale = Locale("fa", "IR");
                                                    break;
                                                  case "ar":
                                                    locale = Locale("ar", "AE");
                                                    break;
                                                  case "ps":
                                                    locale = Locale("ps", "AF");
                                                    break;
                                                  case "tr":
                                                    locale = Locale("tr", "TR");
                                                    break;
                                                  case "bn":
                                                    locale = Locale("bn", "BD");
                                                    break;
                                                  case "en":
                                                  default:
                                                    locale = Locale("en", "US");
                                                }

                                                setState(() {
                                                  EasyLocalization.of(
                                                    context,
                                                  )!.setLocale(locale);
                                                });

                                                Navigator.pop(context);
                                                debugPrint(
                                                  "🌐 Language: $languageName ($languageISO), dir: $languageDirection",
                                                );
                                              },
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                  bottom: 5,
                                                ),
                                                height: 45,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    width: 1,
                                                    color: Colors.grey.shade300,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                ),
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  data["fullname"].toString(),
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.white,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.menu, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // ───────── Seat area container ─────────
              Positioned(
                top: 120,
                left: 0,
                right: 0,

                child: Container(
                  height: screenHeight,
                  width: screenWidth,
                  padding: EdgeInsets.fromLTRB(18, 18, 18, 0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(40),
                    ),
                  ),
                  child: Obx(() {
                    if (seatPlanController.isLoading.value) {
                      return Center(child: CircularProgressIndicator());
                    }

                    final int column =
                        seatPlanController
                            .allseatlist
                            .value
                            .body
                            ?.item
                            ?.bus
                            ?.seats
                            ?.columns ??
                        1;

                    final seats =
                        seatPlanController
                            .allseatlist
                            .value
                            .body
                            ?.item
                            ?.bus
                            ?.seats
                            ?.seats
                            ?.where((s) => s.row != null && s.column != null)
                            .toList() ??
                        [];

                    seats.sort((a, b) {
                      final ar = a.row ?? 0;
                      final br = b.row ?? 0;
                      if (ar != br) return ar.compareTo(br);

                      final ac = a.column ?? 0;
                      final bc = b.column ?? 0;
                      return ac.compareTo(bc);
                    });

                    return SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(children: buildSeatGrid(seats, column)),
                    );
                  }),
                ),
              ),

              Positioned(
                bottom: 0,
                child: Container(
                  height: 110,
                  width: screenWidth,
                  decoration: BoxDecoration(
                    color: Color(0xff2D2882),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                // color: Colors.red,
                                child: Column(
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    KText(
                                      text: languagesController.tr("SEAT"),
                                      color: Colors.white,
                                      fontSize: 11,
                                    ),
                                    Obx(
                                      () =>
                                          seatSelectionController
                                              .selectedSeats
                                              .isEmpty
                                          ? Text(
                                              "Not Selected",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 11,
                                              ),
                                            )
                                          : Text(
                                              seatSelectionController
                                                  .selectedSeats
                                                  .join(", "),
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 11,
                                              ),
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            Expanded(
                              flex: 2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,

                                children: [
                                  KText(
                                    textAlign: TextAlign.center,
                                    text: languagesController.tr(
                                      "NUMBER_OF_PASSENGER",
                                    ),
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 10,
                                  ),
                                  Obx(
                                    () =>
                                        seatPlanController.isLoading.value ==
                                            false
                                        ? KText(
                                            textAlign: TextAlign.center,
                                            text:
                                                seatPlanController
                                                    .allseatlist
                                                    .value
                                                    .body!
                                                    .item!
                                                    .totalSeats
                                                    .toString() +
                                                " "
                                                    "People",
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12,
                                          )
                                        : SizedBox(),
                                  ),
                                ],
                              ),
                            ),

                            Expanded(
                              flex: 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  KText(
                                    text: languagesController.tr("AMOUNT"),
                                    color: Colors.white,
                                    fontSize: 11,
                                  ),
                                  Obx(
                                    () => Text(
                                      seatSelectionController.totalAmount
                                          .toStringAsFixed(0),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            if (createTicketController.tickets.isNotEmpty) {
                              createTicketController.amount.value =
                                  seatSelectionController.totalAmount
                                      .toStringAsFixed(0);
                              createTicketController.tripId.value = widget
                                  .tripId
                                  .toString();
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return BookingDialogBox();
                                },
                              );
                            } else {
                              Get.snackbar(
                                backgroundColor: Colors.white,

                                languagesController.tr("PLEASE"),
                                languagesController.tr("SELECT_A_SEAT_FIRST"),
                              );
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 10,
                              ),
                              child: Center(
                                child: KText(
                                  text: languagesController.tr(
                                    "CONFIRMATION_AND_PAYMENT",
                                  ),
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BookingDialogBox extends StatefulWidget {
  BookingDialogBox({super.key});

  @override
  State<BookingDialogBox> createState() => _BookingDialogBoxState();
}

class _BookingDialogBoxState extends State<BookingDialogBox>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final languagesController = Get.find<LanguagesController>();

  String bookingType = "myself"; // radio state

  CreateTicketController createTicketController = Get.put(
    CreateTicketController(),
  );

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onRadioChanged(String value) {
    setState(() {
      bookingType = value;
      _tabController.index = value == "myself" ? 0 : 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: screenWidth,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),

              /// 🔹 Header
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Color(0xff00CED1),
                    radius: 8,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 3,
                    ),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      print(createTicketController.tripId.toString());
                      print(createTicketController.amount.toString());
                      print(createTicketController.tickets.toString());
                    },
                    child: KText(
                      text: languagesController.tr("RESERVE_FOR"),
                      fontSize: 15,
                      color: AppColors.boldfontColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),

              /// ✅ RADIO BUTTONS (KEPT)
              RadioGroup<String>(
                groupValue: bookingType,
                onChanged: (value) => _onRadioChanged(value!),
                child: Row(
                  children: [
                    Radio<String>(
                      activeColor: Colors.green,
                      value: "myself",
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity.compact,
                    ),
                    KText(text: languagesController.tr("MYSELF"), fontSize: 14),
                    SizedBox(width: 40),
                    Radio<String>(
                      value: "others",
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity.compact,
                    ),
                    KText(text: languagesController.tr("OTHERS"), fontSize: 14),
                  ],
                ),
              ),

              SizedBox(height: 15),

              /// ✅ TAB CONTENT (NO TAB BAR)
              SizedBox(
                height: 120,
                child: TabBarView(
                  controller: _tabController,
                  physics: NeverScrollableScrollPhysics(),
                  children: [_myselfContainer(), _othersContainer()],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _myselfContainer() {
    return Container(
      padding: EdgeInsets.all(0),
      // decoration: BoxDecoration(color: Colors.cyan),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyAuthTextfield(
            keyboardType: TextInputType.phone,
            controller: createTicketController.numberController,
            hint: languagesController.tr("PHONE_NUMBER"),
            hintTxtColor: Colors.grey,
            fontWeight: FontWeight.w600,
            borderRadius: 10,
            length: 10,
            txtfontWeight: FontWeight.w500,
          ),
          SizedBox(height: 10),
          Obx(
            () => DefaultButton(
              backgroundColor: createTicketController.isPhoneValid.value
                  ? Colors.green
                  : Colors.grey,
              onTap: () {
                createTicketController.isPhoneValid.value
                    ? createTicketController.createnow(context)
                    : null;
              },
              height: 50,
              child: KText(
                text: createTicketController.isLoading.value == false
                    ? languagesController.tr("GET_TICKET_NOW")
                    : languagesController.tr("PLEASE_WAIT"),
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _othersContainer() {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Other Person Name"),
          SizedBox(height: 10),
          Text("Other Person Phone"),
        ],
      ),
    );
  }
}
