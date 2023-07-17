import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:test_example/main.dart';
import 'package:workmanager/workmanager.dart';

class TestLatLangData extends StatefulWidget {
  const TestLatLangData({super.key});

  @override
  State<TestLatLangData> createState() => _TestLatLangDataState();
}

class _TestLatLangDataState extends State<TestLatLangData> {
  String? latValue;
  String? longValue;
  bool positionStreamStarted = false;

  @override
  void initState() {
    _determinePosition();
    // Workmanager().initialize(
    //     callbackDispatcher, // The top level function, aka callbackDispatcher
    //     isInDebugMode:
    //         true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
    //     );

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Text('The Lattitude of the location is $latValue'),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Text('The Long of the location is $latValue'),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.all(8),
              child: InkWell(
                onTap: () {
                  _determinePosition();
                },
                child: Text('Fetch Lat Lang Data'),
              ),
            )
          ],
        ),
      )),
    );
  }

  Future<Position> _determinePosition() async {
    print('coming to location service-------');
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Timer.periodic(Duration(seconds: 5), (Timer timer) async {
      print('coming to location service------2');
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      latValue = position.latitude.toString();
      longValue = position.longitude.toString();
      setState(() {});
    });
    return await Geolocator.getCurrentPosition();
  }

  // Future<void> initLocationTracking() async {
  // }

  // void fetchLocationForEvery10Sec() async {
  //   BackgroundFetch.configure(
  //       BackgroundFetchConfig(
  //         minimumFetchInterval: 10, // Fetch interval in seconds
  //         stopOnTerminate: false,
  //         startOnBoot: true,
  //         enableHeadless: true,
  //       ),
  //       initLocationTracking);
  // }
}
