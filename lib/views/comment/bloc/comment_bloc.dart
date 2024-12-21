import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../repositories/contracts/abs_api_comment_repository.dart';
import 'comment_event.dart';
import 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final AbsApiCommentRepository commentRepository;

  CommentBloc(this.commentRepository) : super(CommentInitial()) {
    on<FetchComments>((event, emit) async {
      emit(CommentLoading());
      try {
        final comments = await commentRepository.getAll(event.keyword);
        emit(CommentLoaded(comments));
      } catch (e) {
        emit(CommentError(e.toString()));
      }
    });

    on<AddComment>((event, emit) async {
      try {
        await commentRepository.create(event.comment);
        final updatedComments = await commentRepository.getAll();
        emit(CommentLoaded(updatedComments));
      } catch (e) {
        emit(CommentError(e.toString()));
      }
    });
  }
}
