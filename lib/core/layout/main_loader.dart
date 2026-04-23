import 'package:cook_meal/core/layout/card_padding.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class MainLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 64),
      child: CardPadding(
        child: Center(
          child: LoadingAnimationWidget.twoRotatingArc(
            color: Theme.of(context).hintColor,
            size: 24,
          ),
        ),
      ),
    );
  }
}
