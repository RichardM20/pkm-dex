import 'package:poke_api/src/views/exports.dart';

class ChipAction extends StatelessWidget {
  final String text;
  final bool isCurrent;
  final VoidCallback onTap;

  const ChipAction({
    super.key,
    required this.text,
    required this.isCurrent,
    required this.onTap,
  });

  Color get textColor => isCurrent ? Colors.white : Colors.black;

  Color get backgroundColor => isCurrent ? Colors.red : Colors.white;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: 80,
      height: 30,
      decoration: BoxDecoration(
        color: backgroundColor,

        borderRadius: BorderRadius.circular(100),
      ),
      alignment: Alignment.center,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(100),
          child: Center(
            child: Text(text, style: GoogleFonts.poppins(color: textColor)),
          ),
        ),
      ),
    );
  }
}
