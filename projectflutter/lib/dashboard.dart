import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  final Key? key; // Make the key nullable

  Dashboard({this.key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Welcome",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 50,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
