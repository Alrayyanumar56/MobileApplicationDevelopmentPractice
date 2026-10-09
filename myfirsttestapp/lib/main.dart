import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

// ---------------------------------------------------------------------------
// MODELS
// ---------------------------------------------------------------------------
class FoodItem {
  final String name;
  final double price;
  final String description;
  final String emoji; // stand-in for a real image
  final Color color; // background tint of the image area
  final List<String> tags;
  final String calories;
  final String prepTime;

  const FoodItem({
    required this.name,
    required this.price,
    required this.description,
    required this.emoji,
    required this.color,
    this.tags = const [],
    this.calories = '',
    this.prepTime = '',
  });
}

class MenuCategory {
  final String name;
  final IconData icon;
  final List<FoodItem> items;

  const MenuCategory({
    required this.name,
    required this.icon,
    required this.items,
  });
}

// ---------------------------------------------------------------------------
// DUMMY DATA
// ---------------------------------------------------------------------------
const List<MenuCategory> menuData = [
  MenuCategory(
    name: 'Starters',
    icon: Icons.tapas,
    items: [
      FoodItem(
        name: 'Crispy Spring Rolls',
        price: 6.50,
        description:
        'Golden fried rolls stuffed with fresh vegetables and glass noodles, served with sweet chili dip.',
        emoji: '🥟',
        color: Color(0xFFB85C38),
        tags: ['Veg', 'Crispy'],
        calories: '240 kcal',
        prepTime: '10 min',
      ),
      FoodItem(
        name: 'Garlic Bread',
        price: 4.99,
        description:
        'Toasted baguette brushed with roasted garlic butter and fresh parsley.',
        emoji: '🥖',
        color: Color(0xFFC49A3C),
        tags: ['Veg'],
        calories: '310 kcal',
        prepTime: '8 min',
      ),
      FoodItem(
        name: 'Tomato Soup',
        price: 5.25,
        description:
        'Slow-cooked tomato and basil soup finished with a swirl of cream.',
        emoji: '🍅',
        color: Color(0xFFB23A3A),
        tags: ['Veg', 'Warm'],
        calories: '180 kcal',
        prepTime: '7 min',
      ),
    ],
  ),
  MenuCategory(
    name: 'Main Course',
    icon: Icons.dinner_dining,
    items: [
      FoodItem(
        name: 'Chicken Karahi',
        price: 14.99,
        description:
        'Tender chicken cooked in a wok with tomatoes, green chilies, ginger and fresh coriander.',
        emoji: '🍛',
        color: Color(0xFFB5532A),
        tags: ['Spicy', 'Bestseller'],
        calories: '520 kcal',
        prepTime: '25 min',
      ),
      FoodItem(
        name: 'Beef Burger',
        price: 11.50,
        description:
        'Juicy beef patty, melted cheddar, lettuce, pickles and house sauce in a toasted brioche bun.',
        emoji: '🍔',
        color: Color(0xFF8A5A3B),
        tags: ['Popular'],
        calories: '780 kcal',
        prepTime: '15 min',
      ),
      FoodItem(
        name: 'Margherita Pizza',
        price: 12.00,
        description:
        'Wood-fired crust, San Marzano tomato sauce, fresh mozzarella and basil.',
        emoji: '🍕',
        color: Color(0xFFA6472F),
        tags: ['Veg'],
        calories: '690 kcal',
        prepTime: '18 min',
      ),
      FoodItem(
        name: 'Grilled Salmon',
        price: 18.75,
        description:
        'Atlantic salmon fillet grilled with lemon butter, served with seasonal vegetables.',
        emoji: '🐟',
        color: Color(0xFF3C7A8A),
        tags: ['Healthy', 'Gluten free'],
        calories: '430 kcal',
        prepTime: '20 min',
      ),
    ],
  ),
  MenuCategory(
    name: 'Desserts',
    icon: Icons.cake,
    items: [
      FoodItem(
        name: 'Chocolate Lava Cake',
        price: 7.99,
        description:
        'Warm chocolate cake with a molten center, served with vanilla ice cream.',
        emoji: '🍫',
        color: Color(0xFF6B3F2E),
        tags: ['Sweet', 'Bestseller'],
        calories: '450 kcal',
        prepTime: '12 min',
      ),
      FoodItem(
        name: 'Gulab Jamun',
        price: 4.50,
        description:
        'Soft milk dumplings soaked in rose and cardamom sugar syrup.',
        emoji: '🍮',
        color: Color(0xFFA0522D),
        tags: ['Sweet', 'Veg'],
        calories: '300 kcal',
        prepTime: '5 min',
      ),
    ],
  ),
  MenuCategory(
    name: 'Drinks',
    icon: Icons.local_cafe,
    items: [
      FoodItem(
        name: 'Mango Lassi',
        price: 3.99,
        description: 'Chilled yogurt drink blended with ripe mango pulp.',
        emoji: '🥭',
        color: Color(0xFFC98A1B),
        tags: ['Cold', 'Veg'],
        calories: '210 kcal',
        prepTime: '3 min',
      ),
      FoodItem(
        name: 'Iced Coffee',
        price: 4.25,
        description: 'Cold-brewed coffee over ice with a splash of milk.',
        emoji: '☕',
        color: Color(0xFF5E4636),
        tags: ['Cold'],
        calories: '90 kcal',
        prepTime: '3 min',
      ),
    ],
  ),
];

// ---------------------------------------------------------------------------
// APP ROOT
// ---------------------------------------------------------------------------
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant Menu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF7043),
          brightness: Brightness.dark,
        ),
      ),
      home: const MenuPage(),
    );
  }
}

