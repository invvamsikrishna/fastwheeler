import 'package:url_launcher/url_launcher.dart';

class LauncherUtils {
  static Future openEmail(String toEmail) async {
    final url =
        'mailto:$toEmail?subject=${Uri.encodeFull("")}&body=${Uri.encodeFull("")}';
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  static Future openUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print("cant launch");
    }
  }
}
