import 'package:quizwiz/app/app_export.dart';
import 'package:quizwiz/models/quiz_model.dart';
import 'package:quizwiz/models/quiz_payload.dart';
import 'package:quizwiz/services/quiz_service.dart';
import 'package:stacked_services/stacked_services.dart';

class QuizViewModel extends ReactiveViewModel {
  final _navigationService = locator<NavigationService>();
  final _quizService = locator<QuizService>();
  final _dialogService = locator<DialogService>();

  List<QuizModel> get quizList => _quizService.quizList;

  List<String> quoteList = [];

  StatusEnum _status = StatusEnum.idle;
  StatusEnum get status => _status;

  int _currentQuestionInt = 0;
  int get currentQuestionInt => _currentQuestionInt;

  QuizModel _currentQuiz = QuizModel();
  QuizModel get currentQuiz => _currentQuiz;

  bool _isAnswered = false;
  bool get isAsnwered => _isAnswered;

  bool _isAnswerCorrect = false;
  bool get isAnswerCorrect => _isAnswerCorrect;

  int _selectedIndex = -1;
  int get selectedIndex => _selectedIndex;

  int _answerIndex = 0;
  int get answerIndex => _answerIndex;

  final List<bool> _boolAnswered = [];

  initQuizView(title) {
    fetchQuiz(title);
  }

  fetchQuiz(title) async {
    setStatus(StatusEnum.busy);

    QuizPayload payload =
        QuizPayload(category: title == ksRandom ? null : title, limit: 10);
    await _quizService.fetchQuiz(payload);
    updateCurrentQuestion();
    await Future.delayed(const Duration(seconds: 1));

    setStatus(StatusEnum.ready);
    await Future.delayed(const Duration(seconds: 4));
    setStatus(StatusEnum.started);
  }

  setStatus(StatusEnum value) {
    _status = value;
    notifyListeners();
  }

  setCurrentQuestion() {
    _isAnswered = false;

    _currentQuestionInt += 1;
    updateCurrentQuestion();

    notifyListeners();
  }

  selectAnswer(String value, int index) {
    _isAnswered = true;
    _selectedIndex = index;

    if (index == _answerIndex) {
      _isAnswerCorrect = true;
      _boolAnswered.add(_isAnswerCorrect);
    } else {
      _isAnswerCorrect = false;
      _boolAnswered.add(_isAnswerCorrect);
    }
    notifyListeners();
  }

  updateCurrentQuestion() {
    _currentQuiz = quizList[_currentQuestionInt];
    _currentQuiz.incorrectAnswers!.add(_currentQuiz.correctAnswer!);

    _currentQuiz.incorrectAnswers!.shuffle();

    _answerIndex = _currentQuiz.incorrectAnswers!
        .indexWhere((element) => element == _currentQuiz.correctAnswer);

    notifyListeners();
  }

  changeFontSize(int num) {
    double fontSize = 30;
    switch (num) {
      case 4:
        fontSize = 26;
        break;
      case 5:
        fontSize = 24;
        break;
      case 6:
        fontSize = 22;
        break;
      case 7:
        fontSize = 20;
        break;
      default:
    }

    return fontSize;
  }

  void showCompleteDialog() async {
    int correct =
        _boolAnswered.where((element) => element == true).toList().length;
    var response = await _dialogService.showCustomDialog(
        variant: DialogType.congrats, data: correct);

    if (response!.confirmed) {
      _navigationService.back();
    }
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_quizService];
}
