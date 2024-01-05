import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:quizwiz/ui/common/box_text.dart';
import 'package:quizwiz/widgets/quiz_card_widget.dart';
import 'package:stacked/stacked.dart';
import 'package:quizwiz/ui/common/app_colors.dart';
import 'package:quizwiz/ui/common/ui_helpers.dart';

import 'home_viewmodel.dart';

class QuizView extends StackedView<HomeViewModel> {
  final String title;
  const QuizView({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: kcWhite,
      appBar: AppBar(
        iconTheme: IconThemeData(color: kcPrimaryColor),
        backgroundColor: kcWhite,
        elevation: 0,
        centerTitle: true,
        title: Hero(
          tag: "logo-text",
          child: RubikMazeText.regular(title, 24, kcPrimaryColor),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              verticalSpaceSmall,
              ManropeText.medium("Hi,", 20, kcDarkGreyColor),
              verticalSpaceTiny,
              DefaultTextStyle(
                style: manropeMedium.copyWith(
                    fontSize: 20, color: kcDarkGreyColor),
                child: AnimatedTextKit(totalRepeatCount: 1, animatedTexts: [
                  TypewriterAnimatedText(
                    "Choose a category to get started",
                  )
                ]),
              ),
              verticalSpaceMedium,
              // Expanded(
              //   child: GridView.builder(
              //     shrinkWrap: true,
              //     physics: const BouncingScrollPhysics(),
              //     padding: const EdgeInsets.only(bottom: 20),
              //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //         crossAxisCount: 2,
              //         crossAxisSpacing: 15.0,
              //         mainAxisSpacing: 15.0,
              //         childAspectRatio: 1.5),
              //     itemCount: viewModel.quizCategories.length,
              //     itemBuilder: (BuildContext context, int index) {
              //       return InkWell(
              //         onTap: () {
              //           // viewModel.navigateToTakeQuiz(
              //           //     viewModel.quizCategories[index].title);
              //         },
              //         child: QuizCardWidget(
              //           topic: viewModel.quizCategories[index],
              //         ),
              //       );
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();
}
