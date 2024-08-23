// lib/services/api_service.dart
import 'package:data_gov_flutter/models/petroleum_product.dart';
import 'package:dio/dio.dart';
import '../utils/constants.dart';

class ApiService {
  final Dio _dio;

  ApiService(this._dio);

  Future<List<PetroleumProduct>> fetchData() async {

    try {
      final response = await _dio.get(
        'https://api.data.gov.in/resource/8b75d7c2-814b-4eb2-9698-c96d69e5f128',
        queryParameters: {
          'api-key': API_KEY,
          'format': 'json',
        },
      );

     if (response.statusCode == 200) {
        final List<dynamic> records = response.data['records'];
        return records.map((record) => PetroleumProduct.fromJson(record)).toList();
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          error: 'Failed to load data',
        );
      }
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }
}
