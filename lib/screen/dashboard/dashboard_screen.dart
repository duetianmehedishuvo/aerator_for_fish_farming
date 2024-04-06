import 'package:flutter/material.dart';
import 'package:women_safety/helper/message_dao.dart';
import 'package:women_safety/util/size.util.dart';
import 'package:women_safety/util/theme/app_colors.dart';
import 'package:women_safety/util/theme/text.styles.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //     title: Text('IoT-based Solar Powered ', style: sfProStyle400Regular.copyWith(fontSize: 14, color: Colors.white)),
      //     centerTitle: true,
      //     backgroundColor: colorPrimary),
      body: SafeArea(
        child: StreamBuilder(
            stream: MessageDao.messagesRef.onValue,
            builder: (c, snapshot) {
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              bool status = int.parse(snapshot.data!.snapshot.child('SENSOR_DATA').children.elementAt(2).value.toString()) == 1;

              return Builder(builder: (context) {
                return Column(
                  children: [
                    Container(
                      width: getAppSizeWidth(),
                      height: 60,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          color: colorPrimary, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15))),
                      child: Text('Welcome,\nIoT-based Solar Powered Aerator for Fish Farming',
                          style: sfProStyle500Medium.copyWith(fontSize: 15, color: Colors.white)),
                    ),
                    Expanded(
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        children: [
                          eachRow("Oxygen Voltage", '${snapshot.data!.snapshot.child('SENSOR_DATA').children.elementAt(0).value.toString()} v'),
                          eachRow("Dissolved Oxygen", "${snapshot.data!.snapshot.child('SENSOR_DATA').children.elementAt(5).value.toString()} ppm"),
                          eachRow("Ph Voltage", '${snapshot.data!.snapshot.child('SENSOR_DATA').children.elementAt(3).value.toString()} v'),
                          eachRow("Ph Value", "${snapshot.data!.snapshot.child('SENSOR_DATA').children.elementAt(6).value.toString()} Ph"),
                          eachRow("Water Temperature", '${snapshot.data!.snapshot.child('SENSOR_DATA').children.elementAt(1).value.toString()} °C'),
                          eachRow(
                            "Motor Status",
                            status ? "ON" : "OFF",
                            widget: Container(
                              height: 18,
                              width:20,
                              alignment: Alignment.centerRight,
                              child: Switch(
                                onChanged: (bool value) {
                                  MessageDao.messagesRef.ref.child("SENSOR_DATA").update({"motor_status": status ? "0" : "1"});
                                },
                                value: status,
                                activeColor: Colors.white,
                                activeTrackColor: colorPrimary,
                                // inactiveThumbColor: Colors.blueGrey,
                                // inactiveTrackColor: Colors.grey,
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(child: Text("Develop From Prof. Dr. Obaidur Rahman LAB", style: sfProStyle400Regular.copyWith(fontSize: 16))),
                    const SizedBox(height: 20),
                  ],
                );
              });
            }),
      ),
    );
  }

  Widget eachRow(String key, String value, {Widget? widget}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(border: Border.all(color: colorIcons.withOpacity(.6)), borderRadius: BorderRadius.circular(4)),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(flex: 2, child: Text(key, style: sfProStyle600SemiBold.copyWith(fontSize: 14, color: Colors.black))),
            VerticalDivider(color: colorIcons.withOpacity(.6), thickness: 1.1),
            Expanded(child: widget ?? Text(value, textAlign: TextAlign.end, style: sfProStyle400Regular.copyWith(fontSize: 16, color: Colors.black))),
          ],
        ),
      ),
    );
  }
}
