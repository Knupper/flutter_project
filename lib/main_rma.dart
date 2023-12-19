import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_project/entities/rma.dart';
import 'package:flutter_project/screens/add_rma_form.dart';
import 'package:flutter_project/widgets/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sqlite3/sqlite3.dart' as sqlite;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  const storage = FlutterSecureStorage();
  final db = sqlite.sqlite3.openInMemory();

  db.execute('''
    CREATE TABLE artists (
      id INTEGER NOT NULL PRIMARY KEY,
      name TEXT NOT NULL
    );
  ''');

  final stmt = db.prepare('INSERT INTO artists (name) VALUES (?)');
  stmt
    ..execute(['The Beatles'])
    ..execute(['Led Zeppelin'])
    ..execute(['The Who'])
    ..execute(['Nirvana']);

  stmt.dispose();

  final sqlite.ResultSet resultSet = db.select('SELECT * FROM artists WHERE name LIKE ?', ['The %']);

  for (final row in resultSet) {
    debugPrint('Artist[id: ${row['id']}, name: ${row['name']}]');
  }

  final elements = await storage.readAll();

  debugPrint(jsonEncode(elements));

  runApp(
    EasyLocalization(
      path: 'assets/translations',
      useOnlyLangCode: true,
      startLocale: const Locale('de', 'DE'),
      supportedLocales: const [
        Locale('de', 'DE'),
        Locale('en', 'US'),
      ],
      fallbackLocale: const Locale('en', 'US'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(seedColor: Colors.greenAccent);

    return MaterialApp(
      title: 'Flutter Demo',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        colorScheme: colorScheme,
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: colorScheme.inversePrimary,
        ),
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
    return AdaptiveScaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      destinations: const [
        NavigationDestination(icon: Icon(Icons.abc_outlined), label: 'abc'),
        NavigationDestination(icon: Icon(Icons.work), label: 'cde'),
        NavigationDestination(icon: Icon(Icons.pageview), label: 'bcd'),
      ],
      onSelectedIndexChange: (index) => debugPrint('index: $index'),
      useDrawer: true,
      largeSecondaryBody: (context) => const Placeholder(),
      body: (context) => Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: rmaList.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) => RmaListItem(
                rma: rmaList[index],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Spacer(),
              TextButton(
                onPressed: () => debugPrint('prev'),
                child: const Text('Previous'),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () => debugPrint('nexz'),
                child: const Text('next'),
              ),
              const Spacer(),
            ],
          )
        ],
      ),
      trailingNavRail: FloatingActionButton(
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
