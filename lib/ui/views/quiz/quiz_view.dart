import 'package:animate_do/animate_do.dart';
import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:html/parser.dart';
import 'package:lottie/lottie.dart';
import 'package:quizwiz/app/app_export.dart';
import 'package:quizwiz/widgets/button_widget.dart';

import 'quiz_viewmodel.dart';

class QuizView extends StackedView<QuizViewModel> {
  final String title;
  const QuizView({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    QuizViewModel viewModel,
    Widget? child,
  ) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        iconTheme: IconThemeData(color: colorScheme.primary),
        backgroundColor: colorScheme.background,
        elevation: 0,
        centerTitle: true,
        title: RubikMazeText.regular(title, 20, colorScheme.primary),
        actions: [
          if (viewModel.status == StatusEnum.started)
            Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ManropeText.semiBold(
                      "${viewModel.currentQuestionInt + 1} of 10",
                      16,
                      colorScheme.primary),
                ),
              ],
            ),
        ],
      ),
      body: ConnectivityWidgetWrapper(
        alignment: Alignment.topCenter,
        decoration: const BoxDecoration(
          color: Colors.red,
        ),
        height: 50.0,
        message: "You are Offline!",
        messageStyle: manropeMedium.copyWith(color: kcWhite),
        child: viewModel.status == StatusEnum.busy
            ? Stack(
                fit: StackFit.expand,
                alignment: Alignment.center,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 15,
                    child: ManropeText.medium(
                      "Unlock Your Knowledge\nOne Question at a Time!",
                      16,
                      colorScheme.onSecondaryContainer,
                      letterSpacing: 1,
                    ),
                  )
                ],
              )
            : viewModel.status == StatusEnum.ready
                ? Center(child: LottieBuilder.asset(icCountJson))
                : FadeInRight(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          verticalSpaceMedium,
                          LinearProgressIndicator(
                            value:
                                (viewModel.currentQuestionInt.toDouble() + 1) /
                                    10,
                            minHeight: 10,
                            backgroundColor: kcLightGrey,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          verticalSpaceMedium,
                          ManropeText.semiBold(
                              viewModel.currentQuiz.category ?? "",
                              14,
                              colorScheme.onSecondaryContainer),
                          verticalSpaceSmall,
                          LayoutBuilder(builder: (context, constraints) {
                            final span = TextSpan(
                                text: parseFragment(
                                        "${viewModel.currentQuiz.question}")
                                    .text!,
                                style: manropeSemiBold.copyWith(
                                    fontSize: 30,
                                    color: colorScheme.onSecondaryContainer));
                            final tp = TextPainter(
                                text: span, textDirection: TextDirection.ltr);
                            tp.layout(maxWidth: constraints.maxWidth);
                            final numLines = tp.computeLineMetrics().length;

                            return ManropeText.semiBold(
                                parseFragment(
                                        "${viewModel.currentQuiz.question}")
                                    .text!,
                                viewModel.changeFontSize(numLines),
                                colorScheme.onSecondaryContainer);
                          }),
                          verticalSpaceMedium,
                          ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () => viewModel.isAsnwered
                                    ? {}
                                    : viewModel.selectAnswer(
                                        viewModel.currentQuiz
                                            .incorrectAnswers![index],
                                        index),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 15),
                                  alignment: Alignment.centerLeft,
                                  // margin: const EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      width: viewModel.isAsnwered ? 2 : 1,
                                      color: viewModel.isAsnwered
                                          ? index == viewModel.selectedIndex
                                              ? index == viewModel.answerIndex
                                                  ? Colors.green
                                                  : Colors.red
                                              : index == viewModel.answerIndex
                                                  ? Colors.green
                                                  : kcLightGrey
                                          : kcLightGrey,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: ManropeText.semiBold(
                                            parseFragment(viewModel.currentQuiz
                                                    .incorrectAnswers![index])
                                                .text!,
                                            18,
                                            colorScheme.onSecondaryContainer),
                                      ),
                                      SvgPicture.asset(
                                        viewModel.isAsnwered
                                            ? index == viewModel.selectedIndex
                                                ? index == viewModel.answerIndex
                                                    ? icCorrect
                                                    : icWrong
                                                : index == viewModel.answerIndex
                                                    ? icCorrect
                                                    : icSquareRound
                                            : icSquareRound,
                                        color: viewModel.isAsnwered
                                            ? index == viewModel.selectedIndex
                                                ? index == viewModel.answerIndex
                                                    ? Colors.green
                                                    : Colors.red
                                                : index == viewModel.answerIndex
                                                    ? Colors.green
                                                    : kcLightGrey
                                            : kcLightGrey,
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (conntext, index) {
                              return verticalSpaceSmall;
                            },
                            itemCount:
                                viewModel.currentQuiz.incorrectAnswers!.length,
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              Expanded(
                                child: ButtonWidget(
                                  onPressed: () {
                                    if (viewModel.currentQuestionInt == 9) {
                                      viewModel.showCompleteDialog();
                                    } else {
                                      if (viewModel.isAsnwered) {
                                        viewModel.setCurrentQuestion();
                                      }
                                    }
                                  },
                                  isBusy: false,
                                  text: viewModel.currentQuestionInt == 9
                                      ? "Finish"
                                      : "Next",
                                  btnColor: colorScheme.primary,
                                  textColor: kcWhite,
                                  radius: 8,
                                  height: 60,
                                  fontSize: 16,
                                  hasIcon: false,
                                  isOutline: false,
                                ),
                              ),
                            ],
                          ),
                          verticalSpaceSmall,
                          verticalSpaceTiny
                        ],
                      ),
                    ),
                  ),
      ),
    );
  }

  @override
  QuizViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      QuizViewModel();

  @override
  void onViewModelReady(QuizViewModel viewModel) {
    viewModel.initQuizView(title);
    super.onViewModelReady(viewModel);
  }
}
