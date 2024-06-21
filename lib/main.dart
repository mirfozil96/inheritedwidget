import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  Color _color = Colors.red;
  bool _isDarkTheme = false;

  void _changeColor(Color newColor) {
    setState(() {
      _color = newColor;
    });
  }

  void _toggleTheme() {
    setState(() {
      _isDarkTheme = !_isDarkTheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ColorProvider(
      color: _color,
      changeColor: _changeColor,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: _color,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: _color,
        ),
        themeMode: _isDarkTheme ? ThemeMode.dark : ThemeMode.light,
        home: HomePage(toggleTheme: _toggleTheme),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final VoidCallback toggleTheme;

  const HomePage({super.key, required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    final colorProvider = ColorProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: toggleTheme,
          ),
        ],
      ),
      body: Center(
        child: Container(
          color: colorProvider!.color,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const FirstPage()),
                  );
                },
                child: const Text('Go to First Page'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SecondPage()),
                  );
                },
                child: const Text('Go to Second Page'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ThirdPage()),
                  );
                },
                child: const Text('Go to Third Page'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorProvider = ColorProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Page'),
      ),
      body: Container(
        color: colorProvider!.color,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  colorProvider.changeColor(Colors.blue);
                },
                child: const Text('Change to Blue'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorProvider = ColorProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Page'),
      ),
      body: Container(
        color: colorProvider!.color,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  colorProvider.changeColor(Colors.green);
                },
                child: const Text('Change to Green'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ThirdPage extends StatelessWidget {
  const ThirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorProvider = ColorProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Third Page'),
      ),
      body: Container(
        color: colorProvider!.color,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  colorProvider.changeColor(Colors.purple);
                },
                child: const Text('Change to Purple'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ColorProvider extends InheritedWidget {
  final Color color;
  final Function(Color) changeColor;

  const ColorProvider({
    super.key,
    required this.color,
    required this.changeColor,
    required super.child,
  });

  static ColorProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ColorProvider>();
  }

  @override
  bool updateShouldNotify(ColorProvider oldWidget) {
    return color != oldWidget.color;
  }
}
