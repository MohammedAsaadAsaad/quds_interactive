part of 'internals.dart';

abstract class QudsLanguageDetails {
  /// The language code like 'ar'
  String get langCode;

  /// The country code like 'PS'
  String get countryCode;

  /// The language name like 'العربية'
  String get langName;

  /// The country name like 'فلسطين'
  String get countryName;

  /// The abbreviated name of the language like 'ع'
  String get abbreviatedName;

  /// The text direction of the language
  TextDirection get textDirection;

  /// The desired font family of the language
  String? get preferredFontFamily => null;

  // String get flagUrl; //countryCode is enough

  /// The dicionary of the co-words of this language
  Map<String, String> get dictionary;

  /// The full code of the language like 'ar_PS'
  String get fullCode =>
      langCode.toLowerCase() + '_' + countryCode.toUpperCase();
  @override
  String toString() => fullCode;
}
