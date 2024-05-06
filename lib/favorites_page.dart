import 'package:flutter/material.dart';
import 'package:iste252_project_3/qrcode.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:localstorage/localstorage.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

_launchURL(String urlToLaunch) async {
  final Uri url = Uri.parse(urlToLaunch.toString());
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<Qrcode> historyObj = qrcodesFromJson(localStorage.getItem('history').toString());
  bool hasFavorite = false;


  @override
  void initState() {
    super.initState();
    hasFavorite = historyObj.any((qrcode) => qrcode.getIsFavorite());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Codes'),
      ),
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
              child: hasFavorite
              ? ListView(
                children: historyObj.map((qrcode) {
                  if (qrcode.getIsFavorite()) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
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
                                        child: const Text('Open Link'),
                                        onPressed: () {
                                          _launchURL(qrcode.url);
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      if (qrcode.getIsFavorite() == false)
                                      TextButton(
                                        child: const Text('Save QR'),
                                        onPressed: () {
                                          qrcode.setIsFavorite(true);
                                          localStorage.setItem('history',
                                              qrcodesToJson(historyObj));
                                          Navigator.of(context).pop();
                                        },
                                      ) else
                                      TextButton(
                                        child: const Text('Remove Save'),
                                        onPressed: () {
                                          qrcode.setIsFavorite(false);
                                          localStorage.setItem('history',
                                              qrcodesToJson(historyObj));
                                          Navigator.of(context).pop();
                                        }
                                      ),
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
                                      color:
                                          Theme.of(context).primaryColorLight,
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
                                          Flexible(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
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
                  } else {
                    return Container();
                  }
                }).toList(),
              )
              : const Text("No QR Codes saved - add one from the History page!"),
            ),
          ),
        ),
      ),
    );
  }
}
