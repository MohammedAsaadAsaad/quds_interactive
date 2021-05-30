part of 'internals.dart';

class QudsLanguage {
  _MaterialLocalizationsDelegate get materialLocalizationsDelegate =>
      const _MaterialLocalizationsDelegate();

  String? langCode;
  String? langName;
  String? abbreviatedName;
  TextDirection? textDirection;
  String? prefferedFont;
  String? countryCode;
  String? countryName;

  Map<String, String> dictionary = {};

  String translate(String key) {
    var result = dictionary[key.toLowerCase()];

    if (result == null && langCode != 'en') {
      log('($langCode) need to translate: $key');
      return key;
    }
    return result ?? key;
  }

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
