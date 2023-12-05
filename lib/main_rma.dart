import 'package:flutter/material.dart';
import 'package:flutter_project/entities/rma.dart';
import 'package:flutter_project/screens/add_rma_form.dart';
import 'package:flutter_project/widgets/rma_list_item.dart';

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
  final rmaList = [
    Rma(
      status: RmaStatus.inProcress,
      customerId: 23,
      orderId: 23,
      description: 'Bin hingefallen :(',
      createdAt: DateTime.now().subtract(const Duration(days: 1)).toUtc(),
      id: 2,
    ),
    Rma(
      status: RmaStatus.payed,
      customerId: 42,
      orderId: 42,
      description: 'Postbote ist ausgerutscht',
      createdAt: DateTime.now().subtract(const Duration(days: 5)).toUtc(),
      id: 3,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.separated(
        itemCount: rmaList.length,
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemBuilder: (context, index) => RmaListItem(
          rma: rmaList[index],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final rma = await Navigator.push<Rma>(
            context,
            MaterialPageRoute(
              builder: (context) => const AddRmaForm(),
            ),
          );

          if (rma == null) {
            return;
          }

          setState(() {
            rmaList.add(rma);
            rmaList.sort(
              (a, b) => a.createdAt.isAfter(b.createdAt) ? -1 : 1,
            );
          });
        },
        tooltip: 'Add new customer',
        child: const Icon(Icons.add_home_work_outlined),
      ),
    );
  }
}
