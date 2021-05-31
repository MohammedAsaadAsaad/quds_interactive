import 'package:example/translations/en.dart';
import 'package:example/ui/main_app_lang.dart';
import 'package:flutter/material.dart';
import 'package:quds_interactive/quds_interactive.dart';
import 'package:quds_ui_kit/quds_ui_kit.dart';
import 'translations/ar.dart';
import 'ui/translated_as_required.dart';

void main() async {
  await QudsInteractiveApp.initialize(
      supportedLanguageCodes: ['en', 'ar_ps', 'fr'],
      additionalDictionaries: {'ar': arabicSupport, 'en': englishSupport});

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return QudsInteractiveApp(
      debugShowCheckedModeBanner: false,
      builder: (c) => MyHomePage(title: 'Test Translation'.tr),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () => Navigator.push(
                    context,
                    QudsZoomPageRoute(
                        zoomType: ZoomType.Out,
                        builder: (c) => MyHomePage(title: 'Another Page'))),
                icon: Icon(Icons.arrow_forward_rounded))
          ],
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
            child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Text(
                'Current Language'.tr,
              ),
              Text(
                currentLanguage?.langName ?? '',
                style: Theme.of(context).textTheme.headline4,
              ),
              Divider(),
              MainAppLang(),
              Divider(
                height: 30,
              ),
              Text('English'),
              QudsTranslated(langCode: 'en', child: TranslatedAsRequired()),
              Divider(),
              Text('العربية'),
              QudsTranslated(langCode: 'ar', child: TranslatedAsRequired()),
            ],
          ),
        )),
        floatingActionButton: _buildFloatingButton());
  }

  Widget _buildFloatingButton() =>
      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        FloatingActionButton(
          heroTag: 'btn1',
          onPressed: () => QudsTranslation.showLanguagesSelectionBorderSheet(
            context,
          ),
          tooltip: 'Change Language'.tr,
          child: Icon(Icons.language),
        ),
        SizedBox(
          width: 10,
        ),
        FloatingActionButton(
          heroTag: 'btn2',
          onPressed: () => QudsTheme.showThemesSelectionBorderSheet(
            context,
          ),
          tooltip: 'Toggle Theme'.tr,
          child: QudsAnimatedCombinedIcons(
            startIcon: Icons.brightness_5_outlined,
            endIcon: Icons.brightness_3_rounded,
            showStartIcon: !QudsTheme.provider.isDark.value,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        ElevatedButton(
            onPressed: () => showDatePicker(
                context: context,
                initialDate: DateTime(2000),
                firstDate: DateTime(1990),
                lastDate: DateTime.now()),
            child: Text('Date'.tr))
      ]);
}
