import 'package:poke_api/src/config/navigation/routes.dart';
import 'package:poke_api/src/config/theme/theme.dart';
import 'package:poke_api/src/views/exports.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final theme = ref.watch(themeProvider);
    return MaterialApp(
      title: 'Pokedex (PokeApi)',
      debugShowCheckedModeBanner: false,
      theme: theme,
      initialRoute: Routes.initialRoute,
      routes: Routes.routes,
    );
  }
}
