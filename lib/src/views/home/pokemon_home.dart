import 'package:poke_api/src/controllers/homeController/home_controller.dart';
import 'package:poke_api/src/utils/pkm_generation.dart';
import 'package:poke_api/src/views/exports.dart';
import 'package:poke_api/src/views/home/widgets/poke_appbar.dart';
import 'package:poke_api/src/views/home/widgets/poke_chips/poke_chips.dart';
import 'package:poke_api/src/views/home/widgets/poke_list.dart';

class PokemonHome extends ConsumerStatefulWidget {
  const PokemonHome({super.key});

  @override
  ConsumerState<PokemonHome> createState() => _PokemonHomeState();
}

class _PokemonHomeState extends ConsumerState<PokemonHome> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(homeControllerProvider.notifier)
          .getPokemons(generation: PokemonGeneration.first);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PokeAppbar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [PokeChips(), Expanded(child: PokeList())],
      ),
    );
  }
}
