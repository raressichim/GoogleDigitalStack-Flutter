import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const GuessTheNumber());
}

class GuessTheNumber extends StatelessWidget {
  const GuessTheNumber({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

const String firstText = "I'm thinking of a number between 1 and 100.";
const String cardText = "Try a number";

class _HomePageState extends State<HomePage> {
  String secondText = "It's your turn to guess my number!";
  bool showReset = false;
  int numberToGuess = 0;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    generateRandomNbr();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Guess the number"),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Text(firstText,
                  textAlign: TextAlign.center, style: TextStyle(fontSize: 30)),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  secondText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              Card(
                elevation: 5.0,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      const Text(cardText),
                      TextField(
                        keyboardType: TextInputType.number,
                        controller: controller,
                        decoration: const InputDecoration(),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (showReset) {
                            resetGame();
                          } else {
                            String userText = controller.text;
                            if (numberToGuess == int.parse(userText)) {
                              controller.text = "";
                              setState(() {
                                showReset = true;
                                secondText =
                                    "You've guessed right. Click on reset to play again!";
                              });
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text("You guessed right"),
                                      content: Text("It was $numberToGuess",
                                          style: const TextStyle(fontSize: 15.0)),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Ok')),
                                        TextButton(
                                            onPressed: () {
                                              resetGame();
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Reset'))
                                      ],
                                    );
                                  });
                            } else if (numberToGuess > int.parse(userText)) {
                              setState(() {
                                secondText =
                                    "You said ${controller.text}. Try a higher number";
                                controller.text = "";
                              });
                            } else {
                              setState(() {
                                secondText =
                                    "You said ${controller.text}. Try a lower number";
                                controller.text = "";
                              });
                            }
                          }
                        },
                        child: Text(showReset ? "Reset" : "Guess"),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void resetGame() {
    setState(() {
      showReset = false;
      secondText = "It's your turn to guess my number!";
      controller.text = "";
      generateRandomNbr();
    });
  }

  void generateRandomNbr() {
    setState(() {
      numberToGuess = Random().nextInt(100) + 1;
      print("The number to be guessed is $numberToGuess");
    });
  }
}
