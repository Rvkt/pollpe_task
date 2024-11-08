import 'package:flutter/material.dart';

import '../models/poll.dart';

class QuestionListWidget extends StatelessWidget {
  final List<Question> questionList;

  const QuestionListWidget({
    super.key,
    required this.questionList,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: questionList.length,
      itemBuilder: (context, index) {
        final question = questionList[index];
        return QuestionCard(question: question);
      },
    );
  }
}

class QuestionCard extends StatelessWidget {
  final Question question;

  const QuestionCard({
    super.key,
    required this.question,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Text(
            question.questionText,
            style: const TextStyle(
              fontSize: 16,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w600,
              color: Colors.black54,
            ),
          ),
          children: [
            OptionsList(options: question.options),
          ],
        ),
      ),
    );
  }
}

class OptionsList extends StatelessWidget {
  final List<String> options;

  const OptionsList({
    super.key,
    required this.options,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      height: 48, // Adjust height as needed
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: options.length,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        itemBuilder: (context, index) {
          final option = options[index];
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  option,
                  style: const TextStyle(
                    color: Colors.blueAccent, // Replace with AppPalette.accentColor if defined
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
