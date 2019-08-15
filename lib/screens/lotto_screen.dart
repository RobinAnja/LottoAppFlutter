import 'package:flutter/material.dart';
import 'package:flutter_lotto_app/util/LottoColors.dart';
import 'package:flutter_lotto_app/widgets/lotto_widget.dart';

class LottoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: LottoColors.light_yellow,
        title: Center(
            child: Text(
          "Lotto",
          style: TextStyle(color: LottoColors.red),
        )),
        elevation: 0.0,
      ),
      body: Container(
        decoration: BoxDecoration(
          // Box decoration takes a gradient
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [LottoColors.light_yellow, LottoColors.yellow],
          ),
        ),
        child: LottoWidget(),
      ),
    );
  }
}
