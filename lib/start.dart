import 'package:flutter/material.dart';

class Start extends StatefulWidget {
  const Start({Key? key}) : super(key: key);

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  bool user_type = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Startup Page")),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              user_type = true;
                            });
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(
                                Icons.person,
                                size: 50,
                                color: user_type ? Colors.white : Colors.blue,
                              ),
                              SizedBox(width: 8.0),
                              Text(
                                'Owner',
                                style: TextStyle(
                                    color:
                                        user_type ? Colors.white : Colors.blue),
                              ),
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            padding: EdgeInsets.all(30.0),
                            fixedSize: Size(150, 150),
                            primary: user_type ? Colors.blue : Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              user_type = false;
                            });
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(
                                Icons.person,
                                color: user_type ? Colors.blue : Colors.white,
                                size: 50,
                              ),
                              SizedBox(width: 8.0),
                              Text(
                                'Crew Member',
                                style: TextStyle(
                                    color:
                                        user_type ? Colors.blue : Colors.white),
                              ),
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            padding: EdgeInsets.all(30.0),
                            fixedSize: Size(150, 150),
                            primary: user_type ? Colors.white : Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
