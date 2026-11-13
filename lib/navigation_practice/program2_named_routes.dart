import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => const HomePage(),
      '/about': (context) => const SimplePage(title: 'About'),
      '/contact': (context) => const SimplePage(title: 'Contact'),
      // Practice Task 2: new Help route.
      '/help': (context) => const SimplePage(title: 'Help'),
    },
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Home')),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/about'),
            child: const Text('Open About'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/contact'),
            child: const Text('Open Contact'),
          ),
          // Practice Task 2: button that opens the /help route.
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/help'),
            child: const Text('Open Help'),
          ),
        ],
      ),
    ),
  );
}

class SimplePage extends StatelessWidget {
  final String title;
  const SimplePage({super.key, required this.title});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(title)),
    body: Center(child: Text('$title Screen',
        style: const TextStyle(fontSize: 24))),
  );
}
