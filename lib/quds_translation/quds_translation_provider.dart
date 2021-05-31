part of 'internals.dart';

/// A QudsProvider with ability to control the app language.
class QudsTranslationProvider extends QudsProvider {
  /// The language code of the app
  QudsValue<String?> langCode = QudsValue(name: 'lang-code', value: null);

  /// Weather the app theme matches the platform language if supported
  QudsValue<bool?> asPlatform = QudsValue(name: 'as-platform', value: true);

  @override
  List<QudsValue> getValues() => [langCode, asPlatform];
}
