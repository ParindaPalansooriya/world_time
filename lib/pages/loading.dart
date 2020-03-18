import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
/*import 'package:http/http.dart';
import 'dart:convert';*/
import 'package:worldtime/services/WorldTime.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  String timeNow = 'Loading....!';

  /*void getData() async{

    // "await" means, wait and compile this method first and after getting data go to the next line
    await Future.delayed(Duration(seconds: 2),(){
      print('after 2 sec');
    });

    // "Future.delayed" means, make a 2 sec delay and run this method
    Future.delayed(Duration(seconds: 2),(){
      print('after 2 sec');
    });

    print('after 2 sec');
  }*/
/*
  void getData() async{
    print('Getting data....');
    Response response = await get('https://jsonplaceholder.typicode.com/todos/1');
    print(response.body);
    Map data = jsonDecode(response.body);
    print(data['title']);
  }*/
/*
  void getTime() async{
    print('Loading Data.....!');
    Response response = await get('http://worldtimeapi.org/api/timezone/Asia/Colombo');
    Map data = jsonDecode(response.body);
    print(data);

    String datetime = data['datetime'];
    String offset_h = data['utc_offset'].substring(1,3);
    String offset_m = data['utc_offset'].substring(4);

    DateTime now = DateTime.parse(datetime);
    now = now.add(Duration(hours: int.parse(offset_h), minutes: int.parse(offset_m)));
    print(now);
  }*/

  void loadWordTime() async{
    WorldTime time = WorldTime(location: 'colombo', flag: 'colombo.png', url: 'Asia/Colombo');
    await time.getTime();
    //print('current time : '+time.time);
    // update the UI with new values
    /*setState(() {
      timeNow = time.time;
    });*/
    // open home page with sending data to home page
    Navigator.pushReplacementNamed(context, '/home',arguments: {
      'location' : time.location,
      'flag' : time.flag,
      'time' : time.time,
      'isDayTime' : time.isDayTime,
    });
  }

  // run in initial, before run the build method
  @override
  void initState() {
    super.initState();
    //getTime();
    loadWordTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitThreeBounce(
          color: Colors.blue[900],
          size: 20.0,
        ),
      ),
    );
  }
}
