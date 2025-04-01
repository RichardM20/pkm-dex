import 'package:poke_api/src/config/theme/spacing.dart';
import 'package:poke_api/src/utils/text_mejora_formats.dart';
import 'package:poke_api/src/views/exports.dart';

class RowTexts extends StatelessWidget {
  final String title;
  final String value;

  final Color? color;

  const RowTexts({
    super.key,
    required this.title,
    required this.value,
    this.color,
  });

  Widget child() {
    return Text(
      capitalize(value),
      style: GoogleFonts.poppins(fontSize: AppSizes.fontx3, color: color),
      textAlign: TextAlign.left,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppSizes.x1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: AppSizes.fontx3,
                color: Colors.grey.shade500,
              ),
            ),
          ),
          Expanded(flex: 5, child: child()),
        ],
      ),
    );
  }
}
