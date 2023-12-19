import 'package:flutter/material.dart';
import 'package:flutter_project/screens/add_customer_form.dart';
import 'package:flutter_project/widgets/customer_list_item.dart';
import 'package:flutter_project/entities/customer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(seedColor: Colors.deepOrange);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: colorScheme,
        useMaterial3: true,
        appBarTheme: AppBarTheme(backgroundColor: colorScheme.inversePrimary),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.yellow,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: ThemeMode.light,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double size = 200;
  double slider = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: GestureDetector(
        onDoubleTap: () => debugPrint('onDoubleTap'),
        onTap: () => debugPrint('onTap'),
        onLongPress: () => debugPrint('onLongPress'),
        onLongPressStart: (_) => debugPrint('onLongPressStart'),
        onLongPressEnd: (_) => debugPrint('onLongPressEnd'),
        onScaleUpdate: (details) {
          debugPrint(details.scale.toString());
          final newSize = size * (details.scale / 10);
          if (newSize > 100) {
            setState(() {
              size = newSize;
            });
          }
        },
        onScaleStart: (details) => debugPrint('$details'),
        onScaleEnd: (endDetails) {
          debugPrint(endDetails.scaleVelocity.toString());
          final newSize = size * endDetails.scaleVelocity;
          if (newSize > 100) {}
        },
        child: Column(
          children: [
            InputDatePickerFormField(
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 100)),
            ),
            ElevatedButton(
                onPressed: () => showDatePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 100)),
                    ),
                child: const Text('DatePicker')),
            AnimatedContainer(
              duration: const Duration(microseconds: 1),
              height: size * slider,
              width: size * slider,
              color: Colors.amber,
              child: Slider(
                value: slider,
                min: 1,
                max: 10,
                divisions: 10,
                label: slider.toString(),
                onChanged: (value) {
                  setState(() {
                    slider = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
