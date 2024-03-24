import 'package:flutter/material.dart';

void main() {
  runApp(TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TicTacToe(),
    );
  }
}

class TicTacToe extends StatefulWidget {
  @override
  _TicTacToeState createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  late List<List<String>> _board;
  late bool _player1Turn;

  @override
  void initState() {
    super.initState();
    _initializeBoard();
  }

  void _initializeBoard() {
    _board = List.generate(3, (_) => List.generate(3, (_) => ""));
    _player1Turn = true;
  }

  void _resetBoard() {
    setState(() {
      _initializeBoard();
    });
  }

  void _playMove(int row, int col) {
    if (_board[row][col] == "") {
      setState(() {
        _board[row][col] = _player1Turn ? "X" : "O";
        _player1Turn = !_player1Turn;
      });
    }
  }

  String? _checkWinner() {
    for (int i = 0; i < 3; i++) {
      if (_board[i][0] != "" &&
          _board[i][0] == _board[i][1] &&
          _board[i][0] == _board[i][2]) {
        return _board[i][0];
      }
      if (_board[0][i] != "" &&
          _board[0][i] == _board[1][i] &&
          _board[0][i] == _board[2][i]) {
        return _board[0][i];
      }
    }
    if (_board[0][0] != "" &&
        _board[0][0] == _board[1][1] &&
        _board[0][0] == _board[2][2]) {
      return _board[0][0];
    }
    if (_board[0][2] != "" &&
        _board[0][2] == _board[1][1] &&
        _board[0][2] == _board[2][0]) {
      return _board[0][2];
    }
    bool isDraw = true;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (_board[i][j] == "") {
          isDraw = false;
          break;
        }
      }
    }
    if (isDraw) {
      return "draw";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _player1Turn ? "Player 1's turn (X)" : "Player 2's turn (O)",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            GridView.builder(
              shrinkWrap: true,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: (BuildContext context, int index) {
                int row = index ~/ 3;
                int col = index % 3;
                return GestureDetector(
                  onTap: () => _playMove(row, col),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                    ),
                    child: Center(
                      child: Text(
                        _board[row][col],
                        style: TextStyle(fontSize: 40),
                      ),
                    ),
                  ),
                );
              },
              itemCount: 9,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _resetBoard,
              child: Text('Reset'),
            ),
          ],
        ),
      ),
    );
  }
}
