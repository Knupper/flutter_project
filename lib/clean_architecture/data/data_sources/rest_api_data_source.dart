import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_project/clean_architecture/data/data_sources/data_source.dart';
import 'package:flutter_project/clean_architecture/data/dto/advice_dto.dart';
import 'package:http/http.dart';

class RestApiDataSource implements DataSource {
  final Client client;

  RestApiDataSource({required this.client});

  @override
  Future<AdviceDto> read({String id = ''}) async {
    try {
      final result = await client.get(
        Uri.parse('https://api.flutter-community.com/api/v1/advice/$id'),
        headers: {
          'accept': 'application/json',
        },
      );

      if (result.statusCode != 200) {
        throw Exception('invalid response');
      }

      return AdviceDto.fromJson(jsonDecode(result.body));
    } catch (e) {
      debugPrint('Log error');
      rethrow;
    }
  }
}
