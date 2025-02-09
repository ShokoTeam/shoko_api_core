import 'package:shoko_api_core/shoko_api_core.dart';
import 'package:supabase/supabase.dart';

class SupabaseSource implements Source<SupabaseClient> {
  SupabaseSource._(this.db);
  static SupabaseSource? _instance;

  static SupabaseSource get instance => _instance ?? (throw Exception('SupabaseSource not initialized'));

  ///Initializing a connection to a supbase database
  static void initialize(SupabaseClient client) => _instance = SupabaseSource._(client);

  @override
  SupabaseClient db;
}
