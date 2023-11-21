import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:women_safety/util/helper.dart';

//
// imageUrl,
// height: height == 0 ? MediaQuery.of(Helper.navigatorKey.currentState!.context).size.height : height,
Widget zoomableCustomNetworkImage(Uint8List imageUrl, {double? height}) {
  return PinchZoom(
    child: Image.memory(
      imageUrl,
      height: height == 0 ? MediaQuery.of(Helper.navigatorKey.currentState!.context).size.height : height,
    ),
    maxScale: 2.5,
    onZoomStart: () {
      print('Start zooming');
    },
    onZoomEnd: () {
      print('Stop zooming');
    },
  );
}
