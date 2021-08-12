import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:money_book_2021/home_page.dart';

/// アプリ名
const appTitle = 'おこづかい帳';

/// エントリポイント
void main() {
  // 画面向きを縦に固定
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(MyApp());
}

/// お小遣い帳アプリ
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      // プライマリカラーのみ変更
      theme: new ThemeData.light().copyWith(
        primaryColor: const Color.fromARGB(255, 102, 143, 255),
      ),
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
