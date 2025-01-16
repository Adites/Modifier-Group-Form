import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:modifier_group_form/modifier_group_model.dart';

class ApiService {
  static const String baseUrl =
      "https://megameal.mooo.com/pos/setting/modifier_group";

  static Future<List<ModifierGroup>> fetchModifiers(
      int vendorId, int page, int pageSize) async {
    final url = Uri.parse(
        '$baseUrl/?vendorId=$vendorId&page=$page&page_size=$pageSize');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['results'] as List)
          .map((json) => ModifierGroup.fromJson(json, vendorId))
          .toList();
    } else {
      throw Exception('Failed to fetch modifiers');
    }
  }

  static Future<ModifierGroup> createModifier(ModifierGroup modifier) async {
    final url = Uri.parse("$baseUrl/");
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(modifier.toJson()),
    );

    if (response.statusCode == 201) {
      var jsonData = jsonDecode(response.body);
      return ModifierGroup.fromJson(jsonData, modifier.vendorId);
    } else {
      throw Exception('Failed to create modifier');
    }
  }

  static Future<ModifierGroup> editModifier(
      int id, ModifierGroup modifier) async {
    final url =
        Uri.parse('$baseUrl/${modifier.id}/?vendorId=${modifier.vendorId}');
    final response = await http.patch(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(modifier.toJson()),
    );

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      return ModifierGroup.fromJson(jsonData, modifier.vendorId);
    } else {
      throw Exception('Failed to edit modifier');
    }
  }

  static Future<void> deleteModifier(int modifierId, int vendorId) async {
    final url = Uri.parse('$baseUrl/$modifierId/?vendorId=$vendorId');
    final response = await http.delete(url);

    if (response.statusCode != 204) {
      throw Exception('Failed to delete modifier');
    }
  }
}
