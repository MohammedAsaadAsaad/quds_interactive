part of 'internals.dart';

class QudsLanguage {
  _MaterialLocalizationsDelegate get materialLocalizationsDelegate =>
      const _MaterialLocalizationsDelegate();

  /// The language code like 'ar'
  String? langCode;

  /// The language name like 'العربية'
  String? langName;

  /// The abbreviated name of the language like 'ع'
  String? abbreviatedName;

  /// The text direction of the language
  TextDirection? textDirection;

  /// The desired font family of the language
  String? prefferedFont;

  /// The country code like 'PS'
  String? countryCode;

  /// The country name like 'فلسطين'
  String? countryName;

  /// The dicionary of the co-words of this language
  Map<String, String> dictionary = {};

  String translate(String key) {
    var result = dictionary[key.toLowerCase()];

    if (result == null && langCode != 'en') {
      log('($langCode) need to translate: $key');
      return key;
    }
    return result ?? key;
  }

  /// Create an instance of [QudsLanguage]
  /// using an instance of [QudsLanguageDetails]
  QudsLanguage.fromLanguageDetails(QudsLanguageDetails details) {
    langCode = details.langCode;
    langName = details.langName;
    prefferedFont = details.preferredFontFamily;
    textDirection = details.textDirection;
    abbreviatedName = details.abbreviatedName;
    countryCode = details.countryCode;
    countryName = details.countryName;
    _loadDictionaryFromMap(details.dictionary);
  }

  void _loadDictionaryFromMap(Map<String, String> map) {
    for (var entry in map.entries)
      dictionary[entry.key.toLowerCase().trim()] = entry.value;
  }

  /// Merge another dictionary with the current dictionary
  void mergeDictionary(Map<String, String> map) {
    for (var entry in map.entries)
      dictionary[entry.key.toLowerCase().trim()] = entry.value;
  }

  @override
  String toString() => (langCode != null && countryCode != null)
      ? langCode!.toLowerCase() + '_' + countryCode!.toUpperCase()
      : langCode != null
          ? langCode!.toLowerCase()
          : super.toString();
}
