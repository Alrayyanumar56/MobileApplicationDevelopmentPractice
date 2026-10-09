import 'package:flutter/material.dart';
import 'login_screen.dart';

class CVScreen extends StatelessWidget {
  const CVScreen({super.key});

  Widget _section(String title, List<String> items) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            const Divider(),
            ...items.map(
              (item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Text('•  $item', style: const TextStyle(fontSize: 15)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My CV'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const LoginScreen()),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 70,
              backgroundColor: Colors.indigo,
              backgroundImage: AssetImage('assets/me.jpeg'),
            ),
            const SizedBox(height: 12),
            const Text(
              'Rayyan',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Software Engineering Student',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            _section('Contact', [
              'Email: aryanumar56@gmail.com',
              'GitHub: Alrayyanumar56',
              'Location: Rawalpindi, Pakistan',
            ]),
            _section('Education', [
              'BS Software Engineering, Riphah International University',
            ]),
            _section('Skills', [
              'PHP, PostgreSQL, MySQL',
              'Flutter / Dart',
              'WordPress',
              'Web Development',
            ]),
            _section('Experience', [
              'Intern, Pace Technologies (Chakki Mapping Dashboard)',
              'Freelance Developer (Upwork)',
              'Stroming Technologies',
            ]),
          ],
        ),
      ),
    );
  }
}
