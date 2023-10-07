import 'package:flutter/material.dart';
import 'package:video_palyer_app/di/network_module.dart';
import 'package:video_palyer_app/presentation/screen/main/main_screen.dart';

void main() {
  setUpNetworkApis();

  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MainScreen(),
  ));
}
