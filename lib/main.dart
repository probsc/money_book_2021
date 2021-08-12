import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:money_book_2021/home_page.dart';

/// アプリ名
const appTitle = 'お小遣い帳アプリ';

/// エントリポイント
void main() {
  runApp(MyApp());
}

/// お小遣い帳アプリ
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      // MaterialApp で日本語対応をサポート
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      // ロケールは日本を設定
      supportedLocales: [
        const Locale('ja'),
      ],
      home: HomePage(),
    );
  }
}
