import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:quizwiz/app/app_export.dart';
import 'package:quizwiz/widgets/quiz_card_widget.dart';

import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    bool isDark = getThemeManager(context).isDarkMode;
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        centerTitle: true,
        title: RubikMazeText.regular("QUIZWIZ", 24, colorScheme.primary),
        actions: [
          IconButton(
            onPressed: () => viewModel.toggleDarkLightMode(context),
            icon: Icon(
                isDark ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
                size: 28,
                color: colorScheme.primary),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                verticalSpaceSmall,
                ManropeText.medium("Hi,", 20, colorScheme.onSecondaryContainer),
                verticalSpaceTiny,
                DefaultTextStyle(
                  style: manropeMedium.copyWith(
                      fontSize: 20, color: colorScheme.onSecondaryContainer),
                  child: AnimatedTextKit(totalRepeatCount: 1, animatedTexts: [
                    TypewriterAnimatedText(
                      "Choose a category to get started",
                    )
                  ]),
                ),
                verticalSpaceMedium,
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: 20),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15.0,
                      mainAxisSpacing: 15.0,
                      childAspectRatio: 1.5),
                  itemCount: viewModel.quizCategories.length,
                  itemBuilder: (BuildContext context, int index) {
                    return AnimationConfiguration.staggeredGrid(
                      position: index,
                      duration: const Duration(milliseconds: 805),
                      columnCount: 2,
                      child: ScaleAnimation(
                        child: FadeInAnimation(
                          child: InkWell(
                            onTap: () {
                              viewModel.navigateToTakeQuiz(
                                  viewModel.quizCategories[index].title);
                            },
                            child: QuizCardWidget(
                              topic: viewModel.quizCategories[index],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
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
