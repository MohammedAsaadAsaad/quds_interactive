part of 'internals.dart';

class QudsThemeProvider extends QudsProvider {
  QudsValue<bool> isDark = QudsValue(name: 'is-dark', value: false);
  QudsValue<bool?> asPlatform = QudsValue(name: 'as-platform', value: true);
  @override
  List<QudsValue> getValues() => [isDark, asPlatform];
}
