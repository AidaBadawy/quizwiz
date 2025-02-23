import 'package:flutter/material.dart';
import 'package:quizwiz/ui/common/box_text.dart';
import 'package:quizwiz/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'congrats_dialog_model.dart';

const double _graphicSize = 60;

class CongratsDialog extends StackedView<CongratsDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const CongratsDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    CongratsDialogModel viewModel,
    Widget? child,
  ) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    int answers = request.data;
    String title = answers == 0
        ? "Missed them all!"
        : answers > 0 && answers < 5
            ? "Good effort!"
            : answers >= 5 && answers < 10
                ? "Nice work!"
                : "Perfect score!";
    String desc = answers == 0
        ? "Don't worry, practice makes perfect. Try again!"
        : answers > 0 && answers < 5
            ? "Keep going to improve your score!"
            : answers >= 5 && answers < 10
                ? "You're on your way to mastering these quizzes!"
                : "You're a quiz wiz. Ready for the next challenge?";
    String emojiString = answers == 0
        ? "🥲"
        : answers > 0 && answers < 5
            ? "🤨"
            : answers >= 5 && answers < 10
                ? "💪"
                : "🤩";
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ManropeText.black(
                          title, 18, colorScheme.onSecondaryContainer),
                      // Text(
                      //   request.title ?? 'Hello Stacked Dialog!!',
                      //   style: const TextStyle(
                      //     fontSize: 16,
                      //     fontWeight: FontWeight.w900,
                      //   ),
                      // ),
                      verticalSpaceSmall,
                      ManropeText.medium(
                          desc, 14, colorScheme.onSecondaryContainer)
                    ],
                  ),
                ),
                horizontalSpaceSmall,
                Container(
                  width: _graphicSize,
                  height: _graphicSize,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF6E7B0),
                    borderRadius: BorderRadius.all(
                      Radius.circular(_graphicSize / 2),
                    ),
                  ),
                  alignment: Alignment.center,
                  child:
                      Text(emojiString, style: const TextStyle(fontSize: 30)),
                )
              ],
            ),
            verticalSpaceMedium,
            RubikMazeText.regular(
                "${answers.toString()} / 10", 34, colorScheme.primary),
            verticalSpaceMedium,
            GestureDetector(
              onTap: () => completer(DialogResponse(confirmed: true)),
              child: Container(
                height: 50,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Play Again',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  CongratsDialogModel viewModelBuilder(BuildContext context) =>
      CongratsDialogModel();
}
