import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/app_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          children: [
            ListTile(
              title: const Text('Add a todo'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () => context.goNamed(AppRoute.todos.path),
            ),
            const Divider(
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
