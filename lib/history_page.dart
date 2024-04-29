import 'package:flutter/material.dart';
import 'package:iste252_project_3/qrcode.dart';

import 'package:localstorage/localstorage.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key, required this.title});
  final String title;

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<Qrcode> historyObj =
      qrcodesFromJson(localStorage.getItem('history').toString());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height, // 100% of screen height
          color: Theme.of(context).primaryColor,
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: MediaQuery.of(context).size.height *
                0.7, // 70% of screen height
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorDark,
              borderRadius: BorderRadius.circular(25),
            ),
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.topCenter,
              child: ListView(
                children: historyObj.map((qrcode) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            print('Tapped on ${qrcode.url}');
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(qrcode.url),
                                  content: Image(
                                      image: NetworkImage(
                                          "https://api.qrserver.com/v1/create-qr-code/?size=250x250&data=${qrcode.url}"),
                                      height: 250,
                                      width: 250),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('Close'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColorDark,
                              border: Border(
                                bottom: BorderSide(
                                    color: Theme.of(context).primaryColorLight,
                                    width: 0.5),
                              ),
                            ),
                            height: 45,
                            child: Column(
                              children: [
                                Align(
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Image(
                                            image: NetworkImage(
                                                "https://media.sciencephoto.com/image/c0280133/800wm/C0280133-QR_Code_Example.jpg"),
                                            height: 40,
                                            width: 40),
                                        Flexible(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              qrcode.url,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                        Icon(Icons.arrow_right,
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.color,
                                            size: 30),
                                      ],
                                    )),
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
