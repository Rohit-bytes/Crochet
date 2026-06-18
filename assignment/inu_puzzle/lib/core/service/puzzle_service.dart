import 'package:inu_puzzle/model/puzzle_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PuzzleService {
  Future<DogImage> getRandomDog() async {
    final response = await http.get(
      Uri.parse('https://dog.ceo/api/breeds/image/random'),
    );

    if (response.statusCode == 200) {
      return DogImage.fromJson(jsonDecode(response.body));
    }

    throw Exception('Failed to load dog image');
  }
}
