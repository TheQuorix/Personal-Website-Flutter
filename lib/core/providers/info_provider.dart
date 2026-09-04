import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_website/core/models/info/info_model.dart';
import 'package:personal_website/core/network/api_client.dart';

final apiServiceProvider = Provider<ApiService>((ref) => ApiService());

final infoProvider = FutureProvider<InfoModel>((ref) async {
  final api = ref.watch(apiServiceProvider);
  return await api.getInfo();
});
