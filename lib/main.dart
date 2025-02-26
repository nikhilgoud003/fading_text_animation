import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fading Text Animation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      home: const FadingTextAnimation(),
    );
  }
}

class FadingTextAnimation extends StatefulWidget {
  const FadingTextAnimation({super.key});

  @override
  _FadingTextAnimationState createState() => _FadingTextAnimationState();
}

class _FadingTextAnimationState extends State<FadingTextAnimation> {
  bool _isVisible = true;
  bool _isDarkMode = false;
  bool _showFrame = false;
  Color _textColor = Colors.black;
  final PageController _pageController = PageController();

  void toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  void toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
      _textColor = _isDarkMode ? Colors.white : Colors.black;
    });
  }

  void showColorPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              onColorChanged: (Color color) {
                setState(() {
                  _textColor = color;
                });
              },
              pickerColor: _textColor,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Done'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _isDarkMode
          ? ThemeData.dark().copyWith(
              primaryColor: Colors.blueGrey,
            )
          : ThemeData.light().copyWith(
              primaryColor: Colors.blue,
            ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Fading Text Animation'),
          actions: [
            IconButton(
              icon: Icon(_isDarkMode ? Icons.wb_sunny : Icons.nightlight_round),
              onPressed: toggleTheme,
              tooltip: 'Toggle theme',
            ),
            IconButton(
              icon: const Icon(Icons.color_lens),
              onPressed: showColorPicker,
              tooltip: 'Change text color',
            ),
          ],
        ),
        body: PageView(
          controller: _pageController,
          children: [
            // First Page
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: toggleVisibility,
                    child: AnimatedOpacity(
                      opacity: _isVisible ? 1.0 : 0.0,
                      duration: const Duration(seconds: 1),
                      curve: Curves.easeInOut,
                      child: Text(
                        'Hello, Flutter!',
                        style: TextStyle(
                          fontSize: 24,
                          color: _textColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    margin: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Container(
                          decoration: _showFrame
                              ? BoxDecoration(
                                  border: Border.all(
                                    color: _textColor,
                                    width: 5,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                )
                              : null,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              'https://sec.gsu.edu/files/2021/01/georgia-state-university-1.png',
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Show Frame'),
                            Switch(
                              value: _showFrame,
                              onChanged: (bool value) {
                                setState(() {
                                  _showFrame = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Swipe left to see another animation',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            // Second Page
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: toggleVisibility,
                    child: AnimatedOpacity(
                      opacity: _isVisible ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.bounceInOut,
                      child: TweenAnimationBuilder<double>(
                        tween: Tween<double>(begin: 0, end: 1),
                        duration: const Duration(seconds: 2),
                        builder: (BuildContext context, double value,
                            Widget? child) {
                          return Opacity(
                            opacity: value,
                            child: Text(
                              'Welcome to Flutter Animations!',
                              style: TextStyle(
                                fontSize: 24,
                                color: _textColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: 0, end: 2 * 3.14159),
                    duration: const Duration(seconds: 3),
                    builder:
                        (BuildContext context, double value, Widget? child) {
                      return Transform.rotate(
                        angle: value,
                        child: Container(
                          decoration: _showFrame
                              ? BoxDecoration(
                                  border: Border.all(
                                    color: _textColor,
                                    width: 5,
                                  ),
                                  borderRadius: BorderRadius.circular(50),
                                )
                              : null,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(
                              'https://welcome.gsu.edu/files/2021/08/sm_20180615CPR_Pounce_outside_stock_536-1.jpg',
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Swipe right to go back',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: toggleVisibility,
          tooltip: 'Toggle Visibility',
          child: const Icon(Icons.play_arrow),
        ),
      ),
    );
  }
}
