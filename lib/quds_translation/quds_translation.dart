part of 'internals.dart';

/// Control the language of the app
class QudsTranslation {
  static QudsLanguage? _currLanguage;

  /// The current language of the app
  static QudsLanguage? get currLanguage => _currLanguage;

  static bool _initialized = false;

  /// The supported languages map in the app
  static Map<String, QudsLanguage> languages = {};

  /// An instance of [QudsTranslationProvider] to control the language and
  /// notify if changed
  static QudsTranslationProvider provider = QudsTranslationProvider();

  static String? _deviceLocaleCode;

  /// The current device locale code
  static String? get deviceLocaleCode => _deviceLocaleCode;

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

  /// Get the device local code first part,
  /// As example 'en' =>'en'
  /// 'en_US' => 'en'
  static String getDeviceLocaleCode() {
    var result = Platform.localeName;
    return result.split('_')[0]; //en_us -- return just en
  }

  /// Initialize the translation service
  /// `supportedLanguageCodes`: the desired languages of the app
  /// as example `['ar', 'en_US']`
  /// 'additionalDictionaries': Supporting dictionaries for not translated words
  /// as example `['ar': {'hi_message':'أهلًا بك'}]`
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

  /// Get the matching language
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

  /// Add a language to the languages list
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
            result = _ArPSLanguageDetails();
            break;
          default:
            result = _ArPSLanguageDetails();
            break;
        }
        break;
      case 'en':
        switch (countryCode) {
          case 'US':
            result = _EnUSLanguageDetails();
            break;
          default:
            result = _EnUSLanguageDetails();
            break;
        }
        break;
      case 'fr':
        switch (countryCode) {
          case 'FR':
            result = _FrFrLanguageDetails();
            break;
          default:
            result = _FrFrLanguageDetails();
            break;
        }
        break;

      default:
        result = _EnUSLanguageDetails();
        break;
    }
    String resultCode = result.toString();
    if (!languages.containsKey(resultCode)) {
      languages[resultCode] = QudsLanguage.fromLanguageDetails(result);
    }
  }

  /// Set the current language of the app
  /// `code`: The language code, as example 'ar_PS'
  /// `onChanged`: a callback fired when the set language changed
  static bool setLanguage(String code, {VoidCallback? onChanged}) {
    var lang = getLanguage(code.toLowerCase());
    if (lang == null) return false;
    _currLanguage = lang;
    provider.langCode.v = lang.langCode;
    onChanged?.call();
    return true;
  }

  /// Get the `key` corresponding translation, by default, it translate to the
  /// current set language.
  /// `langCode` if a specific language code desired
  static String translate(String key, {String? langCode}) {
    QudsLanguage? lang;

    lang = (langCode == null)
        ? currLanguage
        : getLanguage(langCode) ?? currLanguage;

    return lang == null ? key : lang.translate(key);
  }

  /// Apply the saved language
  static void setSavedLang({String? defaultLang}) async {
    if (defaultLang == null && provider.langCode.value == null) {
      var currentLocale = getDeviceLocaleCode();
      _deviceLocaleCode = currentLocale;
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

  /// Show border modal sheet with translation options
  static void showLanguagesSelectionBorderSheet(BuildContext context,
      {bool autoSave = true, VoidCallback? onChanged}) {
    showQudsModalBorderSheet(
      context,
      (c) => QudsLanguagesListView(
        onChanged: () async {
          if (autoSave)
            await QudsInteractiveApp.qudsAppController
                .saveStateInSharedPreferences();
          onChanged?.call();
        },
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
