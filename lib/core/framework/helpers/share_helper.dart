import 'package:share_plus/share_plus.dart';

class ShareHelper {
  static Future<void> shareText(String text) async {
    await Share.share(text);
  }

  static Future<void> shareFile(String filePath) async {
    await Share.shareXFiles([XFile(filePath)], text: 'Check this out!');
  }
}
