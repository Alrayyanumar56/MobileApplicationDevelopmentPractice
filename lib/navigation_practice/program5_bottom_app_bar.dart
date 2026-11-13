import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => const MaterialApp(
    debugShowCheckedModeBanner: false, home: BottomBarPage());
}

class BottomBarPage extends StatelessWidget {
  const BottomBarPage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Bottom App Bar')),
    body: const Center(child: Text('Welcome to the App')),
    bottomNavigationBar: BottomAppBar(
      shape: const CircularNotchedRectangle(),
      child: SizedBox(
        height: 65,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.home)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.favorite)),
            const SizedBox(width: 45),
          ],
        ),
      ),
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    floatingActionButton: FloatingActionButton(
      // Practice Task 5: a different SnackBar message.
      onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('New item added to your list!'))),
      child: const Icon(Icons.add),
    ),
  );
}
