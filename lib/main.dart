import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'Horse Head Slot Game'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool youWin = false;
  int winPrize = 100;
  int totalCash = 1000;
  int rollCounter = 0;
  List<int> counterA = [0, 0, 0];
  List<int> counterB = [0, 0, 0];
  List<int> counterC = [0, 0, 0];

  void rollSlot() {
    setState(() {
      totalCash--;
      youWin = false;
      rollCounter = getRandomRollerNumber();
      List<int> randomArray = getRandomArray();
      moveNumbers(randomArray);
    });
  }

  List<int> getRandomArray() {
    int a = getRandomNumber();
    int b = getRandomNumber();
    int c = getRandomNumber();

    return [a, b, c];
  }

  void moveNumbers(randomArray) {
    Future.delayed(const Duration(milliseconds: 50), () {
      setState(() {
        counterA = counterB;
        counterB = counterC;
        counterC = randomArray;

        if (rollCounter > 0) {
          rollCounter--;
          List<int> randomArray = getRandomArray();
          moveNumbers(randomArray);
        } else {
          if (counterB[0] == counterB[1] && counterB[1] == counterB[2]) {
            totalCash += winPrize;
            youWin = true;
          }
        }
      });
    });
  }

  int getRandomNumber() {
    Random random = new Random();
    return random.nextInt(10);
  }

  int getRandomRollerNumber() {
    Random random = new Random();
    return random.nextInt(20) + 10;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            widget.title,
            style: TextStyle(color: Colors.white.withOpacity(1), fontSize: 30),
          ),
        ),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'girl.png'),
              fit: BoxFit.contain,
              alignment: FractionalOffset.bottomLeft,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Visibility(
                visible: youWin,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'YOU WIN!!',
                      style: TextStyle(color: Colors.green.withOpacity(1), fontSize: 60),
                    ),
                    Text(
                      '$winPrize Cash',
                      style: TextStyle(color: Colors.black.withOpacity(1), fontSize: 40),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50),
              Text(
                'Total Cash: $totalCash',
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(height: 50),
              Text(
                '$counterA',
                style: Theme.of(context).textTheme.headline4,
              ),
              Text(
                '$counterB',
                style: TextStyle(color: Colors.black.withOpacity(1), fontSize: 40),
              ),
              Text(
                '$counterC',
                style: Theme.of(context).textTheme.headline4,
              ),
              SizedBox(height: 50),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  onPrimary: Colors.amberAccent,
                  primary: Colors.red[300],
                  minimumSize: Size(120, 50),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
                onPressed: (rollCounter == 0) ? rollSlot : null,
                child: Text(
                  'Roll',
                  style: Theme.of(context).textTheme.headline5,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
