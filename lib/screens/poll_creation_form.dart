import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pollpe/widgets/custom_elevated_button.dart';
import 'package:provider/provider.dart';

import '../constants/app_constants.dart';
import '../core/theme/app_palette.dart';
import '../models/poll.dart';
import '../models/question.dart';
import '../provider/PollProvider.dart';
import '../widgets/questions_tile.dart';
import 'add_poll_questions_screen.dart';
import 'home_screen.dart';

class PollCreationForm extends StatefulWidget {
  // final void Function(Poll poll) onSubmit;

  const PollCreationForm({
    super.key,
    // required this.onSubmit,
  });

  @override
  _PollCreationFormState createState() => _PollCreationFormState();
}

class _PollCreationFormState extends State<PollCreationForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _keywordsController = TextEditingController();
  final List<Question> questionList = [];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _keywordsController.dispose();
    super.dispose();
  }

  void _addPoll(Poll poll) {
    PollProvider provider = Provider.of<PollProvider>(context, listen: false);
    provider.addPoll(poll);
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Check if the question list is not empty
      if (questionList.isNotEmpty) {
        // Print the poll details to the console
        Poll newPoll = Poll(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          // Simple unique ID based on current time
          title: _titleController.text,
          description: _descriptionController.text,
          keywords: _keywordsController.text.split(',').map((e) => e.trim()).toList(),
          numberOfVotes: 0,
          // Initial number of votes is 0
          questions: questionList,
          createdOn: DateTime.now(),
          createdBy: 'Ravi Kant',
          // You can dynamically set this (e.g., from logged-in user)
          expiryDate: null, comments: [], // Optional expiry date
        );

        if (newPoll.isValid()) {
          // Poll is valid, pass it to the parent widget
          _addPoll(newPoll);

          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const HomeScreen()),
            (Route<dynamic> route) => false,
          );

          _showConfirmationDialog();
        } else {
          // Show a validation error if the poll is not valid
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Poll contains invalid questions/options."),
            ),
          );
        }
      } else {
        // If no questions are added, show a message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please add at least one question to the poll."),
          ),
        );
      }

      // Clear the controllers
      _titleController.clear();
      _descriptionController.clear();
      _keywordsController.clear();
    }
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Poll Created"),
          content: const Text("Your poll has been successfully created!"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _openSettings() async {
    await openAppSettings();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    double width = ScreenUtil.screenWidth;
    double height = ScreenUtil.screenHeight;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Create a Poll",
          style: TextStyle(color: AppPalette.backgroundColor, fontFamily: 'VarelaRound'),
        ),
        backgroundColor: AppPalette.accentColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Poll Title Field
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: "Poll Title"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a title";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Poll Description Field
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: "Poll Description"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a description";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // // Poll Keywords Field
              // TextFormField(
              //   controller: _keywordsController,
              //   decoration: const InputDecoration(labelText: "Keywords (comma separated)"),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return "Please enter keywords";
              //     }
              //     return null;
              //   },
              // ),
              // const SizedBox(height: 16),

              questionList.isEmpty
                  ? Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'No questions yet. Add your first question!',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )
                  : Expanded(
                      child: QuestionTile(
                        questionList: questionList,
                      ),
                    ),

              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomElevatedButton(
                  title: 'Add Question',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddPollQuestionFormScreen(
                          onSubmit: (question) {
                            setState(() {
                              questionList.add(
                                Question(questionText: question.questionText, options: question.options),
                              );
                            });
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomElevatedButton(title: 'Create Poll', onPressed: _submitForm),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
