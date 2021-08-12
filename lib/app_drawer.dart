import 'package:flutter/material.dart';
import 'package:money_book_2021/graph_page.dart';
import 'package:money_book_2021/home_page.dart';
import 'package:money_book_2021/main.dart';
import 'package:package_info/package_info.dart';

/// ドロワー
class AppDrawer extends StatelessWidget {
  /// コンストラクタ
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // タイトルテキストのテーマ ※ダークテーマ対応のために動的に取得
    final titleStyle = Theme.of(context).primaryTextTheme.headline6;

    return Container(
      width: 280,
      child: Drawer(
        child: ListView(
          children: [
            // アプリタイトル
            SizedBox(
              height: 80,
              child: DrawerHeader(
                decoration:
                    BoxDecoration(color: Theme.of(context).primaryColor),
                child: Row(
                  children: [
                    Icon(
                      Icons.savings_outlined,
                      color: titleStyle?.color,
                    ),
                    const SizedBox(width: 8),
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
              context,
              '一覧',
              Icons.format_list_bulleted,
              () => HomePage(),
            ),
            // 「グラフ」メニュー
            _getPageMenu(
              context,
              'グラフ',
              Icons.pie_chart_outlined,
              () => GraphPage(),
            ),
            const Divider(color: Colors.black),
            // 「アプリ情報」
            _getMenu(
              'アプリ情報',
              Icons.info_outlined,
              () async {
                var info = await PackageInfo.fromPlatform();
                showAboutDialog(
                  context: context,
                  applicationIcon: const Icon(Icons.savings_outlined),
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
  Widget _getMenu(String label, IconData icon, VoidCallback onTapped) {
    return Container(
      child: ListTile(
        leading: Icon(icon),
        title: Text(label),
        onTap: onTapped,
      ),
    );
  }

  /// ページ遷移ドロワーメニューを返す
  Widget _getPageMenu(BuildContext context, String label, IconData icon,
      ValueGetter<Widget> page) {
    return _getMenu(
      label,
      icon,
      () async => await Navigator.pushReplacement(
        context,
        PageRouteBuilder(pageBuilder: (c, a1, a2) => page()),
      ),
    );
  }
}
