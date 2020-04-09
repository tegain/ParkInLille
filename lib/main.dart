import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:parklille/app_shell.dart';
import 'package:parklille/services/features.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();

  FeaturesService featuresService = FeaturesService();
  await featuresService.fetchFeatures();

  return runApp(
    ChangeNotifierProvider(
      create: (context) => featuresService,
      child: Main(),
    ),
  );
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
