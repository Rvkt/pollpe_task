import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../models/poll.dart';
import '../models/question.dart';
import '../widgets/custom_elevated_button.dart';

class AddPollQuestionFormScreen extends StatefulWidget {
  final void Function(Question question) onSubmit;

  const AddPollQuestionFormScreen({super.key, required this.onSubmit});

  @override
  _AddPollQuestionFormState createState() => _AddPollQuestionFormState();
}

class _AddPollQuestionFormState extends State<AddPollQuestionFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _questionController = TextEditingController();
  final List<TextEditingController> _optionControllers = [
    TextEditingController(),
    TextEditingController()
  ];
  final int _maxOptions = 5;
  final int _minOptions = 2;

  void _addOption() {
    if (_optionControllers.length < _maxOptions) {
      setState(() {
        _optionControllers.add(TextEditingController());
      });
    }
  }

  void _removeOption() {
    if (_optionControllers.length > _minOptions) {
      setState(() {
        _optionControllers.removeLast();
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      String questionText = _questionController.text;
      List<String> options = _optionControllers.map((controller) => controller.text).toList();

      Question question = Question(questionText: questionText, options: options);

      if (question.isValid()) {
        widget.onSubmit(question);
        Navigator.of(context).pop();

        _questionController.clear();
        _optionControllers.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please ensure 2-5 options are provided")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Question'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Poll Question', style: TextStyle(fontSize: 18)),
              TextFormField(
                controller: _questionController,
                decoration: const InputDecoration(hintText: 'Enter poll question'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a question';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ..._optionControllers.map((controller) {
                int index = _optionControllers.indexOf(controller);
                return Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller,
                        decoration: InputDecoration(hintText: 'Option ${index + 1}'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an option';
                          }
                          return null;
                        },
                      ),
                    ),
                    if (_optionControllers.length > _minOptions)
                      IconButton(
                        icon: const Icon(Icons.remove_circle),
                        onPressed: () {
                          setState(() {
                            _optionControllers.removeAt(index);
                          });
                        },
                      ),
                  ],
                );
              }),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: SizedBox(
                  width: width,
                  child: Row(
                    children: [
                      CustomElevatedButton(title: 'Add Option', onPressed: _addOption),
                      const SizedBox(width: 16),
                      CustomElevatedButton(
                        title: 'Submit',
                        onPressed: _submitForm,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
