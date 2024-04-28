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
    Qrcode(id: 0, url: 'youtube.com', imgUrl: '0'),
    Qrcode(id: 19, url: 'https://www.bitchasshoe.com/users/list/urmum.jpeg', imgUrl: '1'),
    Qrcode(id: 1, url: 'google.com', imgUrl: '1'),
    Qrcode(id: 2, url: 'facebook.com', imgUrl: '2'),
    Qrcode(id: 3, url: 'twitter.com', imgUrl: '3'),
    Qrcode(id: 4, url: 'instagram.com', imgUrl: '4'),
    Qrcode(id: 5, url: 'linkedin.com', imgUrl: '0'),
    Qrcode(id: 6, url: 'pinterest.com', imgUrl: '1'),
    Qrcode(id: 7, url: 'tumblr.com', imgUrl: '2'),
    Qrcode(id: 8, url: 'reddit.com', imgUrl: '3'),
    Qrcode(id: 9, url: 'snapchat.com', imgUrl: '4'),
    Qrcode(id: 10, url: 'bitchasshoe.com', imgUrl: '0'),
    Qrcode(id: 11, url: 'bitchasshoe.com', imgUrl: '1'),
    Qrcode(id: 12, url: 'bitchasshoe.com', imgUrl: '2'),
    Qrcode(id: 13, url: 'bitchasshoe.com', imgUrl: '3'),
    Qrcode(id: 14, url: 'bitchasshoe.com', imgUrl: '4'),
    Qrcode(id: 15, url: 'bitchasshoe.com', imgUrl: '0'),
    Qrcode(id: 16, url: 'bitchasshoe.com', imgUrl: '1'),
    Qrcode(id: 17, url: 'bitchasshoe.com', imgUrl: '2'),
    Qrcode(id: 18, url: 'bitchasshoe.com', imgUrl: '3'),

  ];

    
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height, // 100% of screen height
          color: Theme.of(context).primaryColor,
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.7, // 70% of screen height
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorDark,
              borderRadius: BorderRadius.circular(25),
            ),
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.topCenter,
              child: ListView(
                children: qrcodes.map((qrcode) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            print('Tapped on ${qrcode.url}');
                          },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColorDark,
                            border: Border(
                              bottom: BorderSide(color: Theme.of(context).primaryColorLight, width: 0.5
                              ),
                            ),
                          ),
                          height: 45,
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Image(
                                        image: NetworkImage("https://media.sciencephoto.com/image/c0280133/800wm/C0280133-QR_Code_Example.jpg"), 
                                        height: 40,
                                        width: 40
                                      ),
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            qrcode.url,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                      Icon(Icons.arrow_right, color: Theme.of(context).textTheme.bodyLarge?.color, size: 30),
                                    ],
                                  )
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}