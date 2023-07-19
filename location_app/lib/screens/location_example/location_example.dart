import 'package:flutter/material.dart';
import 'package:location_app/providers/location_provider.dart';
import 'package:provider/provider.dart';

class LocationExample extends StatefulWidget {
  const LocationExample({super.key});

  @override
  State<LocationExample> createState() => _LocationExampleState();
}

class _LocationExampleState extends State<LocationExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer<LocationProvider>(
          builder: (context, value, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      value.getCurrentPosition();
                    },
                    child: value.isLoading
                        ? const CircularProgressIndicator()
                        : const Text(
                            "Get current device location",
                            style: TextStyle(fontSize: 20),
                          )),
                const SizedBox(height: 20),
                Text(
                  'Latitude is : ${value.position?.latitude}',
                  style: const TextStyle(fontSize: 20),
                ),
                Text(
                  'longitude is : ${value.position?.longitude} ',
                  style: const TextStyle(fontSize: 20),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
