import 'package:flutter/material.dart';
import 'package:flutter_project/customer_list_item.dart';
import 'package:flutter_project/entities/customer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView.separated(
        itemCount: 1000,
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemBuilder: (context, index) => CustomerListItem(
          customer: Customer(
            id: 0,
            isCompany: index % 2 == 0,
            firstName: 'Claudia',
            lastName: 'Birke',
            address: 'Hinter Mond 23, 22222 Mondland',
            orderIds: [0, 1, 2, 3],
          ),
        ),
      ),
    );
  }
}
