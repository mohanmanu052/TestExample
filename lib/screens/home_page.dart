import 'package:flutter/material.dart';
import 'package:test_example/methodChannels/blutooth_channel.dart';
import 'package:test_example/screens/profile_screen.dart';
import 'package:test_example/screens/random_image_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RandomDogImageScreen()));
                },
                child: Text('Random Dog Images')),
            ElevatedButton(
                onPressed: () {
                  BluetoothChannel.enableBluetooth();
                },
                child: Text('Enable Blutooh')),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProfileView()));
                },
                child: Text('Profile')),
          ],
        ),
      )),
    );
  }
}
