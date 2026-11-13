import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => const MaterialApp(
    debugShowCheckedModeBanner: false, home: TabsPage());
}

class TabsPage extends StatelessWidget {
  const TabsPage({super.key});
  @override
  Widget build(BuildContext context) => DefaultTabController(
    length: 4, // Practice Task 6: updated from 3 to 4 to match the tab count
    child: Scaffold(
      appBar: AppBar(
        title: const Text('My Tabs'),
        bottom: const TabBar(tabs: [
          Tab(icon: Icon(Icons.cake), text: 'Birthdays'),
          Tab(icon: Icon(Icons.sentiment_satisfied), text: 'Gratitude'),
          Tab(icon: Icon(Icons.access_alarm), text: 'Reminders'),
          Tab(icon: Icon(Icons.person), text: 'Profile'), // Practice Task 6
        ]),
      ),
      body: const TabBarView(children: [
        Center(child: Text('Birthdays Page')),
        Center(child: Text('Gratitude Page')),
        Center(child: Text('Reminders Page')),
        Center(child: Text('Profile Page')), // Practice Task 6
      ]),
    ),
  );
}
