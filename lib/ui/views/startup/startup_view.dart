import 'package:animate_do/animate_do.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:quizwiz/ui/common/app_images.dart';
import 'package:quizwiz/ui/common/box_text.dart';
import 'package:stacked/stacked.dart';
import 'package:quizwiz/ui/common/ui_helpers.dart';

import 'startup_viewmodel.dart';

class StartupView extends StackedView<StartupViewModel> {
  const StartupView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    StartupViewModel viewModel,
    Widget? child,
  ) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeInLeft(
                duration: const Duration(seconds: 1),
                child: Image.asset(
                  icLogoTransparent,
                  color: colorScheme.primary,
                  height: 100,
                ),
              ),
              verticalSpaceMedium,
              RubikMazeText.regular("QUIZWIZ", 44, colorScheme.primary),
            ],
          ),
          Positioned(
            bottom: 15,
            child: DefaultTextStyle(
              style: rubikMazeRegular.copyWith(
                  fontSize: 16, color: colorScheme.primary),
              child: AnimatedTextKit(
                  totalRepeatCount: 1,
                  animatedTexts: [
                    TypewriterAnimatedText("Your Ultimate Quiz Companion",
                        speed: const Duration(milliseconds: 100))
                  ],
                  onFinished: () {
                    viewModel.runStartupLogic();
                  }),
            ),
          ),
        ],
      ),
    );
  }

  @override
  StartupViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      StartupViewModel();

  // @override
  // void onViewModelReady(StartupViewModel viewModel) => SchedulerBinding.instance
  //     .addPostFrameCallback((timeStamp) => viewModel.runStartupLogic());
}
