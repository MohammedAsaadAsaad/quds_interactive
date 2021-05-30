part of 'internals.dart';

abstract class QudsLanguageDetails {
  String get langCode;
  String get countryCode;
  String get langName;
  String get countryName;
  String get abbreviatedName;
  TextDirection get textDirection;
  String? get preferredFontFamily => null;
  // String get flagUrl; //countryCode is enough

  Map<String, String> get dictionary;

  String get fullCode =>
      langCode.toLowerCase() + '_' + countryCode.toUpperCase();
  @override
  String toString() => fullCode;
}
