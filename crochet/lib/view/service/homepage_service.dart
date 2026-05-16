import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<dynamic>> getCatsapi() async {
  final response = await http.get(
    Uri.parse('https://api.thecatapi.com/v1/images/search?limit=10'),
  );
  print(response.statusCode);
  print("https://api.thecatapi.com/v1/images/search?limit=10");
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load cats');
  }
}
