part of 'internals.dart';

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

  static ThemeData darkTheme = ThemeData.dark();
  static ThemeData lightTheme = ThemeData.light();

  static void initialize(
      {ThemeData? lightThemeData, ThemeData? darkThemeData}) {
    if (_initialized) return;
    _initialized = true;

    if (lightThemeData != null) lightTheme = lightThemeData;
    if (darkThemeData != null) darkTheme = darkThemeData;

    _initializeUpdater();
  }

  static QudsThemeProvider provider = QudsThemeProvider();
  static void toggleTheme({VoidCallback? onChanged}) {
    provider.isDark.v = !provider.isDark.v;
    onChanged?.call();
  }

  static void showThemesSelectionBorderSheet(BuildContext context,
      {VoidCallback? onChanged}) {
    showQudsModalBorderSheet(
      context,
      (c) => QudsThemesListView(
        onChanged: onChanged,
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
