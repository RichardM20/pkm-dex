import 'package:poke_api/src/config/theme/spacing.dart';
import 'package:poke_api/src/models/pokemon_model.dart';
import 'package:poke_api/src/utils/text_mejora_formats.dart';
import 'package:poke_api/src/views/exports.dart';

class PokemonTypeContent extends StatelessWidget {
  const PokemonTypeContent({super.key, this.types});

  final List<PokemonType>? types;

  Widget _buildTypeContent(PokemonType type) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.x2,
        vertical: AppSizes.x1,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Center(
        child: Text(
          capitalize(type.type?.name ?? ''),
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: AppSizes.fontx3,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (types == null || types!.isEmpty) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      width: 100,
      child: GridView.builder(
        padding: EdgeInsets.zero,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          childAspectRatio: 1.9,
        ),
        itemCount: types!.length,
        itemBuilder: (context, index) {
          final type = types![index];
          return _buildTypeContent(type);
        },
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
      ),
    );
  }
}
