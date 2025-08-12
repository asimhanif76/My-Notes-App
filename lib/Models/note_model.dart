import 'package:cloud_firestore/cloud_firestore.dart';

class NoteModel {
  String title;
  String content;
  DateTime? createdAt;

  NoteModel({
    required this.title,
    required this.content,
    this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'noteName': title,
      'note': content,
      'createdAt': createdAt ?? DateTime.now(),
    };
  }

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      title: json['noteName'],
      content: json['note'],
      createdAt: json["createdAt"] != null
          ? (json["createdAt"] as Timestamp).toDate()
          : null,
    );
  }
}
