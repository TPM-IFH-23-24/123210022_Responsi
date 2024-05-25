import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService{
  final String baseUri = 'https://genshin.jmp.blue';


  Future<dynamic> getCharacters() async {
    final response = await http.get(Uri.parse('$baseUri/characters'));
    var data = jsonDecode(response.body);
    return data;
  }

  Future<Map<String, dynamic>> getCharacterById(int id) async {
    final response = await http.get(Uri.parse('https://diabetless-api-ik6ucgm26a-et.a.run.app/meals'));
    var data = response.body;
    return jsonDecode(data);
  }
}
