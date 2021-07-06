part of 'internals.dart';

/// A [ListTile] with ability to change the current language of the app
class QudsSelectLanguageListTile extends StatelessWidget {
  /// A callback that called if a change of app translation preferences occured
  final VoidCallback? onChanged;

  /// Weather to save the new selected language automatically.
  final bool autoSave;

  /// Weather to call Navigator.pop(..) when tap.
  final bool popOnTap;

  /// Create an instance of [QudsSelectLanguageListTile]
  const QudsSelectLanguageListTile(
      {Key? key, this.popOnTap = false, this.autoSave = true, this.onChanged})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return QudsProviderWatcher<QudsTranslationProvider>(
        builder: (p) => ListTile(
              leading: Icon(Icons.language_rounded),
              title: Text('Select language'.tr),
              subtitle: Text(p!.asPlatform.v == true
                  ? 'As Platform'.tr
                  : QudsTranslation.currLanguage!.langName!),
              onTap: () {
                if (popOnTap) Navigator.pop(context);

                QudsTranslation.showLanguagesSelectionBorderSheet(context,
                    autoSave: autoSave, onChanged: onChanged);
              },
            ));
  }
}
