// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, unnecessary_this, unused_field, avoid_print

import 'dart:math';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, int> options = {"rock": 0, "paper": 1, "scissors": 2};
  String _message = "Choose an option!";
  String _imagePath = "assets/default.png";
  var imageMachine = AssetImage("assets/default.png");

  int consecutiveWins = 0;
  int consecutiveLosses = 0;
  int consecutiveDraws = 0;

  void _play(String choice) {
    int indexRandom = Random().nextInt(options.length);
    String randomChoice = options.keys.elementAt(indexRandom);
    this._imagePath = "assets/$randomChoice.jpg";
    this.imageMachine = AssetImage(_imagePath);
    print("Escolha do App: $randomChoice");
    print("Caminho da Escolha: $_imagePath");

    int machineIndex = options[randomChoice]!;
    int playerIndex = options[choice] ?? -1;

    int loseCondition = (playerIndex + 1) % options.length;
    int winCondition = playerIndex - ((machineIndex + 1) % options.length);
    if (indexRandom == loseCondition) {
      setState(() {
        consecutiveWins = 0;
        consecutiveDraws = 0;
        consecutiveLosses++;
        this._message = "You lost .·´¯`(>▂<)´¯`·. ";
        if(consecutiveLosses > 1){
          this._message = "You lost .·´¯`(>▂<)´¯`·. $consecutiveLosses" "x";
        }
      });
      return;
    }
    if(winCondition == 0){
      setState(() {
        consecutiveWins++;
        consecutiveDraws = 0;
        consecutiveLosses = 0;
        this._message = "You won ヾ(•ω•`)o";
        if(consecutiveWins > 1){
          this._message = "You won ヾ(•ω•`)o $consecutiveWins" "x";
        }
      });
      return;
    }
    setState(() {
        consecutiveWins = 0;
        consecutiveDraws++;
        consecutiveLosses = 0;
        this._message = "You drew 〜(￣▽￣〜)";
        if(consecutiveDraws > 1){
          this._message = "You drew 〜(￣▽￣〜) $consecutiveDraws" "x";
        }
    });
    return;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                "App's Choice",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  backgroundColor: Colors.greenAccent
                ),
              ),
            ),
            Image(image: imageMachine, height: 250),
            Padding(
              padding: EdgeInsets.all(30),
              child: Text(
                _message,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  backgroundColor: Colors.greenAccent
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () => _play("rock"),
                  child: Image.asset("assets/rock.jpg", width: 100,),
                ),
                GestureDetector(
                  onTap: () => _play("paper"),
                  child: Image.asset("assets/paper.jpg", width: 100),
                ),
                GestureDetector(
                  onTap: () => _play("scissors"),
                  child: Image.asset("assets/scissors.jpg", width: 100)
                )
              ],
            )
          ],
        )
      )

    );
  }
}