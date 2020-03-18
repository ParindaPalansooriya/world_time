import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map dataFromLoging = {};

  @override
  Widget build(BuildContext context) {
    // check dataFromLoging is empty.
    dataFromLoging = dataFromLoging.isNotEmpty ? dataFromLoging : ModalRoute.of(context).settings.arguments;
    print(dataFromLoging);

    // check background image
    String backImage = dataFromLoging['isDayTime'] ? 'day.jpg' : 'night.jpg';
    // check background color ( tool bar color)
    Color backColor = dataFromLoging['isDayTime'] ? Colors.deepOrange[900] : Colors.blue[900];
    // check font color
    Color fontColor = dataFromLoging['isDayTime'] ? Colors.black : Colors.white;

    return Scaffold(//"SafeArea" this will show the all in safe area
      backgroundColor: backColor,
      body: SafeArea(
          child: Container(
            decoration: BoxDecoration( // make a box to add background
              image: DecorationImage(
                image: AssetImage('assest/$backImage'),
                fit: BoxFit.cover,
              )
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 120.0, 0, 0),
              child: Column(
                children: <Widget>[
                  FlatButton.icon(
                      onPressed: () async{
                        // open location and waiting for return to page with using "async and await"
                        dynamic resal = await Navigator.pushNamed(context, "/location");
                        setState(() {
                          dataFromLoging = {
                            'location' : resal['location'],
                            'flag' : resal['flag'],
                            'time' : resal['time'],
                            'isDayTime' : resal['isDayTime'],
                            'url' : resal['url'],
                          };
                        });
                      },
                      icon: Icon(
                        Icons.edit_location,
                        color: fontColor),
                      label: Text('Edit Location'),
                      textColor: fontColor),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        dataFromLoging['location'],
                        style: TextStyle(
                          fontSize: 28.0,
                          letterSpacing: 2.0,
                          color: fontColor
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    dataFromLoging['time'],
                    style: TextStyle(
                      fontSize: 66.0,
                    ),
                  )
                ],
      ),
            ),
          )),
    );
  }
}
