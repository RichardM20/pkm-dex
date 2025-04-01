import 'package:poke_api/src/config/theme/spacing.dart';
import 'package:poke_api/src/config/theme/theme.dart';
import 'package:poke_api/src/utils/text_mejora_formats.dart';
import 'package:poke_api/src/views/exports.dart';

class MoveTableCell extends StatelessWidget {
  final String? text;
  final bool isTitle;
  final String? url;
  final VoidCallback? onPressed;

  const MoveTableCell({
    super.key,
    required this.text,
    this.isTitle = false,
    this.url,
    this.onPressed,
  });

  Color getTextColor(BuildContext context) {
    if (isTitle) {
      return Colors.grey.shade300;
    } else if (text == null || text!.isEmpty) {
      return Colors.grey.shade400;
    } else {
      return context.isDarkMode ? Colors.grey.shade400 : Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isTitle ? null : onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          formatSpecial(text ?? 'Unknown'),
          style: GoogleFonts.poppins(
            color: getTextColor(context),
            fontWeight: isTitle ? FontWeight.bold : FontWeight.normal,
            fontSize: AppSizes.x3,
          ),
        ),
      ),
    );
  }
}
