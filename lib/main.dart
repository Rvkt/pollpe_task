import 'package:flutter/material.dart';
import 'package:pollpe/provider/PollProvider.dart';
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
    return ChangeNotifierProvider(
      create: (context) => PollProvider(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Poll Pe',
        home: HomeScreen(), // Your HomeScreen where you want to use the provider
      ),
    );
  }
}
