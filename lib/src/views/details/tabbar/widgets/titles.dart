import 'package:poke_api/src/config/theme/spacing.dart';
import 'package:poke_api/src/utils/text_mejora_formats.dart';
import 'package:poke_api/src/views/exports.dart';

class DetailsTitle extends StatelessWidget {
  const DetailsTitle({
    super.key,
    required this.title,
    this.color = Colors.black,
    this.size,
  });
  final Color? color;
  final String title;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Text(
      capitalize(title),
      style: GoogleFonts.poppins(
        fontWeight: FontWeight.w600,
        fontSize: size ?? AppSizes.fontx5,
        color: color,
      ),
    );
  }
}
