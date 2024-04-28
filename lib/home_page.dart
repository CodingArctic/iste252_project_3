import 'dart:async';

import 'package:flutter/material.dart';

// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'package:mobile_scanner/mobile_scanner.dart';

enum SizeChoices { small, medium, large }

final MobileScannerController controller = MobileScannerController(
  // required options for the scanner
);

StreamSubscription<Object?>? _subscription;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {

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
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => BarcodeScannerWithOverlay(),
                  ),
                );
              },
              child: const Text('MobileScanner with Overlay'),
            ),
      ],
    );
  }
}
