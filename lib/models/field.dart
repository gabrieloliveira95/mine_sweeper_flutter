import 'package:flutter/foundation.dart';
import 'package:mine_sweeper/models/exception_explosion.dart';

class Field {
  final int line;
  final int column;
  final List<Field> neighborhoods = [];
  bool _isOpen = false;
  bool _isMarked = false;
  bool _isMined = false;
  bool _isExploded = false;

  Field({
    @required this.line,
    @required this.column,
    int lines,
  });

  void addNeighborhood(Field neighborhood) {
    final deltaLine = (line - neighborhood.line).abs();
    final deltaColumn = (column - neighborhood.column).abs();

    if (deltaLine == 0 && deltaColumn == 0) {
      return;
    }
    if (deltaLine <= 1 && deltaColumn <= 1) {
      neighborhoods.add(neighborhood);
    }
  }

  void openField() {
    if (_isOpen) return;
    _isOpen = true;
    if (_isMined) {
      _isExploded = true;
      throw ExplosionException();
    }
    if (safeNeighborhoods) {
      neighborhoods.forEach((element) {
        element.openField();
      });
    }
  }

  void revealBombs() {
    if (_isMined) {
      _isOpen = true;
    }
  }

  void mine() {
    _isMined = true;
  }

  void changeMarked() {
    _isMarked = !_isMarked;
  }

  void reboot() {
    _isOpen = false;
    _isMarked = false;
    _isMined = false;
    _isExploded = false;
  }

  bool get mined => _isMined;
  bool get exploded => _isExploded;
  bool get open => _isOpen;
  bool get marked => _isMarked;

  bool get resolved {
    bool minedAndMarked = mined && marked;
    bool notMinedAndMarked = !mined && open;
    return minedAndMarked || notMinedAndMarked;
  }

  bool get safeNeighborhoods {
    return neighborhoods.every((element) => !element._isMined);
  }

  int get qtdMines {
    return neighborhoods.where((element) => element._isMined).length;
  }
}
