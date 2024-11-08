import 'package:flutter/material.dart';
import 'package:pollpe/core/theme/app_palette.dart';
import 'package:pollpe/widgets/custom_elevated_button.dart';
import 'package:provider/provider.dart';

import '../models/poll.dart';
import '../provider/PollProvider.dart';
import 'comments_widget.dart';

class QuizDetailsScreen extends StatefulWidget {
  final Poll poll;

  const QuizDetailsScreen({super.key, required this.poll});

  @override
  State<QuizDetailsScreen> createState() => _QuizDetailsPageState();
}

class _QuizDetailsPageState extends State<QuizDetailsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getComments();
    });
  }

  void getComments() {
    PollProvider provider = Provider.of<PollProvider>(context, listen: false);
    provider.getCommentsForPoll(widget.poll.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.poll.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              color: Colors.white,
              margin: const EdgeInsets.all(8),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.poll.createdBy,
                            style: const TextStyle(
                              fontFamily: 'VarelaRound',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
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
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Card(
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(
                    height: 240,
                    child: Stack(
                      children: [
                        // Background image
                        Image.asset(
                          'assets/images/rb_30762.png',
                          height: 160,
                          width: double.infinity, // To make the image stretch across the screen width
                          fit: BoxFit.contain, // To ensure the image covers the entire width and height without distortion
                        ),

                        // Card on top of the image
                        Positioned(
                          top: 160, // Adjust the top position as needed to place the card
                          left: 4, // You can adjust the left and right margins
                          right: 4,
                          child: Card(
                            shadowColor: AppPalette.transparentColor,
                            elevation: 8, // You can adjust the elevation to make the card stand out
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          '${widget.poll.questions.length}',
                                          style: const TextStyle(
                                            fontFamily: 'VarelaRound',
                                            fontSize: 16,
                                            color: AppPalette.accentColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        const Text('Questions'),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          '${widget.poll.numberOfVotes}',
                                          style: const TextStyle(
                                            fontFamily: 'VarelaRound',
                                            fontSize: 16,
                                            color: AppPalette.accentColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        const Text('Votes'),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          '${widget.poll.createdOn}',
                                          style: const TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontFamily: 'VarelaRound',
                                            fontSize: 16,
                                            color: AppPalette.accentColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        const Text('Created Date'),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 16),
              color: AppPalette.secondaryColor,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'User Comments',
                      style: TextStyle(
                        fontFamily: 'VarelaRound',
                        fontSize: 16,
                        color: AppPalette.accentColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Divider(
                    endIndent: 24,
                    indent: 24,
                  ),
                  CommentsScreen(
                    poll: widget.poll,
                  ),
                ],
              ),
            ),
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
