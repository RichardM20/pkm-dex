import 'package:poke_api/src/config/theme/spacing.dart';
import 'package:poke_api/src/config/theme/theme.dart';
import 'package:poke_api/src/views/exports.dart';
import 'package:poke_api/src/views/widgets/poke_image.dart';
import 'package:poke_api/src/views/widgets/twen_animaiton.dart';

class ShapeInformationContainer extends ConsumerWidget {
  const ShapeInformationContainer({
    super.key,
    required this.loading,
    required this.child,
  });

  final bool loading;
  final Widget child;

  Widget _buildChild() {
    if (loading) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: AppSizes.x1,
        children: [
          TwenAnimationType(
            direction: AnimationDirection.left,
            type: AnimationType.translate,
            child: PokeImage(source: 'assets/pikachu_running.gif'),
          ),
          Text('Loading Pokémon Pokédex data...'),
        ],
      );
    }

    return child;
  }

  @override
  Widget build(BuildContext context, ref) {
    double multipler = loading ? 1 : 0.72;
    final radius =
        loading
            ? BorderRadius.zero
            : BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            );
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * multipler,
      padding: EdgeInsets.symmetric(vertical: AppSizes.x2),
      decoration: BoxDecoration(
        color: context.isDarkMode ? Colors.black : Colors.white,
        borderRadius: radius,
      ),
      child: _buildChild(),
    );
  }
}
