import 'package:flutter/material.dart';

class GameHistory extends StatelessWidget {
  final List<String> history;

  const GameHistory({Key? key, required this.history}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> movesX = [];
    List<String> movesO = [];

    // Separate moves by 'X' and 'O'
    for (String move in history) {
      if (move.contains('X')) {
        movesX.add(move);
      } else if (move.contains('O')) {
        movesO.add(move);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Game History'),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 226, 112, 236),
              Color.fromARGB(255, 173, 45, 216)
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (movesX.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Moves by X:',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(height: 8),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: movesX.length,
                      separatorBuilder: (context, index) =>
                          Divider(color: Colors.white),
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.indigo,
                            child: Text(
                              '${index + 1}',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          title: Text(
                            movesX[index],
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              SizedBox(height: 16),
              if (movesO.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Moves by O:',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(height: 8),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: movesO.length,
                      separatorBuilder: (context, index) =>
                          Divider(color: Colors.white),
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.indigo,
                            child: Text(
                              '${index + 1}',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          title: Text(
                            movesO[index],
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              if (movesX.isEmpty && movesO.isEmpty)
                Center(
                  child: Text(
                    'No game history available.',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
