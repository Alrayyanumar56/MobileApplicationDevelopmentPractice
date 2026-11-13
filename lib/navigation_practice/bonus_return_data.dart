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
  String selectedName = 'No name selected';

  Future<void> pickName() async {
    final String? result = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (context) => const SelectionPage()),
    );
    // After an await, check mounted before using context/setState again.
    if (!mounted) return;
    if (result != null) {
      setState(() => selectedName = result);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You selected $result')),
      );
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Return Data')),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(selectedName, style: const TextStyle(fontSize: 24)),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: pickName,
            child: const Text('Select a Name'),
          ),
        ],
      ),
    ),
  );
}

// Practice Task 8: the user picks a name and it is returned to HomePage.
class SelectionPage extends StatelessWidget {
  const SelectionPage({super.key});
  static const List<String> names = ['Ayesha', 'Bilal', 'Fatima', 'Hamza'];

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Select a Name')),
    body: ListView(
      children: [
        for (final name in names)
          ListTile(
            leading: const Icon(Icons.person),
            title: Text(name),
            onTap: () => Navigator.pop(context, name),
          ),
      ],
    ),
  );
}
