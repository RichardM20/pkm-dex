import 'package:poke_api/src/config/theme/theme.dart';
import 'package:poke_api/src/views/exports.dart';
import 'package:poke_api/src/views/widgets/poke_image.dart';
import 'package:poke_api/src/views/widgets/twen_animaiton.dart';

class PokeAppbar extends ConsumerWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  const PokeAppbar({super.key});

  Icon iconMode(BuildContext context) {
    return Icon(
      context.isDarkMode ? Icons.dark_mode_rounded : Icons.light_mode_outlined,
      color: Colors.black,
    );
  }

  @override
  Widget build(BuildContext context, ref) {
    final themeNotifier = ref.watch(themeProvider.notifier);
    return AppBar(
      backgroundColor: Colors.red,
      elevation: 0.0,
      title: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: -35,
            top: -25,
            child: Transform.rotate(
              angle: 0.5,
              child: Opacity(
                opacity: 0.2,
                child: PokeImage(source: 'assets/pokeball_background.png'),
              ),
            ),
          ),
          Text(
            'PKM Dex',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
      actions: [
        TwenAnimationType(
          type: AnimationType.translate,
          direction: AnimationDirection.right,
          child: Switch.adaptive(
            value: context.isDarkMode,
            activeColor: Colors.white,
            inactiveThumbColor: Colors.white,
            activeTrackColor: Colors.red,
            trackOutlineColor: WidgetStatePropertyAll(Colors.transparent),
            onChanged: (v) {
              themeNotifier.toggleTheme();
            },
            thumbIcon: WidgetStatePropertyAll(iconMode(context)),
          ),
        ),
      ],
    );
  }
}
