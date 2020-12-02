import 'package:flutter/material.dart';
import 'package:mine_sweeper/components/field_widget.dart';
import 'package:mine_sweeper/models/board.dart';
import 'package:mine_sweeper/models/field.dart';

class BoardWidget extends StatelessWidget {
  final Board board;
  final void Function(Field) onOpen;
  final void Function(Field) onChangeMarkup;

  BoardWidget({
    @required this.board,
    @required this.onChangeMarkup,
    @required this.onOpen,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        crossAxisCount: board.columns,
        children: board.fields.map((e) {
          return FieldWidget(
            field: e,
            onChangeMarkup: onChangeMarkup,
            onOpen: onOpen,
          );
        }).toList(),
      ),
    );
  }
}
