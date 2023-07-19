import 'package:flutter/material.dart';
import 'package:location_app/screens/maps_example/maps_example.dart';
import 'package:location_app/utils/util_function.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 2),
      () {
        Utilfunctions.navigateTo(context, const MapExample());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_location,
              color: Colors.red,
              size: 100,
            ),
            Text(
              "Location App",
              style: TextStyle(fontSize: 30),
            )
          ],
        ),
      ),
    );
  }
}
