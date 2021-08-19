import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_book_2021/db_helper.dart';
import 'package:money_book_2021/enums.dart';
import 'package:money_book_2021/extensions.dart';
import 'package:money_book_2021/records.dart';

/// 編集ページ
class EditPage extends StatefulWidget {
  /// 編集対象のレコード
  final Records? record;

  /// コンストラクタ
  EditPage(this.record) : super(key: UniqueKey());

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  /// 「日付」コントローラ
  var _txtDate = TextEditingController();

  /// 「日付」の現在地
  var _date = DateTime.now();

  /// 「分類」一覧
  final _categories = Categories.values
      .map((item) => DropdownMenuItem(
            value: item,
            child: Row(children: [
              SizedBox(width: 12),
              Icon(item.toIcon),
              SizedBox(width: 12),
              Text(item.toText),
            ]),
          ))
      .toList();

  /// 「分類」の現在地
  var _category = Categories.others;

  /// 「タイトル」コントローラ
  var _txtTitle = TextEditingController();

  /// 「タイトル」検証用フォームキー
  final _keyTitle = GlobalKey<FormState>();

  /// 「金額」コントローラ
  var _txtPrice = TextEditingController();

  /// 「金額」検証用フォームキー
  final _keyPrice = GlobalKey<FormState>();

  /// 「タイトル」フォーカスノード
  final FocusNode _focusTitle = FocusNode();

  /// 「金額」フォーカスノード
  final FocusNode _focusPrice = FocusNode();

  @override
  void initState() {
    super.initState();

    _txtDate.text = _date.toYmd;

    // 新規追加ではなく編集？ → 値を画面に反映
    var target = widget.record;
    if (target != null) {
      _date = target.date;
      _txtDate = TextEditingController(text: _date.toYmd);
      _category = target.category;
      _txtTitle = TextEditingController(text: target.title);
      _txtPrice = TextEditingController(text: target.price.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('編集')),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // 日付
              GestureDetector(
                child: AbsorbPointer(
                  child: Container(
                    margin: const EdgeInsets.only(top: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('日付'),
                        TextFormField(
                          controller: _txtDate,
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.date_range)),
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: () async {
                  var selected = await showDatePicker(
                    locale: const Locale('ja'),
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(DateTime.now().year - 3),
                    lastDate: DateTime(DateTime.now().year + 3),
                  );
                  if (selected == null) return;

                  // 呼び元の入力へ通知
                  setState(() {
                    _date = selected;
                    _txtDate.text = _date.toYmd;
                  });
                },
              ),
              // 分類
              Container(
                margin: const EdgeInsets.only(top: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('分類'),
                    DropdownButton(
                      isExpanded: true,
                      items: _categories,
                      value: _category,
                      onChanged: (Categories? value) {
                        setState(() {
                          _category = value ?? Categories.others;
                        });
                      },
                    )
                  ],
                ),
              ),
              // タイトル
              Container(
                margin: const EdgeInsets.only(top: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('タイトル'),
                    Form(
                      key: _keyTitle,
                      child: TextFormField(
                        controller: _txtTitle,
                        decoration: const InputDecoration(
                          hintText: '例）電車代',
                          prefixIcon: Icon(Icons.edit_outlined),
                        ),
                        focusNode: _focusTitle,
                        validator: (value) => value == null || value.isEmpty
                            ? 'タイトルを入力してください'
                            : null,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (term) {
                          _focusTitle.changeFocus(context, _focusPrice);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              // 金額
              Container(
                margin: const EdgeInsets.only(top: 16, bottom: 72),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('金額'),
                    Form(
                      key: _keyPrice,
                      child: TextFormField(
                        controller: _txtPrice,
                        decoration: const InputDecoration(
                          hintText: '例）1000',
                          prefixIcon: Icon(Icons.paid_outlined),
                        ),
                        focusNode: _focusPrice,
                        validator: (value) => value == null || value.isEmpty
                            ? '金額を入力してください'
                            : null,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: false,
                          signed: false,
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Stack(
        children: [
          // 削除ボタン ※新規追加時は非表示
          if (widget.record?.id != null)
            Align(
              alignment: const Alignment(-0.8, 1),
              child: FloatingActionButton(
                backgroundColor: Colors.redAccent,
                child: const Icon(Icons.delete),
                heroTag: 'deleteRecord',
                tooltip: '削除',
                onPressed: () async {
                  // 削除前にダイアログを表示して確認
                  final ret = await showDialog<bool>(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: const Text('削除しますか？'),
                        actions: <Widget>[
                          SimpleDialogOption(
                            child: const Text('キャンセル'),
                            onPressed: () => Navigator.pop(context, false),
                          ),
                          SimpleDialogOption(
                            child: const Text('OK'),
                            onPressed: () => Navigator.pop(context, true),
                          ),
                        ],
                      );
                    },
                  );
                  if (ret == true) {
                    DbHelper.deleteRecord(widget.record?.id ?? 0);
                    Navigator.pop(context);
                  }
                },
              ),
            ),
          // 保存ボタン
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              child: const Icon(Icons.save),
              heroTag: 'saveRecord',
              tooltip: '保存',
              onPressed: () {
                // 入力チェック
                var isValid = _keyTitle.currentState?.validate() ?? false;
                isValid &= _keyPrice.currentState?.validate() ?? false;
                if (!isValid) return;

                // upsert
                final record = widget.record ?? Records();
                record.date = _date;
                record.category = _category;
                record.title = _txtTitle.text;
                record.price = int.parse(_txtPrice.text);
                record.updatedAt = DateTime.now();
                DbHelper.upsertRecord(record);

                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
