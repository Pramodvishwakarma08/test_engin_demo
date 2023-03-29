// To parse this JSON data, do
//
//     final paperModel = paperModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

PaperModel paperModelFromJson(String str) => PaperModel.fromJson(json.decode(str));

String paperModelToJson(PaperModel data) => json.encode(data.toJson());

class PaperModel {
  PaperModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.instruction,
    required this.description,
    required this.timeSeconds,
    required this.questions,
  });

  String id;
  String title;
  String imageUrl;
  List<Instruction> instruction;
  String description;
  int timeSeconds;
  List<Question> questions;

  factory PaperModel.fromJson(Map<String, dynamic> json) => PaperModel(
    id: json["id"],
    title: json["title"],
    imageUrl: json["image_url"],
    instruction: List<Instruction>.from(json["INSTRUCTION"].map((x) => Instruction.fromJson(x))),
    description: json["Description"],
    timeSeconds: json["time_seconds"],
    questions: List<Question>.from(json["questions"].map((x) => Question.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "image_url": imageUrl,
    "INSTRUCTION": List<dynamic>.from(instruction.map((x) => x.toJson())),
    "Description": description,
    "time_seconds": timeSeconds,
    "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
  };
}

class Instruction {
  Instruction({
    required this.id,
  });

  String id;

  factory Instruction.fromJson(Map<String, dynamic> json) => Instruction(
    id: json["ID"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
  };
}

class Question {
  Question({
    required this.id,
    required this.question,
    required this.answers,
    required this.correctAnswer,
  });

  String id;
  String question;
  List<Answer> answers;
  CorrectAnswer correctAnswer;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    id: json["id"],
    question: json["question"],
    answers: List<Answer>.from(json["answers"].map((x) => Answer.fromJson(x))),
    correctAnswer: correctAnswerValues.map[json["correct_answer"]]!,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "question": question,
    "answers": List<dynamic>.from(answers.map((x) => x.toJson())),
    "correct_answer": correctAnswerValues.reverse[correctAnswer],
  };
}

class Answer {
  Answer({
    required this.identifier,
    required this.answer,
  });

  CorrectAnswer identifier;
  String answer;

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
    identifier: correctAnswerValues.map[json["identifier"]]!,
    answer: json["Answer"],
  );

  Map<String, dynamic> toJson() => {
    "identifier": correctAnswerValues.reverse[identifier],
    "Answer": answer,
  };
}

enum CorrectAnswer { A, B, C, D }

final correctAnswerValues = EnumValues({
  "A": CorrectAnswer.A,
  "B": CorrectAnswer.B,
  "C": CorrectAnswer.C,
  "D": CorrectAnswer.D
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

