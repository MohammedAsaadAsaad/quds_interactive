import 'package:flutter/material.dart';
import 'package:quds_provider/quds_provider.dart';
import '../quds_interactive.dart';

/// A wrap for [MaterialApp] with ability to change language and theme dynamically
class QudsInteractiveApp extends StatelessWidget {
  /// The builder function
  final Widget Function(BuildContext context)? builder;

  /// Custom theme of the app
  final ThemeData? customTheme;

  /// {@macro flutter.widgets.widgetsApp.debugShowCheckedModeBanner}
  final bool debugShowCheckedModeBanner;

  const QudsInteractiveApp(
      {Key? key,
      this.builder,
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
                              ? QudsTheme.darkTheme
                              : QudsTheme.lightTheme)),
                  builder: (c, th) => MaterialApp(
                      debugShowCheckedModeBanner: debugShowCheckedModeBanner,
                      localizationsDelegates: [
                        if (QudsTranslation.currLanguage != null)
                          QudsTranslation
                              .currLanguage!.materialLocalizationsDelegate
                      ],
                      theme: th,
                      key: key,
                      home: builder?.call(context) ?? Container(),
                      builder: (c, w) =>
                          QudsTranslated(langCode: p!.langCode.v, child: w!)));
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
      List<QudsProvider>? additionalProviders}) async {
    WidgetsFlutterBinding.ensureInitialized();

    qudsAppController = QudsAppController(
        encryptionKey: preferencesEncryptionKey,
        encryptionIV: preferencesEncryptionIV,
        providers: [QudsTranslation.provider, QudsTheme.provider]
          ..addAll(additionalProviders ?? []));

    if (restoreSavedPreferences)
      await qudsAppController.restoreStateInSharedPreferences();

    QudsTranslation.initialize(supportedLanguageCodes ?? [],
        additionalDictionaries: additionalDictionaries);

    QudsTheme.initialize();
  }
}
