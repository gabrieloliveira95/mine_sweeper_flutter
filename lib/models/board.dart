import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:mine_sweeper/models/field.dart';

class Board {
  final int lines;
  final int columns;
  final int qntBombs;

  final List<Field> _fields = [];

  Board({
    @required this.lines,
    @required this.columns,
    @required this.qntBombs,
  }) {
    _createFields();
    _relateNeighborhoods();
    _mineSort();
  }

  void _createFields() {
    for (int l = 0; l < lines; l++) {
      for (int c = 0; c < lines; c++) {
        _fields.add(
          Field(column: c, line: l),
        );
      }
    }
  }

  void _relateNeighborhoods() {
    for (var field in _fields) {
      for (var neighborhood in _fields) {
        field.addNeighborhood(neighborhood);
      }
    }
  }

  void reboot() {
    _fields.forEach((element) => element.reboot());
    _mineSort();
  }

  void bombReveal() {
    _fields.forEach((element) => element.revealBombs());
  }

  void _mineSort() {
    if (qntBombs > lines * columns) return;
    int sorted = 0;
    while (sorted < qntBombs) {
      int i = Random().nextInt(_fields.length);
      if (!_fields[i].mined) {
        sorted++;
        _fields[i].mine();
      }
    }
  }

  List<Field> get fields {
    return _fields;
  }

  bool get resolved {
    return _fields.every((element) => element.resolved);
  }
}
