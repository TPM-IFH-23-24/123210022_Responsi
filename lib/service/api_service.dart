import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService{
  final String baseUri = 'https://genshin.jmp.blue';

  Future<List<dynamic>> getCharacters() async {
    final response = await http.get(Uri.parse('$baseUri/characters'));
    var data = jsonDecode(response.body);
    return data;
  }

  Future<Map<String, dynamic>> getCharacterByName(String name) async {
    final response = await http.get(Uri.parse('$baseUri/characters/$name'));
    var data = response.body;
    return jsonDecode(data);
  }

  Future<Map<String, dynamic>> getWeaponByName(String name) async {
    final response = await http.get(Uri.parse('$baseUri/weapons/$name'));
    var data = response.body;
    return jsonDecode(data);
  }

  Future<List<dynamic>> getWeapons() async {
    final response = await http.get(Uri.parse('$baseUri/weapons'));
    var data = jsonDecode(response.body);
    return data;
  }
}
