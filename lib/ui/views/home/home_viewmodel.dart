import 'package:quizwiz/app/app_export.dart';
import 'package:quizwiz/ui/views/home/quiz_view.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  List<QuizTopicModel> quizCategories = [
    QuizTopicModel(title: ksRandom, icon: icDice),
    QuizTopicModel(title: ksEntertainment, icon: icHeadphones),
    QuizTopicModel(title: ksSports, icon: icBasketball),
    QuizTopicModel(title: ksScience, icon: icLab),
    QuizTopicModel(title: ksAnimals, icon: icKoala),
    QuizTopicModel(title: ksGeneralKnowledge, icon: icBulb),
    QuizTopicModel(title: ksMythology, icon: icZeus),
    QuizTopicModel(title: ksPolitics, icon: icPolitician),
    QuizTopicModel(title: ksGeography, icon: icGeography),
    QuizTopicModel(title: ksHistory, icon: icHistory),
  ];

  void navigateToTakeQuiz(String title) {
    _navigationService.navigateToView(QuizView(
      title: title,
    ));
  }
}
