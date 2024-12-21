import 'package:equatable/equatable.dart';
import '../../../models/comment.dart';

abstract class CommentEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchComments extends CommentEvent {
  final String keyword;

  FetchComments([this.keyword = '']);

  @override
  List<Object?> get props => [keyword];
}

class AddComment extends CommentEvent {
  final Comment comment;

  AddComment(this.comment);

  @override
  List<Object?> get props => [comment];
}
