part of 'internals.dart';

class QudsTranslation {
  static QudsLanguage? currLanguage;
  static bool _initialized = false;
  static Map<String, QudsLanguage> languages = {};
  static QudsTranslationProvider provider = QudsTranslationProvider();
  static String? deviceLocaleCode;

  static void _initializeDeviceLocaleCodeUpdater() {
    var platInstance = SchedulerBinding.instance!.window;

    VoidCallback updateOnChange = () {
      if (provider.asPlatform.v != false) {
        var result = getDeviceLocaleCode();
        if (result != provider.langCode.v) setLanguage(result);
      }
    };
    platInstance.onLocaleChanged = updateOnChange;
    provider.addWatcher(updateOnChange);
  }

  static String getDeviceLocaleCode() {
    var result = Platform.localeName;
    return result.split('_')[0]; //en_us -- return just en
  }

  static void initialize(List<String> supportedLanguageCodes,
      {Map<String, Map<String, String>>? additionalDictionaries,
      String? defaultLangCode}) {
    if (_initialized) return;
    _initialized = true;

    languages.clear();

    for (var l in supportedLanguageCodes) {
      _addLanguageByCode(l);
    }

    if (additionalDictionaries != null) {
      for (var l in additionalDictionaries.entries) {
        var lang = getLanguage(l.key);
        if (lang != null) lang.mergeDictionary(l.value);
      }
    }

    setSavedLang(defaultLang: defaultLangCode);
    _initializeDeviceLocaleCodeUpdater();
  }

  static QudsLanguage? getLanguage(String? code) {
    if (code == null) return null;

    var result = languages[code];
    if (result != null) return result;

    var codeParts = code.split('_');
    if (codeParts.length == 0) return null;

    if (codeParts.length == 1)
      for (var l in languages.keys) {
        if (l.split('_')[0].toLowerCase() == code.toLowerCase())
          return languages[l];
      }

    if (codeParts.length == 2)
      for (var l in languages.keys) {
        if (l.toLowerCase() == code.toLowerCase()) return languages[l];
      }
  }

  static void addLanguage(QudsLanguage lang) {
    if (!languages.containsKey(lang.toString()))
      languages[lang.toString()] = lang;
    else
      languages[lang.toString()]!.mergeDictionary(lang.dictionary);
  }

  static _addLanguageByCode(String code) {
    var codeParts = code.split('_');

    String? langCode = codeParts.length > 0 ? codeParts[0].toLowerCase() : null;
    String? countryCode =
        codeParts.length > 1 ? codeParts[1].toUpperCase() : null;

    QudsLanguageDetails? result;
    switch (langCode) {
      case 'ar':
        switch (countryCode) {
          case 'PS':
            result = ArPSLanguageDetails();
            break;
          default:
            result = ArPSLanguageDetails();
            break;
        }
        break;
      case 'en':
        switch (countryCode) {
          case 'US':
            result = EnUSLanguageDetails();
            break;
          default:
            result = EnUSLanguageDetails();
            break;
        }
        break;
      case 'fr':
        switch (countryCode) {
          case 'FR':
            result = FrFrLanguageDetails();
            break;
          default:
            result = FrFrLanguageDetails();
            break;
        }
        break;

      default:
        result = EnUSLanguageDetails();
        break;
    }
    String resultCode = result.toString();
    if (!languages.containsKey(resultCode)) {
      languages[resultCode] = QudsLanguage.fromLanguageDetails(result);
    }
  }

  static bool setLanguage(String code, {VoidCallback? onChanged}) {
    var lang = getLanguage(code.toLowerCase());
    if (lang == null) return false;
    currLanguage = lang;
    provider.langCode.v = lang.langCode;
    onChanged?.call();
    return true;
  }

  static String translate(String key, {String? langCode}) {
    QudsLanguage? lang;

    lang = (langCode == null)
        ? currLanguage
        : getLanguage(langCode) ?? currLanguage;

    return lang == null ? key : lang.translate(key);
  }

  static void setSavedLang({String? defaultLang}) async {
    if (defaultLang == null && provider.langCode.value == null) {
      var currentLocale = getDeviceLocaleCode();
      deviceLocaleCode = currentLocale;
      defaultLang = currentLocale;

      //Check if the system language is embedded in this application,
      //otherwise set the lang to 'en'
      defaultLang = languages.containsKey(defaultLang.toLowerCase())
          ? defaultLang.toLowerCase()
          : 'en';
    } else if (provider.langCode.value != null)
      defaultLang = provider.langCode.value;
    setLanguage(defaultLang ?? 'en');
  }

  static void showLanguagesSelectionBorderSheet(BuildContext context,
      {VoidCallback? onChanged}) {
    showQudsModalBorderSheet(
      context,
      (c) => QudsLanguagesListView(
        onChanged: onChanged,
      ),
      title: QudsProviderWatcher<QudsTranslationProvider>(
          builder: (p) => Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Text(
                'Select language'.tr,
                style: Theme.of(context).textTheme.headline6,
              ))),
    );
  }
}

extension StringExtensions on String {
  ///Translate
  String get tr => translate(this);
}
