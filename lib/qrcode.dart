import 'dart:core';

class Qrcode{
  int id = 0;
  String url = "";
  String imgUrlRoot = "../assets/images/";
  String imgUrl = "";

  Qrcode({required this.id, required this.url, required this.imgUrl}){
    imgUrl = "$imgUrlRoot$imgUrl.png";
  }
  String getImgUrl(){
    return imgUrl;
  }
  int getId(){
    return id;
  }
  String getUrl(){
    return url;
  }
}