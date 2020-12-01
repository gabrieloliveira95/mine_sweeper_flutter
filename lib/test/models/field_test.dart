import 'package:flutter_test/flutter_test.dart';
import 'package:mine_sweeper/models/field.dart';

main() {
  group('Field', () {
    test('OpenMine With Explosion', () {
      Field c = Field(column: 0, line: 0);
      c.mine();
      expect(c.openField, throwsException);
    });
    test('OpenMine Without Explosion', () {
      Field c = Field(column: 0, line: 0);
      c.openField();
      expect(c.open, isTrue);
    });
    test('Dont Add Neighborhood', () {
      Field c1 = Field(column: 0, line: 0);
      Field c2 = Field(column: 1, line: 3);
      c1.addNeighborhood(c2);
      expect(c1.neighborhoods.isEmpty, isTrue);
    });
    test('Add  Neighborhood', () {
      Field c1 = Field(column: 3, line: 3);
      Field c2 = Field(column: 4, line: 3);
      c2.mine();
      Field c3 = Field(column: 2, line: 2);
      Field c4 = Field(column: 4, line: 4);
      c4.mine();
      c1.addNeighborhood(c2);
      c1.addNeighborhood(c3);
      c1.addNeighborhood(c4);
      expect(c1.qtdMines, 2);
    });

    test('Neighborhoods Mined', () {
      Field c1 = Field(column: 3, line: 3);
      Field c2 = Field(column: 4, line: 3);
      Field c3 = Field(column: 2, line: 2);
      Field c4 = Field(column: 4, line: 4);
      c1.addNeighborhood(c2);
      c1.addNeighborhood(c3);
      c1.addNeighborhood(c4);
      expect(c1.neighborhoods.length, 3);
    });
  });
}
