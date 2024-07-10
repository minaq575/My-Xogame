import 'package:flutter/material.dart';
import 'package:my_xogame/screens/gamehistory.dart';
import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';

class HomeGame extends StatefulWidget {
  final String playerName; // Declare playerName parameter

  const HomeGame({Key? key, required this.playerName}) : super(key: key);

  @override
  State<HomeGame> createState() => _HomeGameState();
}

class _HomeGameState extends State<HomeGame> {
  bool oTurn = true;
  List<String> displayXO = [];
  int gridSize = 3;
  int filledBoxes = 0;
  String resultDeclaration = '';
  bool winnerFound = false;
  TextEditingController gridSizeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _clearBoard();
  }

  void _tapped(int index) {
    setState(() {
      if (displayXO[index] == '') {
        displayXO[index] = oTurn ? 'O' : 'X';
        filledBoxes++;
        _checkWinner();
        if (!winnerFound) {
          _addMoveToHistory(
              displayXO[index], index ~/ gridSize, index % gridSize);
          oTurn = !oTurn;
          if (!oTurn) {
            _aiMove();
          }
        }
      }
    });
  }

  void _aiMove() async {
    List<int> availableMoves = [];
    for (int i = 0; i < gridSize * gridSize; i++) {
      if (displayXO[i] == '') availableMoves.add(i);
    }

    if (availableMoves.isNotEmpty) {
      int move = availableMoves[Random().nextInt(availableMoves.length)];
      setState(() {
        displayXO[move] = 'X';
        filledBoxes++;
        _checkWinner();
        _addMoveToHistory(displayXO[move], move ~/ gridSize, move % gridSize);
      });

      await Future.delayed(Duration(milliseconds: 1));

      setState(() {
        oTurn = true;
      });
    }
  }

  void _checkWinner() {
    for (int i = 0; i < gridSize; i++) {
      if (displayXO[i * gridSize] != '' &&
          List.generate(gridSize, (index) => displayXO[i * gridSize + index])
              .every((element) => element == displayXO[i * gridSize])) {
        setState(() {
          resultDeclaration = 'Player ${displayXO[i * gridSize]} Wins!';
          winnerFound = true;
        });

        _addMoveToHistory(displayXO[i * gridSize], i, i * gridSize);
        return;
      }
    }

    for (int i = 0; i < gridSize; i++) {
      if (displayXO[i] != '' &&
          List.generate(gridSize, (index) => displayXO[i + index * gridSize])
              .every((element) => element == displayXO[i])) {
        setState(() {
          resultDeclaration = 'Player ${displayXO[i]} Wins!';
          winnerFound = true;
        });

        _addMoveToHistory(displayXO[i], i * gridSize, i);
        return;
      }
    }

    if (displayXO[0] != '' &&
        List.generate(gridSize, (index) => displayXO[index * gridSize + index])
            .every((element) => element == displayXO[0])) {
      setState(() {
        resultDeclaration = 'Player ${displayXO[0]} Wins!';
        winnerFound = true;
      });

      _addMoveToHistory(displayXO[0], 0, 0);
      return;
    }

    if (displayXO[gridSize - 1] != '' &&
        List.generate(
                gridSize, (index) => displayXO[(index + 1) * (gridSize - 1)])
            .every((element) => element == displayXO[gridSize - 1])) {
      setState(() {
        resultDeclaration = 'Player ${displayXO[gridSize - 1]} Wins!';
        winnerFound = true;
      });

      _addMoveToHistory(displayXO[gridSize - 1], gridSize - 1, gridSize - 1);
      return;
    }

    if (!winnerFound && filledBoxes == gridSize * gridSize) {
      setState(() {
        resultDeclaration = 'Nobody Wins!';
      });
    }
  }

  void _clearBoard() {
    setState(() {
      displayXO = List.filled(gridSize * gridSize, '');
      resultDeclaration = '';
      filledBoxes = 0;
      winnerFound = false;
      oTurn = true;
    });

    _clearGameHistory();
  }

  void _clearGameHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('gameHistory');
  }

  void _setGridSize() {
    int newSize = int.tryParse(gridSizeController.text) ?? 0;
    if (newSize >= 3 && newSize <= 8) {
      setState(() {
        gridSize = newSize;
        _clearBoard();
      });
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Invalid Grid Size'),
          content: Text('Grid size must be between 3 and 9 inclusive.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void _addMoveToHistory(String player, int rowIndex, int colIndex) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> history = prefs.getStringList('gameHistory') ?? [];
    history.add('$player played at ($rowIndex, $colIndex)');
    await prefs.setStringList('gameHistory', history);
  }

  void _navigateToGameHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? history = prefs.getStringList('gameHistory');

    if (history != null && history.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => GameHistory(history: history)),
      );
    }
  }

  double _calculateFontSize() {
    const double baseFontSize = 40.0;

    double cellSize = MediaQuery.of(context).size.width / gridSize;

    double fontSize = baseFontSize * (cellSize / 100.0);

    return fontSize.clamp(10.0, 40.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 120, 9, 137),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: gridSizeController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Enter Grid size',
                      labelStyle: TextStyle(color: Colors.white),
                      hintText: 'Enter grid size',
                      hintStyle:
                          TextStyle(color: Colors.white.withOpacity(0.5)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _setGridSize,
                  child: Text('Set Grid Size'),
                ),
              ],
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Player ${widget.playerName}',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Noto',
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      'VS  AI',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Noto',
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
               child: LayoutBuilder(
                builder: (context, constraints) {
                  double gridSizePx = min(constraints.maxWidth, constraints.maxHeight);
                  return Container(
                    width: gridSizePx,
                    height: gridSizePx,
                    child: GridView.builder(
                      itemCount: gridSize * gridSize,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: gridSize,
                        mainAxisSpacing: constraints.maxWidth * 0.02,
                        crossAxisSpacing: constraints.maxWidth * 0.02,
                      ),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      _tapped(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          width: 3,
                          color: Colors.white,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                        color: Colors.white.withOpacity(0.8),
                      ),
                      child: Center(
                        child: Text(
                          displayXO[index],
                          style: TextStyle(
                            fontSize: _calculateFontSize(),
                            fontFamily: 'Noto',
                            fontWeight: FontWeight.w600,
                            color: displayXO[index] == 'O'
                                ? Color.fromARGB(255, 8, 131, 255)
                                : Color.fromARGB(255, 255, 30, 173),
                           ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        resultDeclaration,
                        style: TextStyle(
                          color: Color.fromARGB(255, 252, 231, 1),
                          fontFamily: 'Noto',
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            textStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: _clearBoard,
                          child: Text(
                            'Reset!',
                            style: TextStyle(
                              color: Color.fromARGB(255, 214, 2, 147),
                            ),
                          ),
                        ),
                        SizedBox(width: 5),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                            textStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed:
                              _navigateToGameHistory, // Navigate to GameHistory
                          child: Text(
                            'history',
                            style: TextStyle(
                              color: Color.fromARGB(255, 214, 2, 147),
                            ),
                          ),
                        ),
                        SizedBox(width: 5),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                            textStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Back',
                            style: TextStyle(
                              color: Color.fromARGB(255, 214, 2, 147),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
