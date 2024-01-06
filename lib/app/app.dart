import 'package:quizwiz/services/quiz_service.dart';
import 'package:quizwiz/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:quizwiz/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:quizwiz/ui/views/home/home_view.dart';
import 'package:quizwiz/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:quizwiz/ui/views/quiz/quiz_view.dart';
import 'package:quizwiz/ui/dialogs/congrats/congrats_dialog.dart';
// @stacked-import

@StackedApp(
  routes: [
    CustomRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    CustomRoute(page: QuizView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: QuizService),
    // @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    StackedDialog(classType: CongratsDialog),
// @stacked-dialog
  ],
)
class App {}
