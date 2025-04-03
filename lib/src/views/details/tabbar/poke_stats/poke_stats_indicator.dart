import 'package:poke_api/src/config/theme/spacing.dart';
import 'package:poke_api/src/controllers/detailCotroller/detail_pkm_controller.dart';
import 'package:poke_api/src/utils/pkm_stats.dart';
import 'package:poke_api/src/utils/text_mejora_formats.dart';
import 'package:poke_api/src/views/exports.dart';
import 'package:poke_api/src/views/widgets/linear_indicator.dart';
import 'package:poke_api/src/views/widgets/twen_animaiton.dart';

import '../../../../models/pokemon_model.dart';

class PokeStatsIndicator extends ConsumerWidget {
  const PokeStatsIndicator({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(detailPkmProvider);
    final stat = state.pokemonDetails?.pkmExtraData?.stats;

    return TwenAnimationType(
      type: AnimationType.scale,
      value: 0.9,
      child: Container(
        padding: EdgeInsets.all(AppSizes.x4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...stat!.map((stat) => _StatRow(stat: stat)),
            _StatRow(
              stat: Stat(
                baseStat: state.pokemonDetails?.pokemon?.baseHappiness,
                stat: Species(name: 'base-happiness', url: ''),
              ),
            ),
            _StatRow(
              stat: Stat(
                baseStat: state.pokemonDetails?.pokemon?.captureRate,
                stat: Species(name: 'catch-rate', url: ''),
              ),
            ),
            SizedBox(height: AppSizes.x4),
            Text(
              'Total Stats: ${stat.fold<int>(0, (sum, stat) => sum + (stat.baseStat ?? 0))}',
              style: GoogleFonts.poppins(),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  const _StatRow({required this.stat});

  final Stat stat;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(flex: 4, child: _StatInfo(stat: stat)),
        Expanded(
          flex: 4,
          child: CustomLinearProgressIndicator(
            progress: getStatProgress(stat.stat?.name, stat.baseStat),
          ),
        ),
      ],
    );
  }
}

class _StatInfo extends StatelessWidget {
  const _StatInfo({required this.stat});

  final Stat stat;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            formatSpecial(stat.stat?.name),
            style: GoogleFonts.poppins(fontSize: AppSizes.fontx3),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            '${stat.baseStat}',
            style: GoogleFonts.poppins(fontSize: AppSizes.fontx3),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
