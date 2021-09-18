import 'package:flutter/material.dart';

class AppbarBackgroundDecoration extends BoxDecoration {
  @override
  DecorationImage get image {
    return DecorationImage(
      image: AssetImage('assets/images/bg_header.png'),
      fit: BoxFit.cover
    );
  }
}