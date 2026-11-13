import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => const MaterialApp(
    debugShowCheckedModeBanner: false, home: HomePage());
}

// Practice Task 3: an image replaces the icon. Both screens use this same
// widget, so the Hero child matches. If the network image cannot load
// (offline), the original icon is shown instead.
// To use your own picture: add it under assets/, list it in pubspec.yaml,
// and swap Image.network(...) for Image.asset('assets/photo.jpg', ...).
class HeroPhoto extends StatelessWidget {
  final double size;
  const HeroPhoto({super.key, required this.size});
  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: BorderRadius.circular(size / 8),
    child: Image.network(
      'https://picsum.photos/400',
      width: size,
      height: size,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stack) => Icon(
        Icons.format_paint,
        color: Colors.green,
        size: size,
      ),
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Hero Animation')),
    body: Center(
      child: GestureDetector(
        onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => const DetailPage())),
        child: const Hero(
          tag: 'paint-icon', // same tag on both screens
          child: HeroPhoto(size: 80),
        ),
      ),
    ),
  );
}

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Detail Screen')),
    body: const Center(
      child: Hero(
        tag: 'paint-icon', // same tag on both screens
        child: HeroPhoto(size: 220),
      ),
    ),
  );
}
