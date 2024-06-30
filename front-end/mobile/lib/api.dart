import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Map<String, dynamic>>> fetchData(keyword) async {
  debugPrint("jalan");
  final response = await http
      .get(Uri.parse('http://localhost:8000/api/scrape?keyword=$keyword'));
  debugPrint(response.statusCode.toString());

  if (response.statusCode == 200) {
    // Parse response body
    List<dynamic> responseData = json.decode(response.body);
    List<Map<String, dynamic>> dataList = [];

    // Convert dynamic list to List<Map<String, dynamic>>
    for (var item in responseData) {
      dataList.add(Map<String, dynamic>.from(item));
    }
    return dataList;
  } else {
    throw Exception('Failed to load data');
  }
}
