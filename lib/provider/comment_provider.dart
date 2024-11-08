import 'package:flutter/material.dart';
import '../models/poll.dart';

class CommentProvider with ChangeNotifier {
  List<Comment> _comments = [];

  List<Comment> get comments => _comments;

  void setComments(List<Comment> comments) {
    _comments = comments;
    notifyListeners();
  }

  void addComment(Comment comment) {
    _comments.add(comment);
    notifyListeners();
  }

  List<Comment> getCommentsForPoll(String pollId) {
    return _comments.where((comment) => comment.pollId == pollId).toList();
  }

  void initializeCommentsForPoll(List<Comment> comments) {
    _comments = comments;
    notifyListeners();
  }
}
