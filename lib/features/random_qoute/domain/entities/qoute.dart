import 'package:equatable/equatable.dart';

class Qoute extends Equatable {
  final String author;
  final String content;
  final String permalink;
  final int id;
  const Qoute({
    required this.author,
    required this.id,
    required this.content,
    required this.permalink,
  });
  @override
  List<Object?> get props => [author, id, content, permalink];
}
