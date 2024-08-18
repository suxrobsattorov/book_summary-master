import 'dart:convert';

import 'package:flutter/material.dart';

class Book {
  String id;
  final String title;
  final String summary;
  final String author;
  double rate;
  DateTime publishedDate;
  List<String> facts;

  bool isFavorite;
  Book({
    required this.id,
    required this.title,
    required this.summary,
    required this.author,
    required this.rate,
    required this.publishedDate,
    required this.facts,
    this.isFavorite = false,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    // result.addAll({'id': id});
    result.addAll({'title': title});
    result.addAll({'summary': summary});
    result.addAll({'author': author});
    result.addAll({'rate': rate});
    result.addAll({'publishedDate': publishedDate.toString()});
    result.addAll({'facts': facts});
    result.addAll({'isFavorite': isFavorite});

    return result;
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id'] ?? UniqueKey().toString(),
      title: map['title'] ?? '',
      summary: map['summary'] ?? '',
      author: map['author'] ?? '',
      rate: map['rate']?.toDouble() ?? 5.0,
      publishedDate: DateTime.parse(map['publishedDate']),
      facts: List<String>.from(map['facts']),
      isFavorite: map['isFavorite'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Book.fromJson(String source) => Book.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Book(id: $id, title: $title, summary: $summary, author: $author, rate: $rate, publishedDate: $publishedDate, isFavorite: $isFavorite, facts: $facts)';
  }
}
