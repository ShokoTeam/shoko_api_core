Add the following top-level `init` method to the `main.dart` file.
How create: 
[DartFrog advanced docs](https://dartfrog.vgv.dev/docs/advanced/custom_init_method)

And add
```dart
  SupabaseSource.initialize(SupabaseClient('supabaseUrl', 'supabaseKey'));
```

Use
```dart
  SupabaseSource.instance.db.from('table').select();
```
Supbase dart docs: 
[Supbase dart docs](https://supabase.com/docs/reference/dart/introduction?queryGroups=framework&framework=dart)


Also check full docs for shoko_api_core:
https://pub.dev/packages/shoko_api_core