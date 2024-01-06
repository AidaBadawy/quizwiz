import 'package:dio/dio.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:quizwiz/app/app_export.dart';
import 'package:quizwiz/models/quiz_model.dart';
import 'package:quizwiz/models/quiz_payload.dart';
import 'package:quizwiz/services/dio_client.dart';
import 'package:quizwiz/utils/env.dart';

class QuizService with ListenableServiceMixin {
  QuizService() {
    listenToReactiveValues([
      _quizList,
    ]);
  }

  final ReactiveValue<List<QuizModel>> _quizList =
      ReactiveValue<List<QuizModel>>([]);
  List<QuizModel> get quizList => _quizList.value;
  late Dio _dio;

  Future<bool> fetchQuiz(QuizPayload payload) async {
    try {
      _dio = await DioClient().publicDio();
      final response = await _dio.get(
        env!.quizUrl,
        queryParameters: payload.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;

        _quizList.value =
            List.from(data.map<QuizModel>((e) => QuizModel.fromJson(e)));

        notifyListeners();

        return true;
      }
    } on DioException {
      // Fluttertoast.showToast(
      //     msg: exception.message.toString(),
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.BOTTOM,
      //     timeInSecForIosWeb: 1,
      //     backgroundColor: Colors.red,
      //     textColor: Colors.white,
      //     fontSize: 16.0);

      rethrow;
    }

    return false;
  }
}
