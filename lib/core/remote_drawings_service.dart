import 'dart:convert';
import 'package:http/http.dart' as http;

class RemoteDrawingsService {
  static const String url =
      'https://SEU_LINK_AQUI/drawings.json';

  static Future<List<String>> fetchDrawings() async {
    try {
      final res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        return List<String>.from(data['drawings']);
      }
    } catch (_) {}
    return [];
  }
}
