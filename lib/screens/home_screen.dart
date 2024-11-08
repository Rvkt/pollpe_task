import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pollpe/constants/app_constants.dart';
import 'package:pollpe/core/theme/app_palette.dart';
import 'package:pollpe/screens/poll_creation_form.dart';
import 'package:pollpe/screens/quiz_details_screen.dart';
import 'package:pollpe/widgets/custom_app_bar_widget.dart';
import 'package:provider/provider.dart';
import '../models/poll.dart';
import '../provider/PollProvider.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/quiz_card_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchPolls();
  }

  void _fetchPolls() {
    PollProvider provider = Provider.of<PollProvider>(context, listen: false);
    provider.fetchPolls();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    double width = ScreenUtil.screenWidth;
    double height = ScreenUtil.screenHeight;

    return Scaffold(
      appBar: const CustomAppBarWidget(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              clipBehavior: Clip.hardEdge,
              child: Container(
                height: height * 0.2,
                width: width,
                decoration: const BoxDecoration(
                  color: AppPalette.secondaryColor,
                ),
                child: Center(
                  child: Image.asset(
                    'assets/images/banner.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Column(
              children: [
                Container(
                  width: width,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Polls',
                          style: TextStyle(
                            fontFamily: 'VarelaRound',
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Row(
                          children: [
                            Text(
                              'View all',
                              style: TextStyle(
                                fontFamily: 'VarelaRound',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Icon(
                              Icons.arrow_forward,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Consumer<PollProvider>(
                  builder: (context, pollProvider, child) {
                    List<Poll> polls = pollProvider.polls;

                    // Check if polls data is available
                    if (polls.isEmpty) {
                      return Center(
                        child: Text(
                          'No Polls Available',
                          style: TextStyle(
                            fontFamily: 'VarelaRound',
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppPalette.accentColor,
                          ),
                        ),
                      );
                    }

                    return SizedBox(
                      height: height * 0.3,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: polls.length,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          Poll poll = polls[index];
                          log(poll.title, name: 'Poll ${poll.id}');
                          return QuizCardWidget(poll: poll);
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const PollCreationForm(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
