import 'package:flutter/material.dart';
import 'package:money_book_2021/app_drawer.dart';
import 'package:money_book_2021/db_helper.dart';
import 'package:money_book_2021/edit_page.dart';
import 'package:money_book_2021/extensions.dart';
import 'package:money_book_2021/main.dart';
import 'package:money_book_2021/records.dart';

/// ホーム画面
class HomePage extends StatefulWidget {
  /// コンストラクタ
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(appTitle)),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: FutureBuilder(
                future: DbHelper.selectRecords(),
                builder: (
                  BuildContext context,
                  AsyncSnapshot<List<Records>> snapshot,
                ) {
                  // データが準備できていない場合はプログレスアイコンを表示
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ListView.builder(
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (context, int index) {
                      final record = snapshot.data![index];
                      return ListTile(
                        leading: Icon(record.category.toIcon),
                        title: Text('${record.title}'),
                        subtitle: Text('${record.date.toYmd} ${record.price.toYen}'),
                        onTap: () async {
                          // 編集画面に遷移
                          await Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => EditPage(record)),
                          );

                          // 一覧を更新
                          setState(() {});
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      // 新規追加ボタン
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: '新規追加',
        onPressed: () async {
          // 編集画面に遷移
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => EditPage(null)),
          );

          // 一覧を更新
          setState(() {});
        },
      ),
    );
  }
}
