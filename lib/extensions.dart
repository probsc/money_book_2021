import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_book_2021/enums.dart';

/// int 関連の拡張メソッド
extension IntExtention on int? {
  static final _formatComma = NumberFormat('#,###');

  /// 整数値からカンマ付き円表記の文字列を返す
  String get toYen => '${_formatComma.format(this ?? 0)}円';
}

/// DateTime 関連の拡張メソッド
extension DateTimeExtension on DateTime {
  static final _formatDateTime = DateFormat('yyyy-MM-dd HH:mm:ss');
  static final _formatDate = DateFormat('yyyy-MM-dd');
  static const _week = [
    '月',
    '火',
    '水',
    '木',
    '金',
    '土',
    '日',
  ];

  /// 日付から [yyyy-MM-dd HH:mm:ss] 形式の文字列を返す
  String get toText => _formatDateTime.format(this);

  /// 日付から [yyyy-MM-dd] 形式の文字列を返す
  String get toDateText => _formatDate.format(this);

  /// 日付から [yyyy-MM-dd(aaa)] 形式の文字列を返す
  String get toYmd =>
      '${_formatDate.format(this)} (${_week[this.weekday - 1]})';
}

/// Map<String, dynamic> 関連の拡張メソッド
extension MapExtension on Map<String, dynamic> {
  /// 指定キーの DateTime 要素を返す
  DateTime getDateTime(String key) {
    var v = this[key];
    return v == null || v is! String ? DateTime.now() : DateTime.parse(v);
  }
}

/// 種別列挙体の拡張メソッド
extension CategoriesExtension on Categories {
  /// 分類列挙体の文字列を返す
  String get toText {
    switch (this) {
      case Categories.foods:
        return '食費';

      case Categories.communications:
        return '通信';

      case Categories.travels:
        return '移動';

      case Categories.events:
        return 'イベント';

      case Categories.hobbies:
        return '趣味';

      case Categories.games:
        return 'ゲーム';

      case Categories.clothes:
        return '衣服';

      case Categories.books:
        return '書籍';

      case Categories.goods:
        return '雑貨';

      case Categories.gifts:
        return 'プレゼント';

      case Categories.subscriptions:
        return 'サブスク';

      default:
        return 'その他';
    }
  }

  /// 分類列挙体のアイコンを返す
  IconData get toIcon {
    switch (this) {
      case Categories.foods:
        return Icons.fastfood_outlined;

      case Categories.communications:
        return Icons.language_outlined;

      case Categories.travels:
        return Icons.train_outlined;

      case Categories.events:
        return Icons.festival_outlined;

      case Categories.hobbies:
        return Icons.golf_course_outlined;

      case Categories.games:
        return Icons.sports_esports_outlined;

      case Categories.clothes:
        return Icons.checkroom_outlined;

      case Categories.books:
        return Icons.auto_stories_outlined;

      case Categories.goods:
        return Icons.shopping_bag_outlined;

      case Categories.gifts:
        return Icons.card_giftcard_outlined;

      case Categories.subscriptions:
        return Icons.subscriptions_outlined;

      default:
        return Icons.style_outlined;
    }
  }
}
