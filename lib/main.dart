import 'package:flutter/material.dart';
import 'package:money_book_2021/home_page.dart';

/// アプリ名
const appTitle = 'お小遣い帳アプリ';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}
