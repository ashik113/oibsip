import 'dart:async';

import 'package:flutter/material.dart';

class MyStopWWatchHomePage extends StatefulWidget {
  const MyStopWWatchHomePage({Key? key}) : super(key: key);

  @override
  State<MyStopWWatchHomePage> createState() => _MyStopWWatchHomePageState();
}

class _MyStopWWatchHomePageState extends State<MyStopWWatchHomePage> {
  String _result = '00:00:00';
  bool isRunning = false;
  Stopwatch _stopWatch = Stopwatch();
  late Timer _timer;

  void _start() {
    _timer = Timer.periodic(Duration(milliseconds: 1), (timer) {
      setState(() {
        isRunning = true;
        _result =
            "${_stopWatch.elapsed.inMinutes.toString().padLeft(2, '0')}:${(_stopWatch.elapsed.inSeconds % 60).toString().padLeft(2, '0')}:${(_stopWatch.elapsed.inMilliseconds % 60).toString().padLeft(2, '0')}";
      });
    });
    _stopWatch.start();
  }

  void _stop() {
    isRunning = false;
    _timer.cancel();
    _stopWatch.stop();
  }

  void _reset() {
    isRunning = false;
    _stop();
    _stopWatch.reset();

    setState(() {
      _result = '00:00:00';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 250,
          height: 250,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Center(
                child: Text(
                  _result,
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 100,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                onPressed: () {
                  _stop();
                },
                child: Text('STOP')),
            ElevatedButton(
                onPressed: () {
                  _start();
                },
                child: Text('START')),
            ElevatedButton(
                onPressed: () {
                  _reset();
                },
                child: Text('RESET')),
          ],
        ),
      ],
    );
  }
}

class CircularProgressIndicators extends StatelessWidget {
  const CircularProgressIndicators({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      value: null,
      valueColor: AlwaysStoppedAnimation(Color(0xFF778EAC)),
      strokeWidth: 12,
      backgroundColor: Colors.white,
      semanticsLabel: "M",
    );
  }
}
