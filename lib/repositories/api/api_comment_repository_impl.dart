import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/comment.dart';
import '../contracts/abs_api_comment_repository.dart';

class ApiCommentRepositoryImpl implements AbsApiCommentRepository {
  final String baseUrl;

  ApiCommentRepositoryImpl(this.baseUrl);

  @override
  Future<List<Comment>> getAll([String keyword = '']) async {
    final response = await http.get(Uri.parse('$baseUrl/comments?keyword=$keyword'));
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((e) => Comment.fromMap(e)).toList();
    } else {
      throw Exception('Failed to fetch comments');
    }
  }

  @override
  Future<List<Comment>> getWithPagination([int page = 1, int size = 10, String keyword = '']) async {
    final response = await http.get(Uri.parse('$baseUrl/comments?page=$page&size=$size&keyword=$keyword'));
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((e) => Comment.fromMap(e)).toList();
    } else {
      throw Exception('Failed to fetch comments with pagination');
    }
  }

  @override
  Future<Comment?> getById(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/comments/$id'));
    if (response.statusCode == 200) {
      return Comment.fromMap(json.decode(response.body));
    } else {
      throw Exception('Failed to fetch comment by ID');
    }
  }

  @override
  Future<Comment?> create(Comment newData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/comments'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(newData.toDto()),
    );
    if (response.statusCode == 201) {
      return Comment.fromMap(json.decode(response.body));
    } else {
      throw Exception('Failed to create comment');
    }
  }

  @override
  Future<bool> update(Comment updatedData) async {
    final response = await http.put(
      Uri.parse('$baseUrl/comments/${updatedData.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(updatedData.toDto()),
    );
    return response.statusCode == 200;
  }

  @override
  Future<bool> delete(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/comments/$id'));
    return response.statusCode == 204;
  }
}
