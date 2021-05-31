part of 'internals.dart';

/// A [ListTile] with ability to change the current language of the app
class QudsSelectLanguageWidget extends StatelessWidget {
  final VoidCallback? onChanged;

  const QudsSelectLanguageWidget({Key? key, this.onChanged}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.language_rounded),
      title: Text('Select language'.tr),
      subtitle: Text(QudsTranslation.currLanguage!.langName!),
      onTap: () {
        QudsTranslation.showLanguagesSelectionBorderSheet(context,
            onChanged: onChanged);
      },
    );
  }
}
