import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:poke_api/src/config/theme/theme.dart';
import 'package:poke_api/src/views/home/widgets/poke_appbar.dart';
import 'package:poke_api/src/views/widgets/poke_image.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'poke_appbar.test.mocks.dart';

@GenerateMocks([ThemeNotifier])
void main() {
  late MockThemeNotifier mockThemeNotifier;
  late ProviderContainer container;

  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
    SharedPreferences.setMockInitialValues({});
  });

  setUp(() {
    mockThemeNotifier = MockThemeNotifier();

    when(mockThemeNotifier.toggleTheme()).thenAnswer((_) async {
      return;
    });
    when(mockThemeNotifier.state).thenReturn(ThemeData.light());

    container = ProviderContainer(
      overrides: [themeProvider.overrideWith((ref) => mockThemeNotifier)],
    );
  });

  tearDown(() {
    container.dispose();
  });

  testWidgets('PokeAppbar should render correctly in light theme', (
    WidgetTester tester,
  ) async {
    final appBar = PokeAppbar();

    await tester.pumpWidget(
      ProviderScope(
        parent: container,
        child: MaterialApp(
          theme: ThemeData.light(),
          home: Scaffold(appBar: appBar),
        ),
      ),
    );

    expect(find.text('PKM Dex'), findsOneWidget);
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(Switch), findsOneWidget);
    expect(find.byType(PokeImage), findsOneWidget);
  });

  testWidgets('PokeAppbar should render correctly in dark theme', (
    WidgetTester tester,
  ) async {
    when(mockThemeNotifier.state).thenReturn(ThemeData.dark());

    final appBar = PokeAppbar();

    await tester.pumpWidget(
      ProviderScope(
        parent: container,
        child: MaterialApp(
          theme: ThemeData.dark(),
          home: Scaffold(appBar: appBar),
        ),
      ),
    );

    expect(find.text('PKM Dex'), findsOneWidget);
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(Switch), findsOneWidget);
  });

  testWidgets('PokeAppbar should have correct styling properties', (
    WidgetTester tester,
  ) async {
    final appBar = PokeAppbar();

    await tester.pumpWidget(
      ProviderScope(
        parent: container,
        child: MaterialApp(home: Scaffold(appBar: appBar)),
      ),
    );

    final appBarFinder = find.byType(AppBar);
    final appBarWidget = tester.widget<AppBar>(appBarFinder);

    expect(appBarWidget.backgroundColor, Colors.red);
    expect(appBarWidget.elevation, 0.0);
    expect(appBar.preferredSize, equals(const Size.fromHeight(kToolbarHeight)));
  });

  testWidgets('PokeAppbar should toggle theme when switch is tapped', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        parent: container,
        child: MaterialApp(home: Scaffold(appBar: PokeAppbar())),
      ),
    );

    await tester.tap(find.byType(Switch));
    await tester.pump();

    verify(mockThemeNotifier.toggleTheme()).called(1);
  });

  testWidgets('PokeAppbar should have pokeball background image', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        parent: container,
        child: MaterialApp(home: Scaffold(appBar: PokeAppbar())),
      ),
    );

    final stackInAppBar = find.descendant(
      of: find.byType(AppBar),
      matching: find.byType(Stack),
    );
    expect(stackInAppBar, findsOneWidget);

    final opacityWidgets = tester.widgetList<Opacity>(
      find.descendant(of: stackInAppBar, matching: find.byType(Opacity)),
    );

    bool found = false;
    for (var widget in opacityWidgets) {
      if (widget.opacity == 0.2) {
        found = true;
        break;
      }
    }
    expect(found, true, reason: "Opacity widget with value 0.2 not found");

    final pokeImageFinder = find.descendant(
      of: stackInAppBar,
      matching: find.byType(PokeImage),
    );
    expect(pokeImageFinder, findsOneWidget);

    final pokeImage = tester.widget<PokeImage>(pokeImageFinder);
    expect(pokeImage.source, equals('assets/pokeball_background.png'));

    final transformFinder = find.descendant(
      of: stackInAppBar,
      matching: find.byType(Transform),
    );
    expect(transformFinder, findsOneWidget);
  });
}
