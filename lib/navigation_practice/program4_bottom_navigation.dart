import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => const MaterialApp(
    debugShowCheckedModeBanner: false, home: HomePage());
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  final List<Widget> pages = const [
    SimplePage(title: 'Birthdays'),
    SimplePage(title: 'Gratitude'),
    SimplePage(title: 'Reminders'),
    SimplePage(title: 'Profile'), // Practice Task 4: fourth page
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('My Navigation App')),
    body: pages[currentIndex],
    bottomNavigationBar: BottomNavigationBar(
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (index) => setState(() => currentIndex = index),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.cake), label: 'Birthdays'),
        BottomNavigationBarItem(
          icon: Icon(Icons.sentiment_satisfied), label: 'Gratitude'),
        BottomNavigationBarItem(
          icon: Icon(Icons.access_alarm), label: 'Reminders'),
        // Practice Task 4: fourth item called Profile.
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    ),
  );
}

class SimplePage extends StatelessWidget {
  final String title;
  const SimplePage({super.key, required this.title});
  @override
  Widget build(BuildContext context) => Center(
    child: Text('$title Page', style: const TextStyle(fontSize: 24)));
}
