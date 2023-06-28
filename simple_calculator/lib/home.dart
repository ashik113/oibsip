import 'package:flutter/material.dart';

class HomeApp extends StatefulWidget {
  const HomeApp({Key? key}) : super(key: key);

  @override
  State<HomeApp> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculator"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(25.0),
              child: Text(
                text,
                style: const TextStyle(
                    fontSize: 57.0, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(child: customOutlinedButton("7")),
              Expanded(child: customOutlinedButton("8")),
              Expanded(child: customOutlinedButton("9")),
              Expanded(child: customOutlinedButton("/")),
            ],
          ),
          Row(
            children: [
              Expanded(child: customOutlinedButton("4")),
              Expanded(child: customOutlinedButton("5")),
              Expanded(child: customOutlinedButton("6")),
              Expanded(child: customOutlinedButton("*")),
            ],
          ),
          Row(
            children: [
              Expanded(child: customOutlinedButton("1")),
              Expanded(child: customOutlinedButton("2")),
              Expanded(child: customOutlinedButton("3")),
              Expanded(child: customOutlinedButton("-")),
            ],
          ),
          Row(
            children: [
              Expanded(child: customOutlinedButton("C")),
              Expanded(child: customOutlinedButton("0")),
              Expanded(child: customOutlinedButton("+")),
              Expanded(child: customOutlinedButton("=")),
            ],
          ),
        ],
      ),
    );
  }

  OutlinedButton customOutlinedButton(String val) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
        padding: const EdgeInsets.all(25.0),
        backgroundColor: Colors.deepOrange,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      ),
      onPressed: () => btnClicked(val),
      child: Text(
        val,
        style: const TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  String res = "";
  String text = "";
  late int first, second;
  String opp = "";
  void btnClicked(String btnText) {
    if (btnText == "C") {
      res = "";
      first = 0;
      second = 0;
    } else if (btnText == "+" ||
        btnText == "-" ||
        btnText == "*" ||
        btnText == "/") {
      first = int.parse(text);
      res = "";
      opp = btnText;
    } else if (btnText == "=") {
      second = int.parse(text);
      if (opp == "+") {
        res = (first + second).toString();
      }
      if (opp == "-") {
        res = (first - second).toString();
      }
      if (opp == "*") {
        res = (first * second).toString();
      }
      if (opp == "/") {
        res = (first / second).toString();
      }
    } else {
      res = text + btnText;
    }
    setState(() {
      text = res;
    });
  }
}
