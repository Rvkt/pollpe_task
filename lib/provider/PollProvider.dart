import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/poll.dart';
import '../models/question.dart';

class PollProvider with ChangeNotifier {
  // List of polls
  List<Poll> _polls = [];

  // List of all comments
  List<Comment> _comments = [];



  // Getter for polls
  List<Poll> get polls => _polls;

  // Getter for comments
  List<Comment> get comments => _comments;


  // Setter to replace the entire list of polls
  void setPolls(List<Poll> polls) {
    _polls = polls;
    notifyListeners();
    _savePollsToStorage();
  }

  // Setter to replace the entire list of comments
  void setComments(List<Comment> comments) {
    _comments = comments;
    notifyListeners();
  }

  // Fetch polls from local storage
  Future<void> fetchPolls() async {
    final prefs = await SharedPreferences.getInstance();
    final String? pollsJson = prefs.getString('polls');

    try {
      if (pollsJson != null) {
        // Deserialize the JSON string into a list of Poll objects
        List<dynamic> decodedPolls = json.decode(pollsJson);
        _polls = decodedPolls.map((pollJson) => Poll.fromJson(pollJson)).toList();
      } else {
        // If no polls found, set some default ones
        _polls = [
          Poll(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            title: 'Poll 1',
            description: 'This is poll 1',
            numberOfVotes: 10,
            questions: [
              Question(questionText: 'Question 1', options: ['Option 1', 'Option 2']),
            ],
            createdOn: DateTime.now(),
            createdBy: 'User 1',
            comments: [
              Comment(
                  text: 'First comment',
                  dateTime: DateTime.now(),
                  user: User(
                    name: 'Ravi Kant',
                    username: '@Rvkt',
                  ),
                  pollId: '1'),
            ], // Adding some comments
          ),
        ];
      }
    } catch (e) {
      print("Error fetching polls: $e");
      // If there is an error, you can set default values or handle it accordingly
      _polls = [
        Poll(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: 'Poll 1',
          description: 'This is poll 1',
          numberOfVotes: 10,
          questions: [
            Question(questionText: 'Question 1', options: ['Option 1', 'Option 2']),
          ],
          createdOn: DateTime.now(),
          createdBy: 'User 1',
          comments: [],
        ),
      ];
    }

    // Notify listeners after updating the polls
    notifyListeners();
  }

  // Save the polls list to local storage
  Future<void> _savePollsToStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final String pollsJson = json.encode(_polls.map((poll) => poll.toJson()).toList());
    await prefs.setString('polls', pollsJson);
  }

  // Add a new poll to the list
  void addPoll(Poll poll) {
    _polls.add(poll);
    notifyListeners();
    _savePollsToStorage(); // Save the updated list
  }

  // Update an existing poll in the list
  void updatePoll(Poll updatedPoll) {
    // Find the index of the existing poll by its ID
    int pollIndex = _polls.indexWhere((poll) => poll.id == updatedPoll.id);

    if (pollIndex != -1) {
      // If poll is found, update it
      _polls[pollIndex] = updatedPoll;
      notifyListeners();
      _savePollsToStorage();

      // fetchPolls();
      // getCommentsForPoll(updatedPoll.id);

    } else {
      print("Poll with ID ${updatedPoll.id} not found.");
    }
  }

  // Fetch comments for a specific poll by ID
  List<Comment> getCommentsForPoll(String pollId) {
    final poll = _polls.firstWhere(
      (poll) => poll.id == pollId,
    );
    setComments(poll.comments);
    return poll.comments;
  }
}
