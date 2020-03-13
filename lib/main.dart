import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:parklille/app_shell.dart';

Future<void> main() async {
  await DotEnv().load('.env');
  return runApp(Main());
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ParkInLille',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: AppShell(),
    );
  }
}


