part of 'internals.dart';

/// A [IconButton] with ability to change the current language of the app
class QudsSelectLanguageIconButton extends StatelessWidget {
  /// A callback that called if a change of app translation preferences occured
  final VoidCallback? onChanged;

  /// Weather to save the new selected language automatically.
  final bool autoSave;

  /// Weather to call Navigator.pop(..) when tap.
  final bool popOnTap;

  /// Create an instance of [QudsSelectLanguageIconButton]
  const QudsSelectLanguageIconButton(
      {Key? key, this.popOnTap = false, this.autoSave = true, this.onChanged})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return QudsProviderWatcher<QudsTranslationProvider>(
        builder: (p) => IconButton(
              tooltip: 'Select Language'.tr,
              icon: Icon(Icons.language),
              onPressed: () {
                if (popOnTap) Navigator.pop(context);

                QudsTranslation.showLanguagesSelectionBorderSheet(context,
                    autoSave: autoSave, onChanged: onChanged);
              },
            ));
  }
}
