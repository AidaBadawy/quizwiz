import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:quizwiz/ui/common/app_colors.dart';
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
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                icLogoTransparent,
                height: 100,
              ),
              verticalSpaceMedium,
              Hero(
                  tag: "logo-text",
                  child: RubikMazeText.regular("QUIZWIZ", 44, kcPrimaryColor)),
            ],
          ),
          Positioned(
            bottom: 15,
            child: DefaultTextStyle(
              style: rubikMazeRegular.copyWith(
                fontSize: 16,
              ),
              child: AnimatedTextKit(
                  totalRepeatCount: 1,
                  animatedTexts: [
                    TypewriterAnimatedText("UNLOCK YOUR KNOWLEDGE",
                        speed: const Duration(milliseconds: 100))
                  ],
                  onFinished: () {
                    // SchedulerBinding.instance.addPostFrameCallback(
                    //     (timeStamp) => );

                    viewModel.runStartupLogic();
                  }),
            ),
          )
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
