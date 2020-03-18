import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map dataFromLoging = {};

  @override
  Widget build(BuildContext context) {

    dataFromLoging = ModalRoute.of(context).settings.arguments;
    print(dataFromLoging);

    return Scaffold(//"SafeArea" this will show the all in safe area
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120.0, 0, 0),
            child: Column(
              children: <Widget>[
                FlatButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, "/location");
                    },
                    icon: Icon(Icons.edit_location),
                    label: Text('Edit Location')),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      dataFromLoging['location'],
                      style: TextStyle(
                        fontSize: 28.0,
                        letterSpacing: 2.0,
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
          )),
    );
  }
}
