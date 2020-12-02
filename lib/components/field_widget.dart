import 'package:flutter/material.dart';
import 'package:mine_sweeper/models/field.dart';

class FieldWidget extends StatelessWidget {
  final Field field;
  final void Function(Field) onOpen;
  final void Function(Field) onChangeMarkup;

  FieldWidget({
    @required this.field,
    @required this.onChangeMarkup,
    @required this.onOpen,
  });

  Widget _getContent() {
    if (field.open && field.mined && field.exploded) {
      return Image.asset('assets/images/bomb_0.jpeg');
    } else if (field.open && field.mined) {
      return Image.asset('assets/images/bomb_1.jpeg');
    } else if (field.open) {
      return Image.asset('assets/images/open_${field.qtdMines}.jpeg');
    } else if (field.marked) {
      return Image.asset('assets/images/flag.jpeg');
    } else {
      return Image.asset('assets/images/closed.jpeg');
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onOpen(field),
      onLongPress: () => onChangeMarkup(field),
      child: _getContent(),
    );
  }
} //Next 10
