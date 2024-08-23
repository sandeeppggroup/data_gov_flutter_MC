// lib/providers/data_provider.dart
import 'package:data_gov_flutter/models/petroleum_product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../services/api_service.dart';
import '../utils/constants.dart';

final dioProvider = Provider<Dio>((ref) {
  return Dio(BaseOptions(
    baseUrl: BASE_URL,
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
  ));
});

final apiServiceProvider = Provider<ApiService>((ref) {
  final dio = ref.watch(dioProvider);
  return ApiService(dio);
});

final dataProvider = FutureProvider<List<PetroleumProduct>>((ref) async {
  final apiService = ref.watch(apiServiceProvider);
  return apiService.fetchData();
});
