part of 'internals.dart';

class QudsTranslationProvider extends QudsProvider {
  QudsValue<String?> langCode = QudsValue(name: 'lang-code', value: null);
  QudsValue<bool?> asPlatform = QudsValue(name: 'as-platform', value: true);
  // QudsValue<String?> liveCode = QudsValue(serializable: false, name: 'live-code', value: null);

  @override
  List<QudsValue> getValues() => [langCode, asPlatform];
}
