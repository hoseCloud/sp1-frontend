import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

Center loading() {
  return Center(
    child: LoadingAnimationWidget.staggeredDotsWave(
      color: Colors.grey,
      size: 100,
    ),
  );
}

