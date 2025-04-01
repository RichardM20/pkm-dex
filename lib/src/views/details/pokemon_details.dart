import 'package:poke_api/src/views/details/tabbar/pokemon_information_details.dart';
import 'package:poke_api/src/views/details/tabbar/widgets/top_background_content.dart';
import 'package:poke_api/src/views/exports.dart';

class PokemonDetails extends StatelessWidget {
  const PokemonDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.chevron_left, color: Colors.grey.shade300),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Stack(
        children: [PkmTopDetailContent(), PkmInformationDetailContent()],
      ),
    );
  }
}
