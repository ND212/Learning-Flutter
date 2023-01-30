import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.white),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.zero,
                      height: height * 0.18,
                      child: Column(children: [
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        color: Colors.orange,
                                      ),
                                      flex: 2,
                                    ),
                                    Expanded(
                                      child: Container(
                                        color: Colors.blue,
                                      ),
                                      flex: 1,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                  flex: 2,
                                  child: Container(
                                    color: Colors.blue.withOpacity(0.65),
                                  )),
                            ],
                          ),
                          flex: 3,
                        ),
                        Expanded(
                          child: Row(children: [
                            Expanded(
                                flex: 1,
                                child: Container(
                                  color: Colors.pink.withOpacity(0.8),
                                )),
                            Expanded(
                                flex: 1,
                                child: Container(color: Colors.green.shade200)),
                            Expanded(
                                flex: 1,
                                child: Container(
                                  color: Colors.yellow,
                                )),
                          ]),
                          flex: 1,
                        ),
                      ]),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.black,
                      ),
                      flex: 2,
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.yellow,
                      ),
                      flex: 2,
                    ),
                    Expanded(
                      child: Container(),
                      flex: 2,
                    ),
                  ],
                ),
                flex: 1,
              ),
              Expanded(
                child: Container(
                  color: Colors.pink.withOpacity(0.8),
                ),
                flex: 2,
              ),
              SizedBox(
                width: 0.03 * width,
              ),
              Expanded(
                child: Container(
                  color: Colors.pink.withOpacity(0.8),
                ),
                flex: 1,
              )
            ],
          ),
          Positioned(
            top: height * 0.51,
            left: 1 / 8 * width,
            child: Container(
              width: width * 0.4,
              height: width * 0.4,
              color: Colors.black26.withOpacity(0.4),
            ),
          )
        ],
      ),
    );
  }
}
