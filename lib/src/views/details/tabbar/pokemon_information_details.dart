import 'package:poke_api/src/config/theme/spacing.dart';
import 'package:poke_api/src/controllers/detailCotroller/detail_pkm_controller.dart';
import 'package:poke_api/src/utils/pkm_background_color_type.dart';
import 'package:poke_api/src/views/details/tabbar/poke_about/poke_about.dart';
import 'package:poke_api/src/views/details/tabbar/poke_moves/poke_moves.dart';
import 'package:poke_api/src/views/details/tabbar/poke_stats/poke_stats.dart';
import 'package:poke_api/src/views/details/tabbar/widgets/shape_information_container.dart';
import 'package:poke_api/src/views/exports.dart';

class PkmInformationDetailContent extends ConsumerStatefulWidget {
  const PkmInformationDetailContent({super.key});

  @override
  ConsumerState<PkmInformationDetailContent> createState() =>
      _PkmInformationDetailContentState();
}

class _PkmInformationDetailContentState
    extends ConsumerState<PkmInformationDetailContent>
    with SingleTickerProviderStateMixin {
  late TabController tabbarController;

  final tabs = [Tab(text: 'About'), Tab(text: 'Stats'), Tab(text: 'Moves')];

  @override
  void initState() {
    tabbarController = TabController(length: tabs.length, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(detailPkmProvider.notifier).getPkmDetails();
    });

    super.initState();
  }

  @override
  void dispose() {
    tabbarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final detailsState = ref.watch(detailPkmProvider);
    final color = pkmTypeBackground(
      detailsState.pokemonDetails?.pkmExtraData?.types,
    );
    return Align(
      alignment: Alignment.bottomCenter,
      child: ShapeInformationContainer(
        loading: detailsState.isLoading,
        child: Column(
          spacing: AppSizes.x4,
          children: [
            TabBar(
              controller: tabbarController,
              tabs: tabs,
              dividerColor: Colors.transparent,
              labelColor: color,
              indicatorColor: color,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSizes.x8),
                child: TabBarView(
                  controller: tabbarController,
                  children: [
                    PokeAboutContent(),
                    PokeStatsContent(),
                    PokeMovesContent(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
