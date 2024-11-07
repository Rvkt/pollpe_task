import 'package:flutter/material.dart';
import 'package:pollpe/core/theme/app_palette.dart';
import 'package:pollpe/widgets/custom_elevated_button.dart';

import '../models/poll.dart';
import 'comments_widget.dart';

class QuizDetailsScreen extends StatefulWidget {
  final Poll poll;
  const QuizDetailsScreen({super.key, required this.poll});

  @override
  State<QuizDetailsScreen> createState() => _QuizDetailsPageState();
}

class _QuizDetailsPageState extends State<QuizDetailsScreen> {


  List<Comment> comments = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void setComments(){
    setState(() {
      comments = widget.poll.comments;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 24,
                  child: Icon(
                    Icons.person,
                    size: 32,
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.poll.createdBy}',
                        style: TextStyle(
                          fontFamily: 'VarelaRound',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text('@${widget.poll.createdBy}'),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppPalette.accentColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Text(
                    'Follow', // Replace with dynamic question count
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            Card(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      '${widget.poll.title}',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily: 'VarelaRound',
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Image.asset(
                    'assets/images/rb_30762.png',
                    height: 160,
                  ),
                  Card(
                    shadowColor: AppPalette.transparentColor,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  '${widget.poll.questions.length}',
                                  style: TextStyle(
                                    fontFamily: 'VarelaRound',
                                    fontSize: 16,
                                    color: AppPalette.accentColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text('Questions'),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  '${widget.poll.numberOfVotes}',
                                  style: TextStyle(
                                    fontFamily: 'VarelaRound',
                                    fontSize: 16,
                                    color: AppPalette.accentColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text('Votes'),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  '${widget.poll.createdOn}',
                                  style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontFamily: 'VarelaRound',
                                    fontSize: 16,
                                    color: AppPalette.accentColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text('Created Date'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: CommentsScreen(poll: widget.poll,),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: CustomElevatedButton(
                    title: 'Play Solo',
                    onPressed: () {},
                    backgroundColor: AppPalette.accentColor.withOpacity(0.5),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: CustomElevatedButton(
                    title: 'Play with Friends',
                    onPressed: () {},
                    backgroundColor: Colors.deepPurple,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
