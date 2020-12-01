import 'package:flutter_test/flutter_test.dart';
import 'package:mine_sweeper/models/board.dart';

main() {
  test('Win Game', () {
    Board b = Board(lines: 2, columns: 2, qntBombs: 0);
    b.fields[0].mine();
    b.fields[3].mine();
    b.fields[0].changeMarked();
    b.fields[1].openField();
    b.fields[2].openField();
    b.fields[3].changeMarked();
    expect(b.resolved, isTrue);
  });
}
