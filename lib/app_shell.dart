import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parklille/screens/home_screen.dart';

class AppShell extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AppShellState();
  }
}

class _AppShellState extends State<AppShell> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: HomeScreen(title: 'ParkLille'),
      bottomNavigationBar: BottomNavigationBar(items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.explore),
          title: Text('Parking'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.local_parking),
          title: Text('Voiture'),
        ),
      ]),
    );
  }
}
