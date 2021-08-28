import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class IntroMapPage extends StatefulWidget {
  const IntroMapPage({Key? key}) : super(key: key);

  @override
  Intro_MapPageState createState() => Intro_MapPageState();
}

class Intro_MapPageState extends State<IntroMapPage> {
  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<Position> _determinePosition() async {
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
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: _determinePosition(),
          builder: (context, AsyncSnapshot<Position> snapshot) {
            if (snapshot.hasData) {
              final pos = snapshot.data!;
              return Stack(children: [
                GoogleMap(
                  onMapCreated: _onMapCreated,
                  myLocationEnabled: true,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(pos.latitude, pos.longitude),
                    zoom: 16.0,
                  ),
                ),
                Positioned(
                  right: size.width * 0.02,
                  bottom: size.height * 0.12,
                  width: size.width * 0.96,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () => {},
                    child: Text("Are You Here?"),
                  ),
                ),
                Positioned(
                  bottom: size.height * 0.05,
                  left: size.width * 0.05,
                  width: size.width * 0.4,
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.green),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    child: Icon(Icons.check),
                    onPressed: () => {},
                  ),
                ),
                Positioned(
                  bottom: size.height * 0.05,
                  right: size.width * 0.05,
                  width: size.width * 0.4,
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.orange),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    child: Icon(Icons.refresh),
                    onPressed: () => {},
                  ),
                ),
              ]);
            } else {
              return Container(
                child: Center(child: CircularProgressIndicator()),
              );
            }
          },
        ),
      ),
    );
  }
}
