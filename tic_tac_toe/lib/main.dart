import 'package:flutter/material.dart';

void main() {
  runApp(const TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  const TicTacToeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Tic Tac Toe',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<List<String>> gameMatrix =
      List<List<String>>.generate(3, (_) => List<String>.filled(3, ''));

  bool isPlayerOneTurn = false;
  bool gameOver = false;
  int gameMoves = 0;

  void handleTap(int row, int col) {
    if (!gameOver && gameMatrix[row][col] == '') {
      setState(() {
        gameMatrix[row][col] = isPlayerOneTurn ? 'X' : 'O';
        isPlayerOneTurn = !isPlayerOneTurn;
        gameMoves++;
        checkStatus();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background_galaxy.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Tic Tac Toe',
                style: TextStyle(fontSize: 35, color: Colors.white),
              ),
              SizedBox(
                height: 400,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemCount: 9,
                  itemBuilder: (BuildContext context, int index) {
                    final int row = index ~/ 3;
                    final int col = index % 3;
                    return GestureDetector(
                      onTap: () => handleTap(row, col),
                      child: Opacity(
                        opacity: 0.8,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(),
                            color: Colors.deepPurpleAccent,
                          ),
                          child: Center(
                            child: Text(
                              gameMatrix[row][col],
                              style: const TextStyle(
                                fontSize: 40,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurpleAccent,
                ),
                onPressed: resetGame,
                child: const Text(
                  'Reset Game',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showWinDialog(String winner) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Game Over'),
          content: Text(
            'Player $winner won the game!',
            style: const TextStyle(fontSize: 18),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                resetGame();
              },
              child: const Text('Play Again', style: TextStyle(fontSize: 16)),
            )
          ],
        );
      },
    );
  }

  void showDrawDialog() {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Game Over'),
          content: const Text(
            "It's a draw!",
            style: TextStyle(fontSize: 18),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                resetGame();
              },
              child: const Text('Play again', style: TextStyle(fontSize: 16)),
            ),
          ],
        );
      },
    );
  }

  void checkStatus() {
    for (int i = 0; i < 3; i++) {
      if (gameMatrix[i][0] != '' &&
          gameMatrix[i][0] == gameMatrix[i][1] &&
          gameMatrix[i][0] == gameMatrix[i][2]) {
        gameOver = true;
        showWinDialog(gameMatrix[i][0]);
        return;
      }
    }

    for (int j = 0; j < 3; j++) {
      if (gameMatrix[0][j] != '' &&
          gameMatrix[0][j] == gameMatrix[1][j] &&
          gameMatrix[0][j] == gameMatrix[2][j]) {
        gameOver = true;
        showWinDialog(gameMatrix[0][j]);
        return;
      }
    }

    if (gameMatrix[0][0] != '' &&
            gameMatrix[0][0] == gameMatrix[1][1] &&
            gameMatrix[0][0] == gameMatrix[2][2] ||
        gameMatrix[0][2] != '' &&
            gameMatrix[0][2] == gameMatrix[1][1] &&
            gameMatrix[0][2] == gameMatrix[2][0]) {
      gameOver = true;
      showWinDialog(gameMatrix[1][1]);
      return;
    }

    if (gameMoves == 9) {
      showDrawDialog();
    }
  }

  void resetGame() {
    setState(() {
      gameMatrix =
          List<List<String>>.generate(3, (_) => List<String>.filled(3, ''));
    });
    gameOver = false;
    gameMoves = 0;
    isPlayerOneTurn = true;
  }
}
