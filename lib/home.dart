import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          LottieBuilder.asset("assets/Animation - 1717924376066.json"),
          ElevatedButton(
              onPressed: () {
                double sum = normalFunc();
                debugPrint("total is :$sum");
              },
              child: Text("normal on press")),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () async {
                double sum = await asyncFunc();
                debugPrint("total is :$sum");
              },
              child: Text("async on press")),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () async {
                final ReceivePort recieverPort = ReceivePort();
                //this async is for creating an isolate
                await Isolate.spawn(isolateFunction, recieverPort.sendPort);
                recieverPort.listen((total) {
                  debugPrint("total is $total");
                });
              },
              child: Text("isolates on pressed"))
        ],
      )),
    );
  }
}

double normalFunc() {
  double h = 0;
  for (var i = 0; i < 1000000000; i++) {
    h += i;
  }
  return h;
}

Future<double> asyncFunc() async {
  double h = 0;
  for (var i = 0; i < 1000000000; i++) {
    h += i;
  }
  return h;
}

//isolate function
// always write isolate functions outside the class

isolateFunction(SendPort sendport) {
  double h = 0;
  for (var i = 0; i < 1000000000; i++) {
    h += i;
  }
  sendport.send(h);
}
