import 'package:flutter/material.dart';
import 'package:pollpe/screens/poll_questions_widget.dart';
import 'package:provider/provider.dart';
import '../constants/app_constants.dart';
import '../core/theme/app_palette.dart';
import '../models/poll.dart';
import '../models/question.dart';
import '../provider/PollProvider.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/questions_tile.dart';
import 'add_poll_questions_screen.dart';
import 'home_screen.dart';

class PollCreationForm extends StatefulWidget {
  const PollCreationForm({super.key});

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
      if (questionList.isNotEmpty) {
        Poll newPoll = Poll(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: _titleController.text,
          description: _descriptionController.text,
          keywords: _keywordsController.text.split(',').map((e) => e.trim()).toList(),
          numberOfVotes: 0,
          questions: questionList,
          createdOn: DateTime.now(),
          createdBy: 'Ravi Kant',
          expiryDate: null,
          comments: [],
        );

        if (newPoll.isValid()) {
          _addPoll(newPoll);

          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const HomeScreen()),
            (Route<dynamic> route) => false,
          );

          _showConfirmationDialog();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Poll contains invalid questions/options.")),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please add at least one question to the poll.")),
        );
      }

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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Create a Poll",
          style: TextStyle(color: AppPalette.backgroundColor, fontFamily: 'VarelaRound'),
        ),
        backgroundColor: AppPalette.accentColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
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
                  ],
                ),
              ),
            ),
            Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Questions',
                      style: TextStyle(
                        fontFamily: 'VarelaRound',
                        fontSize: 20,
                        color: AppPalette.accentColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  // Check if questionList has items to display
                  if (questionList.isNotEmpty) ...[
                    QuestionListWidget(
                      questionList: questionList,
                    ),
                  ] else ...[
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text("No questions added yet"),
                    ),
                  ],
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
                                    Question(
                                      questionText: question.questionText,
                                      options: question.options,
                                    ),
                                  );
                                });
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
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
    );
  }
}
