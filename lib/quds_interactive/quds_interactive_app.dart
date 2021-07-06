import 'package:flutter/material.dart';
import 'package:quds_provider/quds_provider.dart';
import '../quds_interactive.dart';

/// A wrap for [MaterialApp] with ability to change language and theme dynamically
class QudsInteractiveApp extends StatelessWidget {
  /// Custom builder for whole app,
  ///
  /// for example:
  /// ```dart
  /// QudsInteractiveApp(
  /// builder: (c) => MyHomePage(),
  /// customBuilder: (c, w) => Column(
  ///    children: [Expanded(child:w??Container()),AdMobContainer()],
  ///  ),
  /// );
  /// ```
  final Widget Function(BuildContext, Widget?)? customBuilder;

  /// Set the material app title
  final String? title;

  /// To generate dynamic title
  final String Function()? generateTitle;

  /// The builder function
  final Widget Function(BuildContext context)? builder;

  /// Custom theme of the app
  final ThemeData? customTheme;

  /// {@macro flutter.widgets.widgetsApp.debugShowCheckedModeBanner}
  final bool debugShowCheckedModeBanner;

  /// Create an instance of [QudsInteractiveApp]
  const QudsInteractiveApp(
      {Key? key,
      this.builder,
      this.title,
      this.generateTitle,
      this.customBuilder,
      this.customTheme,
      this.debugShowCheckedModeBanner = true})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    Widget result = QudsProviderWatcher<QudsThemeProvider>(
        builder: (pTheme) =>
            QudsProviderWatcher<QudsTranslationProvider>(builder: (p) {
              return QudsThemedWidget(
                  theme: customTheme ??
                      (pTheme == null
                          ? Theme.of(context)
                          : (pTheme.isDark.v
                              ? QudsTheme.darkTheme ??
                                  ThemeData(
                                      fontFamily: currentFont,
                                      brightness: Brightness.dark)
                              : QudsTheme.lightTheme ??
                                  ThemeData(
                                      fontFamily: currentFont,
                                      brightness: Brightness.light))),
                  builder: (c, th) => MaterialApp(
                      title: generateTitle != null
                          ? generateTitle!()
                          : this.title ?? '',
                      debugShowCheckedModeBanner: debugShowCheckedModeBanner,
                      localizationsDelegates: [
                        if (QudsTranslation.currLanguage != null)
                          QudsTranslation
                              .currLanguage!.materialLocalizationsDelegate
                      ],
                      theme: th,
                      key: key,
                      home: builder?.call(context) ?? Container(),
                      builder: (c, w) => QudsTranslated(
                          langCode: p!.langCode.v,
                          child: customBuilder == null
                              ? w!
                              : customBuilder!(c, w))));
            }));

    return QudsApp(controller: qudsAppController, child: result);
  }

  //Static members
  static late QudsAppController qudsAppController;

  static Future<void> initialize(
      {List<String>? supportedLanguageCodes,
      Map<String, Map<String, String>>? additionalDictionaries,
      bool restoreSavedPreferences = true,
      String? preferencesEncryptionKey,
      String? preferencesEncryptionIV,
      List<QudsProvider>? additionalProviders,
      String? defaultLangCode,
      String? defaultFont,
      Map<String, String>? customFonts}) async {
    WidgetsFlutterBinding.ensureInitialized();

    qudsAppController = QudsAppController(
        encryptionKey: preferencesEncryptionKey,
        encryptionIV: preferencesEncryptionIV,
        providers: [QudsTranslation.provider, QudsTheme.provider]
          ..addAll(additionalProviders ?? []));

    if (restoreSavedPreferences)
      await qudsAppController.restoreStateInSharedPreferences();

    QudsTranslation.initialize(supportedLanguageCodes ?? [],
        additionalDictionaries: additionalDictionaries,
        defaultLangCode: defaultLangCode,
        defaultFont: defaultFont,
        customFonts: customFonts);

    QudsTheme.initialize();
  }
}
