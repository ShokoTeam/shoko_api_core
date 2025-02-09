import 'package:shoko_api_core_supabase/shoko_api_core_supabase.dart';
import 'package:supabase/supabase.dart';

void main() {
  SupabaseSource.initialize(SupabaseClient('supabaseUrl', ''));
}
