import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/sportevent_model.dart';

class SporteventService {
  final String _baseUrl = 'https://library-app-2019112027.azurewebsites.net/api/SportsEvents';

  Future<List<Sportevent>> getAllEvents() async {
    final response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => Sportevent.fromJson(e)).toList();
    } else {
      throw Exception('Error al cargar eventos');
    }
  }

  Future<void> createEvent(Sportevent event) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(event.toJson()),
    );

    if (response.statusCode != 201 && response.statusCode != 200) {
      throw Exception('Error al crear evento: ${response.body}');
    }
  }
}