// ---------------------------------------------------------------------------
// MENU PAGE (owns the state: which food is selected, cart count)
// ---------------------------------------------------------------------------
class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  FoodItem? selectedFood;
  int cartCount = 0;

  void selectFood(FoodItem food) => setState(() => selectedFood = food);

  void addToCart(FoodItem food) {
    setState(() => cartCount++);
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${food.name} added to your order'),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        // Wide screen (desktop/tablet) => sidebar always visible.
        // Narrow screen (phone) => sidebar lives inside a Drawer.
        final isWide = constraints.maxWidth >= 800;

        final sidebar = CategorySidebar(
          selected: selectedFood,
          onSelect: (food) {
            selectFood(food);
            if (!isWide) Navigator.of(context).pop(); // close the drawer
          },
        );

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Saffron & Spice',
              style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
            ),
            centerTitle: false,
            backgroundColor: scheme.surfaceContainer,
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {},
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Badge(
                  isLabelVisible: cartCount > 0,
                  label: Text('$cartCount'),
                  child: IconButton(
                    icon: const Icon(Icons.shopping_bag_outlined),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
          drawer: isWide ? null : Drawer(child: SafeArea(child: sidebar)),
          body: Row(
            children: [
              if (isWide)
                SizedBox(
                  width: 320,
                  child: ColoredBox(
                    color: scheme.surfaceContainerLow,
                    child: sidebar,
                  ),
                ),
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: selectedFood == null
                      ? const EmptyState(key: ValueKey('empty'))
                      : FoodDetailPanel(
                    // The key makes Flutter treat each food as a NEW
                    // widget, which is what triggers the fade animation.
                    key: ValueKey(selectedFood!.name),
                    food: selectedFood!,
                    onAdd: () => addToCart(selectedFood!),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// LEFT SIDE: categories that expand into foods
// ---------------------------------------------------------------------------
class CategorySidebar extends StatelessWidget {
  final FoodItem? selected;
  final ValueChanged<FoodItem> onSelect;

  const CategorySidebar({
    super.key,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 16),
          child: Text(
            'MENU',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: scheme.primary,
              letterSpacing: 3,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        for (final category in menuData)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: ColoredBox(
                color: scheme.surfaceContainerHigh,
                child: ExpansionTile(
                  initiallyExpanded: category == menuData.first,
                  shape: const Border(), // removes default divider lines
                  collapsedShape: const Border(),
                  leading: Icon(category.icon, color: scheme.primary),
                  title: Text(
                    category.name,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text('${category.items.length} items'),
                  childrenPadding: const EdgeInsets.only(bottom: 8),
                  children: [
                    for (final food in category.items)
                      ListTile(
                        dense: true,
                        selected: selected == food,
                        selectedTileColor:
                        scheme.primary.withValues(alpha: 0.15),
                        contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20),
                        leading:
                        Text(food.emoji, style: const TextStyle(fontSize: 22)),
                        title: Text(food.name),
                        trailing: Text('\$${food.price.toStringAsFixed(2)}'),
                        onTap: () => onSelect(food),
                      ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// RIGHT SIDE: empty state
// ---------------------------------------------------------------------------
class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.restaurant_menu,
              size: 80, color: scheme.primary.withValues(alpha: 0.6)),
          const SizedBox(height: 16),
          Text('Select a dish',
              style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          Text(
            'Pick something from the menu to see the details',
            style: TextStyle(color: scheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// RIGHT SIDE: food details
// ---------------------------------------------------------------------------
class FoodDetailPanel extends StatelessWidget {
  final FoodItem food;
  final VoidCallback onAdd;

  const FoodDetailPanel({super.key, required this.food, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---- IMAGE AREA ----
              // To use a real photo, replace the child of this Container with:
              // Image.network('https://...', fit: BoxFit.cover)
              // or Image.asset('assets/images/pizza.jpg', fit: BoxFit.cover)
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Container(
                  height: 280,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        food.color,
                        food.color.withValues(alpha: 0.5),
                      ],
                    ),
                  ),
                  child: Center(
                    child: Text(food.emoji,
                        style: const TextStyle(fontSize: 120)),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // ---- NAME + PRICE ----
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      food.name,
                      style: text.headlineMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    '\$${food.price.toStringAsFixed(2)}',
                    style: text.headlineMedium?.copyWith(
                      color: scheme.primary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // ---- TAGS ----
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final tag in food.tags)
                    Chip(
                      label: Text(tag),
                      side: BorderSide.none,
                      backgroundColor:
                      scheme.primary.withValues(alpha: 0.15),
                    ),
                ],
              ),
              const SizedBox(height: 16),

              // ---- DESCRIPTION ----
              Text(
                food.description,
                style: text.bodyLarge?.copyWith(
                  color: scheme.onSurfaceVariant,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),

              // ---- INFO CARDS ----
              Row(
                children: [
                  Expanded(
                    child: _InfoCard(
                        icon: Icons.local_fire_department,
                        label: 'Calories',
                        value: food.calories),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _InfoCard(
                        icon: Icons.timer_outlined,
                        label: 'Prep time',
                        value: food.prepTime),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // ---- BUTTON ----
              SizedBox(
                width: double.infinity,
                height: 56,
                child: FilledButton.icon(
                  onPressed: onAdd,
                  icon: const Icon(Icons.add_shopping_cart),
                  label: const Text('Add to order',
                      style: TextStyle(fontSize: 16)),
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: scheme.primary),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: TextStyle(
                      color: scheme.onSurfaceVariant, fontSize: 12)),
              Text(value,
                  style: const TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
        ],
      ),
    );
  }
}