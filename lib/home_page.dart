import 'dart:async';

import 'package:iste252_project_3/qrcode.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:localstorage/localstorage.dart';

final MobileScannerController controller = MobileScannerController(
    // required options for the scanner
    );

StreamSubscription<Object?>? _subscription;

_launchURL(String urlToLaunch) async {
  final Uri url = Uri.parse(urlToLaunch.toString());
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  String url = "";
  List<Qrcode> historyObj =
      qrcodesFromJson(localStorage.getItem('history').toString());

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        return;
      case AppLifecycleState.resumed:
        // Restart the scanner when the app is resumed.
        // Don't forget to resume listening to the barcode events.
        _subscription = controller.barcodes.listen(_handleBarcode);

        unawaited(controller.start());
      case AppLifecycleState.inactive:
        // Stop the scanner when the app is paused.
        // Also stop the barcode events subscription.
        unawaited(_subscription?.cancel());
        _subscription = null;
        unawaited(controller.stop());
    }
  }

  @override
  void initState() {
    super.initState();
    // Start listening to lifecycle changes.
    WidgetsBinding.instance.addObserver(this);

    // Start listening to the barcode events.
    _subscription = controller.barcodes.listen(_handleBarcode);

    // Finally, start the scanner itself.
    unawaited(controller.start());
  }

  @override
  Future<void> dispose() async {
    // Stop listening to lifecycle changes.
    WidgetsBinding.instance.removeObserver(this);
    // Stop listening to the barcode events.
    unawaited(_subscription?.cancel());
    _subscription = null;
    // Dispose the widget itself.
    super.dispose();
    // Finally, dispose of the controller.
    // await controller.dispose();
  }

  bool isDialogShowing = false;

  void _handleBarcode(BarcodeCapture capture) {
    if (isDialogShowing) {
      return;
    }

    didChangeAppLifecycleState(AppLifecycleState.inactive);

    setState(() {
      url = capture.barcodes.first.displayValue.toString();
    });

    Qrcode newQR = Qrcode(url: url, imgUrl: "0");
    historyObj.add(newQR);
    localStorage.setItem('history', qrcodesToJson(historyObj));

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Scanned Code'),
          content: Text('The scanned code is: $url'),
          actions: <Widget>[
            TextButton(
              child: const Text('Open Link'),
              onPressed: () {
                Navigator.of(context).pop();
                didChangeAppLifecycleState(AppLifecycleState.resumed);
                isDialogShowing = false;
                try {
                  _launchURL(url);
                } on Exception {
                  // not a url, ignore
                }
              },
            ),
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
                didChangeAppLifecycleState(AppLifecycleState.resumed);
                isDialogShowing = false;
              },
            ),
          ],
        );
      },
    );

    isDialogShowing = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code Scanner'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * .7,
              width: MediaQuery.of(context).size.width * .8,
              child: MobileScanner(controller: controller),
            ),
          ),
        ],
      ),
    );
  }
}
