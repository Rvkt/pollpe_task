import 'package:flutter/material.dart';
import 'package:pollpe/constants/app_constants.dart';
import 'package:pollpe/core/theme/app_palette.dart';
import 'package:pollpe/screens/quiz_details_screen.dart';

import '../models/poll.dart';

class QuizCardWidget extends StatefulWidget {
  final Poll poll;

  const QuizCardWidget({
    super.key,
    required this.poll,
  });

  @override
  State<QuizCardWidget> createState() => _QuizCardWidgetState();
}

class _QuizCardWidgetState extends State<QuizCardWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    double width = ScreenUtil.screenWidth;
    double height = ScreenUtil.screenHeight;
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QuizDetailsScreen(
              poll: widget.poll,
            ),
          ),
        );
      },
      child: Card(
        color: AppPalette.secondaryColor,
        margin: const EdgeInsets.only(left: 16),
        clipBehavior: Clip.hardEdge,
        child: SizedBox(
          width: width * 0.6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: height * 0.2,
                color: Colors.white,
                child: Stack(
                  alignment: Alignment.bottomRight, // Align items to the top center of the container
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/images/rb_30762.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: height * 0.15,
                      right: 24,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppPalette.accentColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${widget.poll.questions.length} Qs', // Replace with dynamic question count
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.poll.title,
                      style: const TextStyle(
                        fontFamily: 'VarelaRound',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 12,
                          child: Icon(
                            Icons.person,
                            size: 16,
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Text(
                          widget.poll.createdBy,
                          style: const TextStyle(
                            fontFamily: 'VarelaRound',
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
