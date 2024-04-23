import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key, required this.title});
  final String title;

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  Color color = Colors.yellow;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.purpleAccent,
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: () {
                setState(() {
                  if (color == Colors.green) {
                    color = Colors.yellow;
                  } else {
                    color = Colors.green;
                  }
                });
              },
              child: const Text('Switch Color'),
            ),
            Container(
              height: 160,
              width: 160,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.all(10),
            )
          ],
        ),
      ),
    );
  }
}