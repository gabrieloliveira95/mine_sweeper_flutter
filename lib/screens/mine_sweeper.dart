import 'package:flutter/material.dart';
import 'package:mine_sweeper/components/board_widget.dart';
import 'package:mine_sweeper/components/result_widget.dart';
import 'package:mine_sweeper/models/board.dart';
import 'package:mine_sweeper/models/exception_explosion.dart';
import 'package:mine_sweeper/models/field.dart';

class MineSweeper extends StatefulWidget {
  @override
  _MineSweeperState createState() => _MineSweeperState();
}

class _MineSweeperState extends State<MineSweeper> {
  bool _win;
  Board _board;

  void _reboot() {
    setState(() {
      _win = null;
      _board.reboot();
    });
  }

  void _open(Field field) {
    setState(() {
      if (_win != null) {
        return;
      }
      try {
        field.openField();
        if (_board.resolved) {
          _win = true;
        }
      } on ExplosionException catch (_) {
        _board.bombReveal();
        _win = false;
      }
    });
  }

  void _changeMarkup(Field field) {
    if (_win != null) {
      return;
    }
    setState(() {
      field.changeMarked();
      if (_board.resolved) {
        _win = true;
      }
    });
  }

  Board _getboard(double width, double height) {
    if (_board == null) {
      int columns = 15;
      double fieldSize = width / columns;
      int lines = (height / fieldSize).floor();

      _board = Board(
        columns: columns,
        lines: lines,
        qntBombs: 50,
      );
    }
    return _board;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: ResultWidget(
          win: _win,
          onReboot: () => _reboot(),
        ),
        body: Container(
          color: Colors.grey,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return BoardWidget(
                board: _getboard(
                  constraints.maxWidth,
                  constraints.maxHeight,
                ),
                onChangeMarkup: _changeMarkup,
                onOpen: _open,
              );
            },
          ),
        ),
      ),
    );
  }
}
