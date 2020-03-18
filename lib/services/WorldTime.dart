import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';

class WorldTime {
  String location;
  String time;
  String flag;
  String url;
  bool isDayTime;

  //make constructor
  WorldTime({ this.url, this.flag, this.location});

  //"Future<void>" mean, if call this function do not run any codes until this method return value
  // e kiyanne, me method eka call karala eke data tika okkoma enakan wena class ekaka tiyena mothord ekakwat run karanna epa
  Future<void> getTime(context) async{
    try {
      ProgressDialog pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
      pr.style(
        message: 'Loading Data...',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        progressWidget: Center(
          child: SpinKitFadingCircle(
            color: Colors.blue[900],
            size: 40.0,
          ),
        ),
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
      );
      pr.show();
      print('Loading Data.....!');
      Response response = await get(
          'http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);
      //print(data);

      String datetime = data['datetime'];
      String offset_h = data['utc_offset'].substring(1, 3);
      String offset_m = data['utc_offset'].substring(4);

      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset_h), minutes: int.parse(offset_m)));

      // convert long date string to small string
      time = DateFormat.jm().format(now);
      isDayTime = now.hour > 6 && now.hour < 18 ? true : false; // if 6 < time < 18 true else false
      pr.hide();
    }catch(e){
      print("WorldTime error : $e");
      time = 'cound not get data';
    }
  }
}