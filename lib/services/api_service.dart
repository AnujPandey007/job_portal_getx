import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/company.dart';

class ApiService {
  Future<List<Company>> fetchCompanies() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1/photos'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Company.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load companies');
    }
  }
}
