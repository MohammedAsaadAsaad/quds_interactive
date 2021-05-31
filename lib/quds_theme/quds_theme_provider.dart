part of 'internals.dart';

/// A QudsProvider with ability to control the theme.
class QudsThemeProvider extends QudsProvider {
  /// The darkness of the app
  QudsValue<bool> isDark = QudsValue(name: 'is-dark', value: false);

  /// Weather the app theme matches the platform brightness
  QudsValue<bool?> asPlatform = QudsValue(name: 'as-platform', value: true);

  @override
  List<QudsValue> getValues() => [isDark, asPlatform];
}
