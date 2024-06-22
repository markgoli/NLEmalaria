import 'package:flutter/material.dart';

extension IntSizedBoxExtension on int {
  SizedBox height() {
    return SizedBox(
      height: toDouble(),
    );
  }

  SizedBox width() {
    return SizedBox(
      width: toDouble(),
    );
  }
}
