// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:task_management/screens/login_screen.dart'; // Imports Material Design widgets.
// For navigation back to Login.

// HomeScreen is a StatefulWidget because it will manage a list of tasks that can change.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // A simple list to hold our tasks. In a real app, this would come from a database.
  final List<String> _tasks = [
    'Complete Flutter app UI',
    'Add Firebase authentication',
    'Implement task creation',
    'Set up task completion toggle',
    'Design task detail screen',
    'Test on Android emulator',
    'Test on iOS simulator',
    'Deploy to production',
  ];

  // Controller for the new task input field in the dialog.
  final TextEditingController _newTaskController = TextEditingController();

  // Function to show a dialog for adding a new task.
  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('Add New Task', style: TextStyle(color: Color(0xFF821FDA))), // Dark purple title
          content: TextField(
            controller: _newTaskController,
            decoration: InputDecoration(
              hintText: 'Enter task description',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFFCEA9EC)), // Lighter purple border
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFF821FDA), width: 2), // Darker purple focus border
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
              onPressed: () {
                _newTaskController.clear(); // Clear text field on cancel.
                Navigator.of(context).pop(); // Close the dialog.
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF821FDA), // Dark purple button.
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text('Add', style: TextStyle(color: Colors.white)),
              onPressed: () {
                if (_newTaskController.text.isNotEmpty) {
                  setState(() {
                    _tasks.add(_newTaskController.text); // Add the new task to the list.
                  });
                  _newTaskController.clear(); // Clear the text field.
                  Navigator.of(context).pop(); // Close the dialog.
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tasks', style: TextStyle(color: Colors.white)), // Updated title.
        backgroundColor: const Color(0xFF821FDA), // Dark purple background for app bar.
        automaticallyImplyLeading: false, // Hides the back button.
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white), // Logout icon.
            onPressed: () {
              // On logout, navigate back to the LoginScreen.
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
                    (route) => false, // Removes all previous routes.
              );
            },
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF821FDA), // Dark purple
              Color(0xFFCEA9EC), // Lighter purple
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: _tasks.isEmpty
            ? const Center(
          child: Text(
            'No tasks yet! Add one using the + button.',
            style: TextStyle(color: Colors.white, fontSize: 18),
            textAlign: TextAlign.center,
          ),
        )
            : ListView.builder(
          // ListView.builder is efficient for long lists.
          padding: const EdgeInsets.all(16.0),
          itemCount: _tasks.length,
          itemBuilder: (context, index) {
            // Card to display each task, with rounded corners and shadow.
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 5,
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                title: Text(
                  _tasks[index],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF821FDA), // Dark purple text for task.
                  ),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.redAccent), // Delete icon.
                  onPressed: () {
                    setState(() {
                      _tasks.removeAt(index); // Remove task when delete is pressed.
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Task deleted!'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  },
                ),
                onTap: () {
                  // Optional: Implement task details view or completion toggle here.
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Tapped on: ${_tasks[index]}'),
                      backgroundColor: Colors.blueAccent,
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog, // Calls the function to show add task dialog.
        backgroundColor: const Color(0xFFF0E4FA), // Light purple background for the button.
        foregroundColor: const Color(0xFF821FDA), // Dark purple icon color.
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30), // Rounded shape.
        ),
        elevation: 8, // Adds shadow.
        child: const Icon(Icons.add, size: 30), // Add icon.
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat, // Positions the button.
    );
  }
}
