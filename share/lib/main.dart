import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(EntryPoint());
}

class EntryPoint extends StatelessWidget {
  const EntryPoint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RootWidget(),
    );
  }
}

class RootWidget extends StatelessWidget {
  const RootWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          Positioned(
            child: FaIcon(
              FontAwesomeIcons.locationArrow,
              color: Colors.blue,
              size: 128,
            ),
            right: -20,
            top: 25,
          ),
          Positioned(
            child: Image.asset("assets/images/oldlady.png"),
            top: 250,
            right: 100,
          )
        ],
      ),
    );
  }
}
