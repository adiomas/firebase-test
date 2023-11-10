// ignore_for_file: always_use_package_imports

import 'package:dio/dio.dart';
import 'package:flutter_loggy_dio/flutter_loggy_dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

import '../../main/app_environment.dart';
import 'api_client.dart';

final apiClientProvider = Provider<ApiClient>(
  (ref) => ApiClient(
    ref.watch(
      dioProvider(EnvInfo.apiBaseUrl),
    ),
  ),
);

final dioProvider = Provider.family<Dio, String>((ref, baseUrl) => Dio(
      BaseOptions(baseUrl: baseUrl),
    )..interceptors.addAll(
        [
          LoggyDioInterceptor(requestBody: true, requestHeader: true),
        ],
      ));

final supabaseProvider = Provider<supabase.SupabaseClient>(
  (ref) => supabase.Supabase.instance.client,
);
