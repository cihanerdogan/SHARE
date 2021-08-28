import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:share/screens/mapPage.dart';

void main() {
  runApp(EntryPoint());
}

class EntryPoint extends StatelessWidget {
  const EntryPoint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RootWidget(),
    );
  }
}

class RootWidget extends StatelessWidget {
  const RootWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(bottom: 50)),
            Image.asset("assets/images/splash.png"),
            Padding(padding: EdgeInsets.only(bottom: 50)),
            Text(
              "SHARE",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 48,
                  fontFamily: "arial",
                  fontWeight: FontWeight.w900),
            ),
            Text(
              "create the awareness",
              style: TextStyle(
                  color: Colors.grey,
                  fontFamily: "arial",
                  fontSize: 24,
                  fontWeight: FontWeight.normal),
            ),
            Padding(padding: EdgeInsets.only(bottom: 150)),
            SizedBox(
              width: 200,
              child: TextButton(
                onPressed: () => {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => IntroMapPage(),
                      ))
                },
                child: Text(
                  "Next",
                  style: TextStyle(fontSize: 24, color: Colors.black),
                ),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                      side: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
