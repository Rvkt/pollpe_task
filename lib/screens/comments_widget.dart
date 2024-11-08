import 'package:flutter/material.dart';
import 'package:pollpe/constants/app_constants.dart';
import 'package:pollpe/core/theme/app_palette.dart';
import 'package:provider/provider.dart';

import '../models/poll.dart';
import '../provider/PollProvider.dart';
import '../provider/comment_provider.dart';

class CommentsScreen extends StatefulWidget {
  final Poll poll;

  const CommentsScreen({super.key, required this.poll});

  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final commentProvider = Provider.of<CommentProvider>(context, listen: false);
      commentProvider.initializeCommentsForPoll(widget.poll.comments);
    });
  }

  void _addComment(Poll updatedPoll) {
    PollProvider provider = Provider.of<PollProvider>(context, listen: false);
    provider.updatePoll(updatedPoll);
  }

  void _showCommentBottomSheet(BuildContext context, Poll poll) {
    ScreenUtil.init(context);
    double width = ScreenUtil.screenWidth;
    double height = ScreenUtil.screenHeight;
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
          child: SizedBox(
            height: height * 0.6,
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
    return Column(
      children: [
        Consumer<CommentProvider>(
          builder: (context, provider, child) {
            List<Comment> comments = provider.getCommentsForPoll(widget.poll.id);
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: comments.length,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) {
                final comment = comments[index];
                return Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset(
                            'assets/images/avatar.png',
                            height: 32,
                          ),
                        ),
                        const SizedBox(width: 16),
                        SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                comment.user.name,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                comment.text,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              _showCommentBottomSheet(context, widget.poll);
            },
            child: const Text(
              'Comment',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
