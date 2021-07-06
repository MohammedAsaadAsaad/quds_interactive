part of 'internals.dart';

/// Get the `key` corresponding translation, by default, it translate to the
/// current set language.
/// `langCode` if a specific language code desired
translate(String key, {String? langCode}) =>
    QudsTranslation.translate(key, langCode: langCode);

/// Get the current set language
QudsLanguage? get currLanguage => QudsTranslation.currLanguage;

/// Get the current set language font
String? get currentFont => QudsTranslation.currLanguage?.prefferedFont;

/// Get the current set language
QudsLanguage? get currentLanguage => QudsTranslation.currLanguage;

/// Weather the current langage is LTR
bool get isLTR => currentLanguage == null
    ? true
    : currentLanguage?.textDirection == TextDirection.ltr;

/// Weather the current langage is RTL
bool get isRTL => !isLTR;

/// Translate to a specific language
String translateForLang(String langCode, String key) =>
    QudsTranslation.translate(key, langCode: langCode);

/// Helping extension methods on [String] for translation.
extension StringExtensions on String {
  ///Translate to the selected language
  String get tr => translate(this);
}
