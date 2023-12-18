import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_project/clean_architecture/data/data_sources/rest_api_data_source.dart';
import 'package:flutter_project/clean_architecture/data/dto/advice_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

class MockClient extends Mock implements Client {}

void main() {
  final MockClient mockClient = MockClient();
  group('RestApiDataSource', () {
    setUpAll(() {
      registerFallbackValue(Uri());
    });

    test('should return an AdviceDto with no given id', () async {
      when(() => mockClient.get(Uri.parse('https://api.flutter-community.com/api/v1/advice/'),
          headers: any(named: 'headers'))).thenAnswer(
        (invocation) => Future.value(
          Response(
            '{"advice": "test-42", "advice_id" : 42}',
            200,
          ),
        ),
      );

      final dataSourceUnderTest = RestApiDataSource(client: mockClient);
      final result = await dataSourceUnderTest.read();

      expect(result.id, 42);
      expect(result.advice, 'test-42');
    });

    test('should return an AdviceDto with given id', () async {
      when(() => mockClient.get(Uri.parse('https://api.flutter-community.com/api/v1/advice/42'),
          headers: any(named: 'headers'))).thenAnswer(
        (invocation) => Future.value(
          Response(
            '{"advice": "test-42", "advice_id" : 42}',
            200,
          ),
        ),
      );

      final dataSourceUnderTest = RestApiDataSource(client: mockClient);
      final result = await dataSourceUnderTest.read(id: '42');

      expect(result.id, 42);
      expect(result.advice, 'test-42');
    });

    test('should return an Failure if status code is not 200', () async {
      when(() => mockClient.get(Uri.parse('https://api.flutter-community.com/api/v1/advice/42'),
          headers: any(named: 'headers'))).thenAnswer(
        (invocation) => Future.value(
          Response(
            '{"advice": "test-42", "advice_id" : 42}',
            402,
          ),
        ),
      );

      final dataSourceUnderTest = RestApiDataSource(client: mockClient);

      expect(() => dataSourceUnderTest.read(), throwsA(isA<Exception>()));
    });
  });
}
