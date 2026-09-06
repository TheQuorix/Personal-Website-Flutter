import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_website/core/network/api_client.dart';

final apiServiceProvider = Provider<ApiService>((ref) => ApiService());
