import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_website/core/models/visits/visit_stats_model.dart';
import 'package:personal_website/core/providers/api_service_provider.dart';

final visitsProvider = FutureProvider<VisitStatsModel>((ref) async {
  final api = ref.watch(apiServiceProvider);
  return await api.getVisits();
});
