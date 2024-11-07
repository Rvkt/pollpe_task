import 'package:flutter/material.dart';
import 'package:pollpe/core/theme/app_palette.dart';
import 'package:provider/provider.dart';

import '../models/poll.dart';
import '../provider/PollProvider.dart'; // Assuming it's used somewhere

class CommentsScreen extends StatefulWidget {
  final Poll poll;

  const CommentsScreen({super.key, required this.poll});

  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final TextEditingController _commentController = TextEditingController();

  void _addComment(Poll updatedPoll) {
    PollProvider provider = Provider.of<PollProvider>(context, listen: false);
    provider.updatePoll(updatedPoll);

    provider.fetchPolls();
  }


  void _showCommentBottomSheet(BuildContext context, Poll poll) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16.0),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 16,
            left: 16,
            right: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 24,
                    child: Icon(Icons.person, size: 32),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    poll.createdBy,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _commentController,
                decoration: const InputDecoration(
                  labelText: 'Enter your comment',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (_commentController.text.isNotEmpty) {
                    Comment newComment = Comment(
                      text: _commentController.text,
                      dateTime: DateTime.now(),
                      user: User(name: poll.createdBy, username: '@${poll.createdBy}'), // Assuming currentUserName is the user
                      pollId: poll.id,
                    );

                    // Add the new comment to the poll's comments list
                    List<Comment> updatedComments = List.from(poll.comments)..add(newComment);

                    // Create the updated poll with the new list of comments
                    Poll updatedPoll = Poll(
                      id: poll.id,
                      title: poll.title,
                      description: poll.description,
                      numberOfVotes: poll.numberOfVotes,
                      questions: poll.questions,
                      createdOn: poll.createdOn,
                      createdBy: poll.createdBy,
                      comments: updatedComments,
                    );
// Call the method to update the poll with the new comment
                    _addComment(updatedPoll);

                    // Clear the comment input and close the bottom sheet
                    _commentController.clear();
                    Navigator.pop(context);
                  }
                },
                child: const Text('Submit Comment'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.poll.comments.length,
              itemBuilder: (context, index) {
                final comment = widget.poll.comments[index];
                return ListTile(
                  leading: const CircleAvatar(
                    radius: 24,
                    child: Icon(Icons.person, size: 32),
                  ),
                  title: Text(
                    comment.user.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(comment.text),
                );
              },
            ),
          ),
          TextButton(
            onPressed: () => _showCommentBottomSheet(context, widget.poll),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.edit,
                  size: 20, // Adjust the size of the icon as needed
                ),
                const SizedBox(width: 8), // Space between icon and text
                Text(
                  '${widget.poll.createdBy}, enter your comment',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
