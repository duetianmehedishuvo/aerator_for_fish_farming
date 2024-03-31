import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:women_safety/data/model/response/orginal_data_model.dart';
import 'package:women_safety/helper/message_dao.dart';
import 'package:women_safety/provider/auth_provider.dart';
import 'package:women_safety/util/size.util.dart';
import 'package:women_safety/util/theme/app_colors.dart';
import 'package:women_safety/util/theme/text.styles.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Stream<OrginalDataModel> productsStream() async* {
    while (true) {
      await Future.delayed(const Duration(seconds: 3));
      OrginalDataModel orginalDataModel = await Provider.of<AuthProvider>(context, listen: false).getAllData();
      yield orginalDataModel;
    }
  }

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
            stream: productsStream(),
            builder: (c, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Center(child: Text('None'));
                  break;
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                  break;
                case ConnectionState.active:
                  bool status = int.parse(snapshot.data!.motorStatus.toString()) == 1;

                  return buildBuilder(snapshot, status);
                  break;
                case ConnectionState.done:
                  if (snapshot.hasData) {
                    bool status = int.parse(snapshot.data!.motorStatus.toString()) == 1;

                    return buildBuilder(snapshot, status);
                  } else if (snapshot.hasError) {
                    return Text('Has Error');
                  } else {
                    return Text('Error');
                  }
                  break;
                case ConnectionState.active:
                // TODO: Handle this case.
              }
              return Text('Non in Switch');

              // if (snapshot.hasError) {
              //   return Text(snapshot.error.toString());
              // } else if (!snapshot.hasData) {
              //   return const Center(child: CircularProgressIndicator());
              // }
              //
            }),
      ),
    );
  }

  Builder buildBuilder(AsyncSnapshot<OrginalDataModel> snapshot, bool status) {
    return Builder(builder: (context) {
      return Consumer<AuthProvider>(
          builder: (context, authProvider, child) => Column(
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
                        eachRow("Oxygen Voltage", '${snapshot.data!.adcVoltage} v'),
                        eachRow("Dissolved Oxygen", "${snapshot.data!.do1} ppm"),
                        eachRow("Ph Voltage", '${snapshot.data!.phVoltage} v'),
                        eachRow("Ph Value", "${snapshot.data!.phValue} Ph"),
                        eachRow("Water Temperature", '${snapshot.data!.temperatureC} °C'),
                        eachRow(
                          "Motor Status",
                          status ? "ON" : "OFF",
                          widget: Container(
                            height: 18,
                            width: 20,
                            alignment: Alignment.centerRight,
                            child: Switch(
                              onChanged: (bool value) {
                                authProvider.updateAllData(status ? 0 : 1);
                                // MessageDao.messagesRef.ref.child("SENSOR_DATA").update({"motor_status": status ? "0" : "1"});
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
                  Center(child: Text("Developed by Prof. Dr. Obaidur Rahman, LAB.", style: sfProStyle400Regular.copyWith(fontSize: 16))),
                  const SizedBox(height: 20),
                ],
              ));
    });
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
