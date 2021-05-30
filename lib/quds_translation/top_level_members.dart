part of 'internals.dart';

translate(String key, {String? langCode}) =>
    QudsTranslation.translate(key, langCode: langCode);

QudsLanguage? get currLanguage => QudsTranslation.currLanguage;
String? get currentFont => QudsTranslation.currLanguage?.prefferedFont;
QudsLanguage? get currentLanguage => QudsTranslation.currLanguage;

bool get isLTR => currentLanguage == null
    ? false
    : currentLanguage?.textDirection == TextDirection.ltr;

bool get isRTL => !isLTR;

String translateForLang(String langCode, String key) =>
    QudsTranslation.translate(key, langCode: langCode);
