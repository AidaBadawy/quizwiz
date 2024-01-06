class QuizModel {
  final String? question;
  final String? category;
  final String? type;
  final String? difficulty;
  final String? correctAnswer;
  final List<String>? incorrectAnswers;
  final int? id;

  QuizModel({
    this.question,
    this.category,
    this.type,
    this.difficulty,
    this.correctAnswer,
    this.incorrectAnswers,
    this.id,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) => QuizModel(
        question: json["question"],
        category: json["category"],
        type: json["type"],
        difficulty: json["difficulty"],
        correctAnswer: json["correct_answer"],
        incorrectAnswers: json["incorrect_answers"] == null
            ? []
            : List<String>.from(json["incorrect_answers"]!.map((x) => x)),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "question": question,
        "category": category,
        "type": type,
        "difficulty": difficulty,
        "correct_answer": correctAnswer,
        "incorrect_answers": incorrectAnswers == null
            ? []
            : List<dynamic>.from(incorrectAnswers!.map((x) => x)),
        "id": id,
      };
}
