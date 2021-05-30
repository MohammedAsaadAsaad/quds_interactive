import 'package:flutter/material.dart';
import 'package:quds_provider/quds_provider.dart';
import '../quds_interactive.dart';

class QudsInteractiveApp extends StatelessWidget {
  final Widget Function(BuildContext context)? builder;
  final ThemeData? theme;

  const QudsInteractiveApp({Key? key, this.builder, this.theme})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return QudsProviderWatcher<QudsThemeProvider>(
        builder: (pTheme) =>
            QudsProviderWatcher<QudsTranslationProvider>(builder: (p) {
              return QudsThemedWidget(
                  theme: theme ??
                      (pTheme == null
                          ? Theme.of(context)
                          : (pTheme.isDark.v
                              ? QudsTheme.darkTheme
                              : QudsTheme.lightTheme)),
                  builder: (c, th) => MaterialApp(
                          localizationsDelegates: [
                            if (QudsTranslation.currLanguage != null)
                              QudsTranslation
                                  .currLanguage!.materialLocalizationsDelegate
                          ],
                          theme: th,
                          key: key,
                          home: builder?.call(context) ?? Container(),
                          builder: (c, w) => QudsTranslated(
                              langCode: p!.langCode.v, child: w!)));
            }));
  }
}
