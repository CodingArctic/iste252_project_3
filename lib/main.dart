import 'package:flutter/material.dart';

import 'bottom_nav_bar.dart';

import 'package:localstorage/localstorage.dart';
import 'dart:convert';

import 'package:iste252_project_3/qrcode.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLocalStorage();

  runApp(const MyApp());
}

String qrcodesToJson(List<Qrcode> qrcodes) {
  List<Map<String, dynamic>> qrcodeMaps =
      qrcodes.map((qrcode) => qrcode.toMap()).toList();
  return jsonEncode(qrcodeMaps);
}

List<Qrcode> qrcodesFromJson(String jsonString) {
  List<Map<String, dynamic>> qrcodeMaps =
      List<Map<String, dynamic>>.from(jsonDecode(jsonString));
  return qrcodeMaps.map((qrcodeMap) => Qrcode.fromMap(qrcodeMap)).toList();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    String historyString = localStorage.getItem('history').toString();
    if (historyString == "null") {
        print("history string null, setting to sample data");
        localStorage.setItem('history', qrcodesToJson(sampleQrcodes));
    } 
  }

    List<Qrcode> sampleQrcodes = [
    Qrcode(url: 'https://rit.edu', imgUrl: '0'),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
        brightness: Brightness.dark,
      ),
      home: const BasicBottomNavBar(),
    );
  }
}
