import 'dart:core';
import 'dart:convert';

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

class Qrcode{
  String url = "";
  String imgUrlRoot = "./lib/assets/images/";
  String imgUrl = "";
  Qrcode({required this.url, required this.imgUrl}){
    imgUrl = "$imgUrlRoot$imgUrl.png";
  }
  String getImgUrl(){
    return imgUrl;
  }
  String getUrl(){
    return url;
  }
  // convert qrcode obj to map
  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'imgUrl': imgUrl,
    };
  }

  // convert map to qrcode obj
  static Qrcode fromMap(Map<String, dynamic> map) {
    return Qrcode(
      url: map['url'],
      imgUrl: map['imgUrl'],
    );
  }
}