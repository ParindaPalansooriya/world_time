import 'package:flutter/material.dart';
import 'package:worldtime/services/WorldTime.dart';

class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  List<WorldTime> list = [
    WorldTime(url: 'Europe/London', location: 'London', flag: 'uk.svg'),
    WorldTime(url: 'Asia/Colombo' , location: 'Colombo', flag: 'sl.png'),
    WorldTime(url: 'Africa/Cairo', location: 'Cairo', flag: 'af.svg'),
    WorldTime(url: 'America/New_York', location: 'New_York', flag: 'us.svg'),
  ];

  void updateTime(index) async {
    WorldTime newTime = list[index];
    await newTime.getTime(context);
    // open home with data passing
    Navigator.pop(context,{
      'location' : newTime.location,
      'flag' : newTime.flag,
      'time' : newTime.time,
      'isDayTime' : newTime.isDayTime,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.blue[500],
        title: Text('Select Location'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index){
          return Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
              child: ListTile(
                onTap: () {
                  updateTime(index);
                },
                title: Text(list[index].location),
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assest/${list[index].flag}'),
                ),
              ),
            ),
          );
        }
      )
    );
  }
}
