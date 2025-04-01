import 'package:poke_api/src/views/details/tabbar/poke_stats/poke_stats_indicator.dart';
import 'package:poke_api/src/views/exports.dart';

class PokeStatsContent extends ConsumerWidget {
  const PokeStatsContent({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Column(children: [PokeStatsIndicator()]);
  }
}
