import 'dart:convert';

import 'package:flutter_project/clean_architecture/data/dto/advice_dto.dart';
import 'package:flutter_project/clean_architecture/domain/repositories/advice_repository.dart';
import 'package:http/http.dart';

class AdviceRepositoryRest implements AdviceRepository {
  final Client client;

  AdviceRepositoryRest({required this.client});

  @override
  Future<AdviceDto> read({String id = ''}) async {
    final result = await client.get(
      Uri.parse('https://api.flutter-community.com/api/v1/advice/$id'),
      headers: {
        'accept': 'application/json',
      },
    );

    if (result.statusCode != 200) {
      // error handling
    }

    return AdviceDto.fromJson(jsonDecode(result.body));
  }
}
