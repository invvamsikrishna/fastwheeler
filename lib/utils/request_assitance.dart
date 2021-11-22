import 'dart:convert';
import 'package:http/http.dart' as http;

class RequestAssistance {
  static Future<dynamic> getRequest(String url) async {
    Uri urll = Uri.parse(url);
    http.Response response = await http.get(urll);

    try {
      if (response.statusCode == 200) {
        String jsonData = response.body;
        var decodeData = jsonDecode(jsonData);
        print(decodeData);
        return decodeData;
      } else {
        return "failed";
      }
    } catch (exp) {
      print(exp);
      return "failed";
    }
  }

  static Future<dynamic> getRequest2(String url) async {
    Uri urll = Uri.parse(url);
    http.Response response = await http.get(urll);

    try {
      if (response.statusCode == 200) {
        return "success";
      } else {
        return "failed";
      }
    } catch (exp) {
      print(exp);
      return "failed";
    }
  }
}
