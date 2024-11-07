class Poll {
  String id; // Unique identifier for each poll
  String title;
  String description;
  List<String>? keywords;
  int numberOfVotes;
  List<Question> questions;
  DateTime createdOn;
  String createdBy;
  DateTime? expiryDate; // Optional expiry date
  List<Comment> comments; // List of comments associated with the poll

  Poll({
    required this.id,
    required this.title,
    required this.description,
    this.keywords,
    required this.numberOfVotes,
    required this.questions,
    required this.createdOn,
    required this.createdBy,
    this.expiryDate, // Optional parameter for expiry date
    required this.comments, // Initialize comments list
  });

  // Add a validation method to ensure the poll is valid
  bool isValid() {
    // Ensure each question has between 2 and 5 options
    for (var question in questions) {
      if (question.options.length < 2 || question.options.length > 5) {
        return false; // Invalid if options count is less than 2 or more than 5
      }
    }
    // Additional validation can be added here, such as checking the title or description
    if (title.isEmpty || description.isEmpty) {
      return false; // Poll title or description should not be empty
    }

    return true; // Poll is valid if all conditions pass
  }

  // Convert a Poll to a Map for JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'keywords': keywords,
      'numberOfVotes': numberOfVotes,
      'questions': questions.map((q) => q.toJson()).toList(),
      'createdOn': createdOn.toIso8601String(),
      'createdBy': createdBy,
      'expiryDate': expiryDate?.toIso8601String(),
      'comments': comments.map((c) => c.toJson()).toList(), // Serialize comments
    };
  }

  // Create a Poll from a Map (JSON)
  factory Poll.fromJson(Map<String, dynamic> json) {
    return Poll(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      keywords: List<String>.from(json['keywords'] ?? []),
      numberOfVotes: json['numberOfVotes'],
      questions: (json['questions'] as List)
          .map((q) => Question.fromJson(q))
          .toList(),
      createdOn: DateTime.parse(json['createdOn']),
      createdBy: json['createdBy'],
      expiryDate: json['expiryDate'] != null
          ? DateTime.parse(json['expiryDate'])
          : null,
      comments: (json['comments'] as List)
          .map((c) => Comment.fromJson(c))
          .toList(), // Deserialize comments
    );
  }
}

class Question {
  String questionText;
  List<String> options;

  Question({
    required this.questionText,
    required this.options,
  });

  // Convert a Question to a Map for JSON
  Map<String, dynamic> toJson() {
    return {
      'questionText': questionText,
      'options': options,
    };
  }

  // Create a Question from a Map (JSON)
  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      questionText: json['questionText'],
      options: List<String>.from(json['options']),
    );
  }

  // Validation for the options length (minimum 2, maximum 5)
  bool isValid() {
    return options.length >= 2 && options.length <= 5;
  }
}

class Comment {
  String text;
  DateTime dateTime;
  User user; // Use the User model here
  String pollId; // Poll ID that this comment is associated with

  Comment({
    required this.text,
    required this.dateTime,
    required this.user,
    required this.pollId,
  });

  // Convert a Comment to a Map for JSON
  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'dateTime': dateTime.toIso8601String(),
      'user': user.toJson(), // Serialize the User object
      'pollId': pollId,
    };
  }

  // Create a Comment from a Map (JSON)
  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      text: json['text'],
      dateTime: DateTime.parse(json['dateTime']),
      user: User.fromJson(json['user']), // Deserialize the User object
      pollId: json['pollId'],
    );
  }
}


class User {
  String name;
  String username;


  User({
    required this.name,
    required this.username,

  });

  // Convert a User to a Map for JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'username': username,

    };
  }

  // Create a User from a Map (JSON)
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      username: json['username'],

    );
  }
}

