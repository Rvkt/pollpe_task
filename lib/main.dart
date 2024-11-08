import 'package:flutter/material.dart';
import 'package:pollpe/provider/PollProvider.dart';
import 'package:pollpe/provider/comment_provider.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart'; // Assuming you have a HomeScreen widget

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PollProvider()),
        ChangeNotifierProvider(create: (context) => CommentProvider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Poll Pe',
        home: HomeScreen(),
      ),
    );
  }
}

