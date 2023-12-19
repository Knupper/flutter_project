import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_project/clean_architecture/data/data_sources/cache_data_source_memory.dart';
import 'package:flutter_project/clean_architecture/data/data_sources/data_source.dart';
import 'package:flutter_project/clean_architecture/data/dto/advice_dto.dart';
import 'package:http/http.dart';

class RestApiDataSource implements DataSource {
  final Client client;
  final CacheDataSourceMemory<AdviceDto> cache;

  RestApiDataSource({
    required this.client,
    @visibleForTesting CacheDataSourceMemory<AdviceDto>? externalCache,
  }) : cache = externalCache ?? CacheDataSourceMemory<AdviceDto>();

  @override
  Future<AdviceDto> read({String id = ''}) async {
    final cachedItem = cache.getItem(id: id);

    if (cachedItem == null) {
      debugPrint('item $id was not cached - load from server');
      final result = await client.get(
        Uri.parse('https://api.flutter-community.com/api/v1/advice/$id'),
        headers: {
          'accept': 'application/json',
        },
      );

      if (result.statusCode != 200) {
        throw Exception('invalid response');
      }

      final dto = AdviceDto.fromJson(jsonDecode(result.body));

      cache.setItem(dto, id: dto.id.toString());

      return dto;
    } else {
      debugPrint('item $id was cached - load from cache');
      return cachedItem;
    }
  }
}
