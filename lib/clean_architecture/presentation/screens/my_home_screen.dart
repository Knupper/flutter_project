import 'package:flutter/material.dart';
import 'package:flutter_project/clean_architecture/presentation/pages/advice_page.dart';

class MyHomeScreen extends StatelessWidget {
  const MyHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clean Architecture'),
      ),
      body: const Center(
        child: AdvicePageProvider(),
      ),
    );
  }
}
