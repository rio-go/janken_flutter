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
  String myHand = goo;
  String computerHand = goo;
  String result = '引き分け';

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
    } else if (myHand == goo && computerHand == choki ||
        myHand == choki && computerHand == paa ||
        myHand == paa && computerHand == choki) {
      result = 'あなたの勝ち';
    } else {
      result = 'あなたの負け';
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
            Text(
              result,
              style: const TextStyle(
                fontSize: 32,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              computerHand,
              style: const TextStyle(
                fontSize: 32,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              myHand,
              style: const TextStyle(
                fontSize: 32,
              ),
            ),
            const SizedBox(height: 16),
            Row(
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
          ],
        ),
      ),
    );
  }
}
