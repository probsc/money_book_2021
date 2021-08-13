import 'package:flutter/material.dart';
import 'package:money_book_2021/main.dart';
import 'package:money_book_2021/app_drawer.dart';

/// グラフ画面
class GraphPage extends StatefulWidget {
  /// コンストラクタ
  GraphPage({Key? key}) : super(key: key);

  @override
  _GraphPageState createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(appTitle)),
      drawer: const AppDrawer(),
      body: const Center(
        child: const Text('Graph page.'),
      ),
    );
  }
}
