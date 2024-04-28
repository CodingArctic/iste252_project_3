import 'package:flutter/material.dart';
import 'package:iste252_project_3/qrcode.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key, required this.title});
  final String title;

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<Qrcode> qrcodes = [
    Qrcode(id: 0, url: 'youtube.com', imgUrl: 'youtube'),
    Qrcode(id: 1, url: 'google.com', imgUrl: 'google'),
    Qrcode(id: 2, url: 'facebook.com', imgUrl: 'facebook'),
    Qrcode(id: 3, url: 'twitter.com', imgUrl: 'twitter'),

  ];

    
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
      child: Expanded(
        child: SizedBox(
          height: 100,  // Define a height for the Container
          child: ListView(
            children: qrcodes.map((qrcode) {
              return Column(
                children: [
                  Text('ID: ${qrcode.id}'),
                  Text('URL: ${qrcode.url}'),
                  Text('Image URL: ${qrcode.imgUrl}'),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    ),
    );
  }
}