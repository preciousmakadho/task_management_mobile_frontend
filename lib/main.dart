// lib/main.dart

import 'package:flutter/material.dart';

import 'screens/welcome_screen.dart'; // Imports the Material Design library for Flutter UI components.


void main() {
  // The main function is the entry point of any Flutter application.
  runApp(const MyApp()); // Runs our root widget, MyApp.
}

// MyApp is a StatelessWidget, which means its properties are immutable.
// It's the root of our application's widget tree.
class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Constructor for MyApp.

  @override
  Widget build(BuildContext context) {
    // The build method describes the part of the user interface represented by this widget.
    return MaterialApp(
      // MaterialApp is a convenience widget that wraps a number of widgets that are
      // commonly required for Material Design applications.
      title: 'Task Management App', // Updated title for the task management app.
      theme: ThemeData(
        // Defines the visual properties of the widgets in this app.
        primarySwatch: Colors.deepPurple, // Sets the primary color for the app.
        fontFamily: 'Inter', // You can set a custom font here if you have one.
        // For this example, we'll rely on default system fonts or Material's default.
        useMaterial3: true, // Enables Material 3 features if available.
      ),
      debugShowCheckedModeBanner: false, // Hides the debug banner in the corner.
      home: const WelcomeScreen(), // Sets the initial screen of our application to WelcomeScreen.
    );
  }
}
