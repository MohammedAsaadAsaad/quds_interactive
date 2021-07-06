part of 'internals.dart';

/// A [ListTile] with ability to change the current theme of the app
class QudsSelectThemeListTile extends StatelessWidget {
  /// A callback that called if a change of app translation preferences occured
  final VoidCallback? onChanged;

  /// Weather to save the new selected theme automatically.
  final bool autoSave;

  /// Weather to call Navigator.pop(..) when tap.
  final bool popOnTap;

  /// Create an instance of [QudsSelectThemeListTile]
  const QudsSelectThemeListTile(
      {Key? key, this.popOnTap = false, this.autoSave = true, this.onChanged})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return QudsProviderWatcher<QudsTranslationProvider>(
        builder: (pL) => QudsProviderWatcher<QudsThemeProvider>(
            builder: (p) => ListTile(
                  leading: Container(
                      width: 30,
                      child: QudsAnimatedCombinedIcons(
                          curve: Curves.fastLinearToSlowEaseIn,
                          showStartIcon: p!.isDark.v,
                          duration: Duration(milliseconds: 700),
                          startIcon: Icons.brightness_3_rounded,
                          endIconColor: Colors.black54,
                          endIcon: Icons.brightness_7_rounded)),
                  title: Text('Select theme'.tr),
                  subtitle: Text(p.asPlatform.v == true
                      ? 'As Platform'.tr
                      : p.isDark.value
                          ? 'Dark'.tr
                          : 'Light'.tr),
                  onTap: () {
                    if (popOnTap) Navigator.pop(context);

                    QudsTheme.showThemesSelectionBorderSheet(context,
                        onChanged: onChanged, autoSave: autoSave);
                  },
                )));
  }
}
