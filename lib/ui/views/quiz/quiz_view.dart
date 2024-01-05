import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'quiz_viewmodel.dart';

class QuizView extends StackedView<QuizViewModel> {
  const QuizView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    QuizViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
      ),
    );
  }

  @override
  QuizViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      QuizViewModel();
}
