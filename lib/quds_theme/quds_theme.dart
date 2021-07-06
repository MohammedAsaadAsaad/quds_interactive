part of 'internals.dart';

/// Control the theme of the app
class QudsTheme {
  static bool _initialized = false;
  static void _initializeUpdater() {
    var platInstance = SchedulerBinding.instance!.window;

    VoidCallback updateOnChange = () {
      if (provider.asPlatform.v != false) {
        var brightness = SchedulerBinding.instance!.window.platformBrightness;
        bool darkModeOn = brightness == Brightness.dark;
        if (provider.isDark.v != darkModeOn) provider.isDark.v = darkModeOn;
      }
    };
    platInstance.onPlatformBrightnessChanged = updateOnChange;
    provider.addWatcher(updateOnChange);
  }

  /// Customize the dark theme of the app
  static ThemeData? darkTheme;

  /// Customize the light theme of the app
  static ThemeData? lightTheme;

  /// Initialize the theme control of the app
  static void initialize(
      {ThemeData? lightThemeData, ThemeData? darkThemeData}) {
    if (_initialized) return;
    _initialized = true;

    if (lightThemeData != null) lightTheme = lightThemeData;
    if (darkThemeData != null) darkTheme = darkThemeData;

    _initializeUpdater();
  }

  /// An instance of the QudsThemeProvider class to control the theme of the app
  static QudsThemeProvider provider = QudsThemeProvider();

  /// Toggle the two themes (light & dark) of the app
  static void toggleTheme({VoidCallback? onChanged}) {
    provider.isDark.v = !provider.isDark.v;
    onChanged?.call();
  }

  /// Show a bottom sheet with ability to change the app theme
  /// `onChanged` A callback function that fired when the app theme is changed
  /// Usually used to save the new theme preferences
  static void showThemesSelectionBorderSheet(BuildContext context,
      {bool autoSave = true, VoidCallback? onChanged}) {
    showQudsModalBorderSheet(
      context,
      (c) => QudsThemesListView(
        onChanged: () async {
          if (autoSave)
            await QudsInteractiveApp.qudsAppController
                .saveStateInSharedPreferences();
          onChanged?.call();
        },
      ),
      title: QudsProviderWatcher<QudsThemeProvider>(
          builder: (p) => Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                QudsAnimatedCombinedIcons(
                    curve: Curves.fastLinearToSlowEaseIn,
                    showStartIcon: p!.isDark.v,
                    duration: Duration(milliseconds: 700),
                    startIcon: Icons.brightness_3_rounded,
                    endIconColor: Colors.black54,
                    endIcon: Icons.brightness_7_rounded),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Select Theme'.tr,
                  style: TextStyle(fontSize: 20),
                )
              ]))),
    );
  }
}
