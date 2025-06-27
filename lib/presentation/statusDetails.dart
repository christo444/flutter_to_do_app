import 'package:flutter/material.dart';
import 'package:to_do_app_1/model/taskmodel.dart';

class Statusdetails extends StatelessWidget {
  final ToDoModel task;

  const Statusdetails({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Details'),
        backgroundColor: Colors.lightBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SizedBox(
          height: 300,
          width: 320,
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Task Name: ${task.taskName}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Task ID: ${task.taskID}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Status: ${task.taskStatus == "0" ? "Not Completed" : "Completed"}',
                    style: TextStyle(
                      fontSize: 16,
                      color: task.taskStatus == "0" ? Colors.red : Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}