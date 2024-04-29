import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart' as qr;

class GeneratePage extends StatefulWidget {
  const GeneratePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<GeneratePage> createState() => _GeneratePageState();
}

class _GeneratePageState extends State<GeneratePage> {
  String qrData="";
  final qrdataFeed = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Generate QR Code',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: qrdataFeed,
                decoration: const InputDecoration(
                  hintText: 'Enter the data for QR Code',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (qrdataFeed.text.isEmpty) {
                  //a little validation for the textfield
                  setState(() {
                    qrData = "";
                  });
                } else {
                  setState(() {
                    qrData = qrdataFeed.text;
                  });
                }
              },
              child: const Text('Generate QR Code'),
            ),
            qr.QrImageView(
              data: qrData,
              version: qr.QrVersions.auto,
              size: 200.0,
              backgroundColor: Colors.white,
            )
          ],
        ),
      )
    );   
  }
}