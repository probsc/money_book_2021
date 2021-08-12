import 'package:flutter/material.dart';
import 'package:money_book_2021/graph_page.dart';
import 'package:money_book_2021/home_page.dart';
import 'package:money_book_2021/main.dart';
import 'package:package_info/package_info.dart';

/// ドロワー
class AppDrawer extends StatelessWidget {
  /// コンストラクタ
  const AppDrawer({Key? key}) : super(key: key);

  /// アプリアイコン
  static final _appIcon = Image.asset(
    'images/icon.png',
    fit: BoxFit.contain,
    width: 64,
    height: 64,
  );

  @override
  Widget build(BuildContext context) {
    // タイトルテキストのテーマ ※ダークテーマ対応のために動的に取得
    final titleStyle = Theme.of(context).primaryTextTheme.headline6;

    return Container(
      width: 280,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // アプリタイトル
            SizedBox(
              height: 130,
              child: DrawerHeader(
                decoration:
                    BoxDecoration(color: Theme.of(context).primaryColor),
                child: Row(
                  children: [
                    _appIcon,
                    Text(
                      appTitle,
                      style: titleStyle,
                    ),
                  ],
                ),
              ),
            ),
            // 「一覧」メニュー
            _getPageMenu(
              Icons.format_list_bulleted,
              '一覧',
              context,
              () => HomePage(),
            ),
            // 「グラフ」メニュー
            _getPageMenu(
              Icons.pie_chart_outlined,
              'グラフ',
              context,
              () => GraphPage(),
            ),
            const Divider(color: Colors.black),
            // 「アプリ情報」
            _getMenu(
              Icons.info_outlined,
              'アプリ情報',
              () async {
                var info = await PackageInfo.fromPlatform();
                showAboutDialog(
                  context: context,
                  applicationIcon: _appIcon,
                  applicationName: appTitle,
                  applicationVersion: info.version,
                  applicationLegalese: '© 2021 nanairo inc.',
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text(
                          '本アプリは、インターシップでの題材用のお小遣い帳アプリです。登録した使用履歴をグラフ表示できます。',
                          style: TextStyle(fontSize: 14)),
                    )
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  /// ドロワーメニューを返す
  Widget _getMenu(IconData icon, String label, VoidCallback onTapped) {
    return Container(
      child: ListTile(
        leading: Icon(icon),
        title: Text(label),
        onTap: onTapped,
      ),
    );
  }

  /// ページ遷移ドロワーメニューを返す
  Widget _getPageMenu(IconData icon, String label, BuildContext context,
      ValueGetter<Widget> page) {
    return _getMenu(
      icon,
      label,
      () async => await Navigator.pushReplacement(
        context,
        PageRouteBuilder(pageBuilder: (c, a1, a2) => page()),
      ),
    );
  }
}
