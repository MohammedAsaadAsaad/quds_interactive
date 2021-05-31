# Quds Interactive
An easy localization (with customizing), with dynamic theme!

## Why Quds Interactive?
Every app today should considers two factors:
* User language.
* Device brightness mode.

This library introduce  a simple way to control those factors with saving, restoring preferences.

## How to use?
### Initializing:
```
void main() async{
  
   await QudsInteractiveApp.initialize(
      supportedLanguageCodes: ['en', 'ar_ps', 'fr'],);


     // Then run your app
     runApp(MyApp());

}
```


### Wrapping the app in QudsInteractiveApp
```
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return QudsInteractiveApp(
          builder: (c) => MyHomePage(title: 'Test Translation'.tr),
        );
  }
}
```


* QudsInteractiveApp
used to apply the changes to the app.

<br>

* To Translate
```
Text('hi_message'.tr); // <- Translate to the default selected language.
```


* Translated (Widget)
To translate to custome lang (Not the default)

```
Translated(langCode:'ar', child:CustomWidget() );

class CustomWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var lang = QudsTranslated.of(context);
    return Text(lang.translate('hi_message'));
  }
}
```

### How to support additional translations?
In initializing, you can add more specific translations,
```
      await QudsInteractiveApp.initialize(
      supportedLanguageCodes: ['en', 'ar_ps', 'fr'],
      additionalDictionaries: {'ar': arabicSupport, 'en': englishSupport});
```

ar.dart
```
var arabicSupport = {
  'app_title': 'عنوان التطبيق',
  'Test Translation': 'تجربة الترجمة',
  'hi_message': 'أهلًا أخي'
};
```

en.dart
```
var englishSupport = {
    'app_title': 'App title',
     'hi_message': 'Hi Bro!'
     };
```

![](https://github.com/MohammedAsaadAsaad/quds_interactive/blob/master/screenshots/1.png?raw=true)
![](https://github.com/MohammedAsaadAsaad/quds_interactive/blob/master/screenshots/2.png?raw=true)


### How to change the selected language and theme?
By default the default language will be the device language, and the brightness will have the default device option.
To change the translation:
```
QudsTranslation.setLanguage('en', onChanged:(){

});

```

To toggle the theme:
```
QudsTheme.toggleTheme();
```

The package provides simple ui to change the current language and theme:

```
    // To change the translation
    QudsTranslation.showLanguagesSelectionBorderSheet(context,
        onChanged: () {});

    // To change the theme
    QudsTheme.showThemesSelectionBorderSheet(context,
        onChanged: () {});
```


![](https://github.com/MohammedAsaadAsaad/quds_interactive/blob/master/screenshots/3.png?raw=true)

![](https://github.com/MohammedAsaadAsaad/quds_interactive/blob/master/screenshots/4.PNG?raw=true)
