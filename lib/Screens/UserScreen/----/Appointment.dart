import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:teledoctor_project/Components/DrList.dart';
import 'package:teledoctor_project/Components/TextWidgets.dart';
import 'package:teledoctor_project/Screens/HomeScreen/HomeScreen.dart';

class Appointment extends StatefulWidget {
  final int index;
  final ImageProvider<Object> doctorImage;

  Appointment(this.index, {Key? key, required this.doctorImage}) : super(key: key);

  @override
  State<Appointment> createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  late Size size;
  bool animate = false;
  double opacity = 0.0;
  List<bool> time = List.generate(6, (index) => false);
  DateTime? selectedDate;
  int? selectedTimeIndex;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      animator();
    });
  }

  void animator() {
    setState(() {
      opacity = opacity == 0.0 ? 1.0 : 0.0;
      animate = !animate;
    });
  }

  Widget buildMainContent() {
    return Container(
      padding: EdgeInsets.only(top: 70),
      height: double.infinity,
      width: double.infinity,
      child: Stack(
        children: [
          _buildHeader(),
          _buildDatePicker(),
          _buildTimeText(),
          _buildTimeCards(),
          _buildBottomButton(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Positioned(
      top: 5,
      right: 20,
      left: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              animator();
              Timer(Duration(milliseconds: 500), () {
                Navigator.pop(context);
              });
            },
            child: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Colors.black,
            ),
          ),
          TextWidget(
            "Appointment",
            25,
            Colors.black,
            FontWeight.bold,
            letterSpace: 0,
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildDatePicker() {
    return Positioned(
      top: 70,
      left: 20,
      right: 20,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: SfDateRangePicker(
          selectionMode: DateRangePickerSelectionMode.single,
          backgroundColor: Colors.grey.withOpacity(.1),
          allowViewNavigation: true,
          enablePastDates: false,
          headerHeight: 100,
          selectionColor: Colors.blueAccent,
          toggleDaySelection: true,
          showNavigationArrow: true,
          selectionShape: DateRangePickerSelectionShape.rectangle,
          onSelectionChanged: (dateRangePickerSelectionChangedArgs) {
            setState(() {
              selectedDate = dateRangePickerSelectionChangedArgs.value;
            });
          },
          selectionTextStyle:
          const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          headerStyle: const DateRangePickerHeaderStyle(
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTimeText() {
    return Positioned(
      top: 390,
      left: 30,
      child: TextWidget(
        "Time",
        25,
        Colors.black,
        FontWeight.bold,
        letterSpace: 0,
      ),
    );
  }

  Widget _buildTimeCards() {
    return Positioned(
      top: 440,
      left: 10,
      right: 10,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            6,
                (index) => InkWell(
              onTap: () {
                setState(() {
                  selectedTimeIndex = index;
                });
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 2,
                color: selectedTimeIndex == index ? Colors.blueAccent : Colors.white,
                child: Center(
                  child: SizedBox(
                    height: 60,
                    width: 110,
                    child: Center(
                      child: TextWidget(
                        "${(index + 9).toString().padLeft(2, '0')}:00 ${index < 2 ? 'Am' : 'Pm'}",
                        17,
                        Colors.black,
                        FontWeight.bold,
                        letterSpace: 1,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomButton() {
    return Positioned(
      bottom: 10,
      left: 30,
      right: 30,
      child: InkWell(
        onTap: () {
          if (selectedDate == null || selectedTimeIndex == null) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text("Error"),
                content: Text("Please select both date and time."),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("OK"),
                  ),
                ],
              ),
            );
          } else {
            showModalBottomSheet(
              barrierColor: Colors.black.withOpacity(.8),
              backgroundColor: Colors.transparent,
              isDismissible: true,
              context: context,
              builder: (context) {
                int randomIndex = Random().nextInt(names.length);

                return SizedBox(
                  height: MediaQuery.of(context).size.height / 1.7,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: MediaQuery.of(context).size.height / 1.9,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(color: Colors.white, blurRadius: 40),
                            ],
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.topRight,
                              colors: [
                                Colors.blueAccent,
                                Colors.green,
                                Colors.red,
                                Colors.white,
                                Colors.yellow,
                              ],
                            ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
                          height: MediaQuery.of(context).size.height / 1.93,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                            ),
                          ),
                          child: Center(
                            child: Column(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.black.withOpacity(.1),
                                  radius: 60,
                                  child: const Center(
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.blueAccent,
                                      size: 30,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  "Done",
                                  style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(height: 10),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(builder: (c) {
                                        return HomeScreen();
                                      }),
                                    );
                                  },
                                  child: Text(
                                    'Return Home',
                                    style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(color: Colors.white, blurRadius: 10, offset: Offset(0, 10)),
                              BoxShadow(color: Colors.transparent, offset: Offset(10, 0)),
                              BoxShadow(color: Colors.transparent, offset: Offset(-10, 0)),
                            ],
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: widget.doctorImage, // Use the provided doctor's image
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
        child: Container(
          height: 65,
          width: size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.blueAccent,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextWidget(
                "Book an appointment",
                18,
                Colors.white,
                FontWeight.w500,
                letterSpace: 1,
              ),
              const SizedBox(width: 4),
              const Icon(
                Icons.arrow_forward_ios_outlined,
                color: Colors.white,
                size: 18,
              ),
              Icon(
                Icons.arrow_forward_ios_outlined,
                color: Colors.white.withOpacity(.5),
                size: 18,
              ),
              Icon(
                Icons.arrow_forward_ios_outlined,
                color: Colors.white.withOpacity(.2),
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: Duration(milliseconds: 400),
              top: animate ? 1 : 80,
              left: 1,
              bottom: 1,
              right: 1,
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 400),
                opacity: opacity,
                child: buildMainContent(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

