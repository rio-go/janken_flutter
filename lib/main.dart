import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const JankenPage(),
    );
  }
}

class JankenPage extends StatefulWidget {
  const JankenPage({Key? key}) : super(key: key);

  void selectHand(String selectedHand) {
    var myHand = selectedHand;
    print(myHand);
  }

  @override
  State<JankenPage> createState() => _JankenPageState();
}

const String goo = '✊';
const String choki = '✌️';
const String paa = '✋';

class _JankenPageState extends State<JankenPage> {
  String myHand = '';
  String computerHand = '';
  String result = '';

  int _computer = 0;
  int _me = 0;
  int _total = 1;
  bool _visible1 = false;
  bool _visible2 = true;

  void selectHand(String selectedHand) {
    myHand = selectedHand;
    print(myHand);
    generateComputerHand();
    judge();
    setState(() {});
  }

  void generateComputerHand() {
    final randomNumber = Random().nextInt(3);
    computerHand = randomNumberToHand(randomNumber);
  }

  void judge() {
    if (myHand == computerHand) {
      result = '引き分け';
      setState(() {
        _total++;
      });
    } else if (myHand == goo && computerHand == choki ||
        myHand == choki && computerHand == paa ||
        myHand == paa && computerHand == choki) {
      setState(() {
        _me++;
        _total++;
      });
      result = 'あなたの勝ち';
    } else {
      setState(() {
        _computer++;
        _total++;
      });
      result = 'あなたの負け';
    }
    if (_total == 5) {
      _visible1 = true;
      _visible2 = false;
    }
  }

  String randomNumberToHand(int randomNumber) {
    switch (randomNumber) {
      case 0:
        return goo;
      case 1:
        return choki;
      case 2:
        return paa;
      default:
        return goo;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('じゃんけん'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: _visible2,
              child: Text(
                '$_total 試合目',
                style: const TextStyle(
                  fontSize: 40,
                ),
              ),
            ),
            const Text(
              '相手 VS あなた',
              style: TextStyle(
                fontSize: 50,
              ),
            ),
            const SizedBox(height: 12),
            Visibility(
                visible: _visible1,
                child: Column(
                  children: [
                    Text(
                      '$_computer 対 $_me',
                      style: const TextStyle(
                        fontSize: 60,
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black54,
                      ),
                      child: const Text(
                        'リセット',
                        style: TextStyle(
                          fontSize: 50,
                        ),
                      ),
                      onPressed: () {
                        Reset();
                      },
                    ),
                  ],
                )),
            const SizedBox(height: 12),
            Visibility(
              visible: _visible2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    computerHand,
                    style: const TextStyle(
                      fontSize: 60,
                    ),
                  ),
                  Text(
                    result,
                    style: const TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  Text(
                    myHand,
                    style: const TextStyle(
                      fontSize: 60,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Visibility(
              visible: _visible2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      selectHand(
                        goo,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black54,
                    ),
                    child: const Text(
                      goo,
                      style: TextStyle(
                        fontSize: 50,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      selectHand(choki);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black54,
                    ),
                    child: const Text(
                      choki,
                      style: TextStyle(
                        fontSize: 50,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      selectHand(paa);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black54,
                    ),
                    child: const Text(
                      paa,
                      style: TextStyle(
                        fontSize: 50,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void Reset() {
    _computer = 0;
    _me = 0;
    _total = 1;
    _visible1 = false;
    _visible2 = true;
    setState(() {});
  }
}
