import 'package:poke_api/src/config/theme/screen_size.dart';
import 'package:poke_api/src/config/theme/spacing.dart';
import 'package:poke_api/src/controllers/homeController/home_controller.dart';
import 'package:poke_api/src/views/exports.dart';
import 'package:poke_api/src/views/home/widgets/poke_card/poke_card.dart';
import 'package:poke_api/src/views/widgets/Skeleton/skeleton.dart';
import 'package:poke_api/src/views/widgets/poke_error_data.dart';

class PokeList extends ConsumerWidget {
  const PokeList({super.key});

  SliverGridDelegateWithFixedCrossAxisCount _buildGridDelegate(
    bool isLoading,
    context,
  ) {
    final smallCounts = ScreenSize.isTablet(context) ? 3 : 2;
    final counts = ScreenSize.isDesktop(context) ? 4 : smallCounts;

    return SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: counts,
      crossAxisSpacing: AppSizes.x2,
      mainAxisSpacing: AppSizes.x2,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeControllerProvider);

    if (homeState.isError && homeState.pokemons.isEmpty) {
      return const PokeError();
    }

    final isLoading = homeState.isLoading;
    final pokemons = homeState.pokemons[homeState.currentGeneration] ?? [];
    final itemCount = isLoading ? homeState.requestCompleted : pokemons.length;

    return Stack(
      children: [
        GridView.builder(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.x3,
            vertical: AppSizes.x2,
          ),
          itemCount: itemCount,
          gridDelegate: _buildGridDelegate(isLoading, context),
          itemBuilder: (_, index) {
            if (index >= pokemons.length) {
              return Skeleton(
                showSkeleton: isLoading,
                child: SizedBox(height: 185, width: 185),
              );
            }
            return PokeCard(pokemon: pokemons[index]);
          },
        ),
      ],
    );
  }
}
