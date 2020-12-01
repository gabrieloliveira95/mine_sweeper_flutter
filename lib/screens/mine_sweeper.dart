import 'package:flutter/material.dart';
import 'package:mine_sweeper/components/result_widget.dart';

class MineSweeper extends StatelessWidget {
  _reboot() {
    print("ok");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: ResultWidget(
          win: true,
          onReboot: () => _reboot(),
        ),
        body: Container(
          child: Text('Board'),
        ),
      ),
    );
  }
}
