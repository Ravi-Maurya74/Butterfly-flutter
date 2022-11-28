// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadWidget extends StatelessWidget {
  static const Color top_color = Color(0xff43a0a4);
  const LoadWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpinKitWave(
      size: 100,
      color: top_color,
    );
  }
}
