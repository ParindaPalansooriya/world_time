import 'package:http/http.dart';
import 'dart:convert';

class WorldTime {
  String location;
  String time;
  String flag;
  String url;

  //make constructor
  WorldTime({ this.url, this.flag, this.location});

  //"Future<void>" mean, if call this function do not run any codes until this method return value
  // e kiyanne, me method eka call karala eke data tika okkoma enakan wena class ekaka tiyena mothord ekakwat run karanna epa
  Future<void> getTime() async{
    try {
      print('Loading Data.....!');
      Response response = await get(
          'http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);
      //print(data);

      String datetime = data['datetime'];
      String offset_h = data['utc_offset'].substring(1, 3);
      String offset_m = data['utc_offset'].substring(4);

      DateTime now = DateTime.parse(datetime);
      now = now.add(
          Duration(hours: int.parse(offset_h), minutes: int.parse(offset_m)));

      time = now.toString();
    }catch(e){
      print("WorldTime error : $e");
      time = 'cound not get data';
    }
  }
}