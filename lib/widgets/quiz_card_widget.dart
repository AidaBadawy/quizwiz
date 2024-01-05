import 'package:flutter/material.dart';
import 'package:quizwiz/app/app_export.dart';

class QuizCardWidget extends StatelessWidget {
  final QuizTopicModel topic;
  const QuizCardWidget({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: 0,
            child: Material(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              elevation: 4,
              color: Theme.of(context).colorScheme.primaryContainer,
              child: Container(
                padding: const EdgeInsets.only(bottom: 5),
                alignment: Alignment.bottomCenter,
                height: constraints.maxHeight - 30,
                width: constraints.maxWidth,
                child: ManropeText.medium(topic.title, 16, kcDarkGreyColor),
              ),
            ),
          ),
          Positioned(
            top: 0,
            child: Transform.rotate(
              angle: 0,
              child: Image.asset(
                topic.icon,
                height: 80,
              ),
            ),
          ),
        ],
      );
    });
  }
}
