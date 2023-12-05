import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/add_customer_form.dart';
import 'package:flutter_project/customer_list_item.dart';
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
  final customerList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.separated(
        itemCount: customerList.length,
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemBuilder: (context, index) => CustomerListItem(
          customer: customerList[index],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final customer = await Navigator.push<Customer>(
            context,
            MaterialPageRoute(
              builder: (context) => const AddCustomerForm(),
            ),
          );

          if (customer == null) {
            return;
          }

          setState(() {
            customerList.add(customer);
          });
        },
        tooltip: 'Add new customer',
        child: const Icon(Icons.add_home_work_outlined),
      ),
    );
  }
}
