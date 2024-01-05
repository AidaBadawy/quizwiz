import 'package:flutter/material.dart';

class QuizTopicModel {
  final String title;
  final String? subtitle;
  final String icon;
  final String? urlImage;
  final List<Color>? gradient;

  QuizTopicModel({
    required this.title,
    this.subtitle,
    required this.icon,
    this.urlImage,
    this.gradient,
  });

  factory QuizTopicModel.fromRawJson(Map<String, dynamic> jsonData) {
    return QuizTopicModel(
      title: jsonData['title'],
      subtitle: jsonData['subtitle'],
      icon: jsonData['icon'],
      urlImage: jsonData['urlImage'],
      gradient: jsonData['gradient'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "subtitle": subtitle,
      "icon": icon,
      "urlImage": urlImage,
      "gradient": gradient,
    };
  }
}
