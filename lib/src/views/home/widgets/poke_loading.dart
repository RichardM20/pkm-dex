import 'package:poke_api/src/config/theme/spacing.dart';
import 'package:poke_api/src/controllers/homeController/home_controller.dart';
import 'package:poke_api/src/views/exports.dart';
import 'package:poke_api/src/views/widgets/linear_indicator.dart';
import 'package:poke_api/src/views/widgets/poke_image.dart';
import 'package:poke_api/src/views/widgets/twen_animaiton.dart';

class PokeLoading extends ConsumerWidget {
  const PokeLoading({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final homeState = ref.watch(homeControllerProvider);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      spacing: AppSizes.x2,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TwenAnimationType(
              direction: AnimationDirection.left,
              type: AnimationType.translate,
              child: PokeImage(
                source: 'assets/pikachu_running.gif',
                width: 40,
                height: 40,
              ),
            ),
            TwenAnimationType(
              direction: AnimationDirection.up,
              type: AnimationType.translate,
              child: SizedBox(
                width: 50,
                child: CustomLinearProgressIndicator(
                  progress: homeState.requestProgress,
                ),
              ),
            ),
          ],
        ),
        Text(
          '${homeState.requestCompleted}/${homeState.currentGeneration.limit}',
          style: GoogleFonts.poppins(fontSize: AppSizes.fontx3),
        ),
      ],
    );
  }
}
