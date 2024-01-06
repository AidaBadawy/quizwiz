class QuizPayload {
  final String? category;
  final int limit;

  QuizPayload({
    this.category,
    required this.limit,
  });

  factory QuizPayload.fromRawJson(Map<String, dynamic> jsonData) {
    return QuizPayload(
      category: jsonData['category'],
      limit: jsonData['limit'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (category != null) "category": category,
      "limit": limit,
    };
  }
}
