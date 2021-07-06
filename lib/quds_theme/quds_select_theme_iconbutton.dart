part of 'internals.dart';

/// A [QudsAnimatedCombinedIconsButton] with ability to change the current theme of the app
class QudsSelectThemeIconButton extends StatelessWidget {
  /// A callback that called if a change of app translation preferences occured
  final VoidCallback? onChanged;

  /// Weather to save the new selected theme automatically.
  final bool autoSave;

  /// Weather to call Navigator.pop(..) when tap.
  final bool popOnTap;

  /// Create an instance of [QudsSelectThemeIconButton]
  const QudsSelectThemeIconButton(
      {Key? key, this.popOnTap = false, this.autoSave = true, this.onChanged})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return QudsProviderWatcher<QudsTranslationProvider>(
      builder: (pL) => QudsProviderWatcher<QudsThemeProvider>(
          builder: (p) => QudsAnimatedCombinedIconsButton(
              tooltip: 'Select Theme'.tr,
              onPressed: () {
                if (popOnTap) Navigator.pop(context);

                QudsTheme.showThemesSelectionBorderSheet(context,
                    onChanged: onChanged, autoSave: autoSave);
              },
              curve: Curves.fastLinearToSlowEaseIn,
              showStartIcon: p!.isDark.v,
              duration: Duration(milliseconds: 700),
              startIcon: Icons.brightness_3_rounded,
              endIcon: Icons.brightness_7_rounded)),
    );
  }
}
