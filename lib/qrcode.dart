import 'dart:core';

class Qrcode{
  int id = 0;
  String url = "";
  String imgUrlRoot = "../assets/images/";
  String imgUrl = "";

  Qrcode({required this.id, required this.url}){
    imgUrl = "$imgUrlRoot$url.png";
  }
  String getImgUrl(){
    return imgUrl;
  }
  int getId(){
    return id;
  }
}