import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_example/controller/home_controller.dart';
import 'package:test_example/services.dart';

class RandomDogImageScreen extends StatefulWidget {
  const RandomDogImageScreen({super.key});

  @override
  State<RandomDogImageScreen> createState() => _RandomDogImageScreenState();
}

class _RandomDogImageScreenState extends State<RandomDogImageScreen> {
  HomeController? controller;
  @override
  void initState() {
    controller = Provider.of<HomeController>(context, listen: false);
    controller?.getImageData();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
        builder: (context, HomeController controler, child) {
      return Scaffold(
          appBar: AppBar(),
          body: SafeArea(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                controler.imageurl,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.5,
                fit: BoxFit.fill,
                errorBuilder: (context, error, stackTrace) {
                  return Center(child: CircularProgressIndicator());
                },
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    controller?.onButtonTap();
                  },
                  child: Text('Retry'))
            ],
          )));
    });
  }
}
