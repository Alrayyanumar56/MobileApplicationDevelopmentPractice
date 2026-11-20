import 'dart:async';
import 'package:flutter/material.dart';
import 'login_screen.dart'; // your existing login screen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Riphah Flutter App',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
    home: const SplashScreen(),
  );
}

// ---------------------------------------------------------------------------
// 1. SPLASH SCREEN: logo fades in and scales up, then opens Home after 3 sec.
// ---------------------------------------------------------------------------
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;
  late final Animation<double> _fade;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _scale = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();

    // After 3 seconds, go to the Home Screen automatically.
    _timer = Timer(const Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Theme.of(context).colorScheme.primary,
    body: Center(
      child: FadeTransition(
        opacity: _fade,
        child: ScaleTransition(
          scale: _scale,
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.school, size: 110, color: Colors.white),
              SizedBox(height: 16),
              Text(
                'Riphah Flutter App',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Shared drawer used by all three screens (easy screen switching).
// ---------------------------------------------------------------------------
class AppDrawer extends StatelessWidget {
  final String current; // 'Home', 'List' or 'About'
  const AppDrawer({super.key, required this.current});

  void _go(BuildContext context, String target, Widget? page) {
    Navigator.pop(context); // close the drawer
    if (target == current) return;
    if (page == null) {
      // Home is the first route, so pop back to it.
      Navigator.popUntil(context, (route) => route.isFirst);
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) => page));
    }
  }

  @override
  Widget build(BuildContext context) => Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        const UserAccountsDrawerHeader(
          accountName: Text('Student'),
          accountEmail: Text('student@riphah.edu.pk'),
          currentAccountPicture: CircleAvatar(
            child: Icon(Icons.person, size: 35),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.home),
          title: const Text('Home'),
          selected: current == 'Home',
          onTap: () => _go(context, 'Home', null),
        ),
        ListTile(
          leading: const Icon(Icons.list),
          title: const Text('List Screen'),
          selected: current == 'List',
          onTap: () => _go(context, 'List', const ListScreen()),
        ),
        ListTile(
          leading: const Icon(Icons.info),
          title: const Text('About Screen'),
          selected: current == 'About',
          onTap: () => _go(context, 'About', const AboutScreen()),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.login),
          title: const Text('Login'),
          onTap: () => _go(context, 'Login', const LoginScreen()),
        ),
      ],
    ),
  );
}

// Menu button that opens the drawer (used on pushed screens, which also
// show a back button that calls Navigator.pop).
class MenuButton extends StatelessWidget {
  const MenuButton({super.key});
  @override
  Widget build(BuildContext context) => IconButton(
    icon: const Icon(Icons.menu),
    tooltip: 'Menu',
    onPressed: () => Scaffold.of(context).openDrawer(),
  );
}

// ---------------------------------------------------------------------------
// 2. HOME SCREEN
// ---------------------------------------------------------------------------
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Home Screen')),
    drawer: const AppDrawer(current: 'Home'),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.home, size: 80),
          const SizedBox(height: 12),
          const Text('Welcome to the Home Screen',
              style: TextStyle(fontSize: 22)),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ListScreen()),
            ),
            icon: const Icon(Icons.list),
            label: const Text('Open List Screen'),
          ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AboutScreen()),
            ),
            icon: const Icon(Icons.info),
            label: const Text('Open About Screen'),
          ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            ),
            icon: const Icon(Icons.login),
            label: const Text('Open Login Screen'),
          ),
        ],
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// 3a. LIST SCREEN: ListView of 12 cities, inside a CustomScrollView with a
//     SliverAppBar (bonus).
// ---------------------------------------------------------------------------
class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  static const List<(String, String)> cities = [
    ('Islamabad', 'Pakistan'),
    ('Lahore', 'Pakistan'),
    ('Karachi', 'Pakistan'),
    ('Peshawar', 'Pakistan'),
    ('Quetta', 'Pakistan'),
    ('Abbottabad', 'Pakistan'),
    ('Dubai', 'UAE'),
    ('Istanbul', 'Turkey'),
    ('London', 'United Kingdom'),
    ('Paris', 'France'),
    ('Tokyo', 'Japan'),
    ('New York', 'USA'),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    drawer: const AppDrawer(current: 'List'),
    body: CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 160,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            tooltip: 'Back',
            onPressed: () => Navigator.pop(context),
          ),
          actions: const [MenuButton()],
          flexibleSpace: const FlexibleSpaceBar(
            title: Text('List Screen'),
            background: Icon(Icons.location_city, size: 90),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
                (context, index) {
              final city = cities[index];
              return ListTile(
                leading: CircleAvatar(child: Text('${index + 1}')),
                title: Text(city.$1),
                subtitle: Text(city.$2),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('You tapped ${city.$1}')),
                ),
              );
            },
            childCount: cities.length,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// 3b. ABOUT SCREEN: GridView with 6 items (icon + caption).
// ---------------------------------------------------------------------------
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  static const List<(IconData, String, Color)> items = [
    (Icons.school, 'Education', Colors.indigo),
    (Icons.computer, 'Computing', Colors.teal),
    (Icons.science, 'Science', Colors.orange),
    (Icons.sports_soccer, 'Sports', Colors.green),
    (Icons.local_library, 'Library', Colors.purple),
    (Icons.groups, 'Community', Colors.red),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('About Screen'),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        tooltip: 'Back',
        onPressed: () => Navigator.pop(context),
      ),
      actions: const [MenuButton()],
    ),
    drawer: const AppDrawer(current: 'About'),
    body: GridView.count(
      crossAxisCount: 2,
      padding: const EdgeInsets.all(12),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      children: [
        for (final item in items)
          Card(
            elevation: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 36,
                  backgroundColor: item.$3,
                  child: Icon(item.$1, size: 38, color: Colors.white),
                ),
                const SizedBox(height: 12),
                Text(item.$2,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
      ],
    ),
  );
}