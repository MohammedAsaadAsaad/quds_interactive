part of 'internals.dart';

/// A widget with Language injected in the [BuildContext] arg.
class QudsTranslated extends StatelessWidget {
  /// The child of this widget
  final Widget child;

  /// The language code of the child
  final String? langCode;

  /// Create an instance of [QudsTranslated]
  const QudsTranslated({Key? key, this.langCode, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var l = _lang;
    return _InheritedLanguage(
      child: Directionality(
          child: child, textDirection: l?.textDirection ?? TextDirection.ltr),
      langCode: l.toString(),
    );
  }

  QudsLanguage? get _lang =>
      QudsTranslation.getLanguage(langCode) ?? QudsTranslation.currLanguage;

  /// Get the injected language in the [BuildContext] object
  static T of<T extends QudsLanguage>(BuildContext context) {
    var _inhLang =
        context.dependOnInheritedWidgetOfExactType<_InheritedLanguage>();
    assert(_inhLang != null, 'There is no TranslatedWidget in the upper tree');
    assert(_inhLang!.language != null, 'No such language is supported');
    return _inhLang!.language as T;
  }
}

// ignore: must_be_immutable
class _InheritedLanguage extends InheritedWidget {
  final Widget child;
  final String? langCode;
  QudsLanguage? language;

  _InheritedLanguage({Key? key, required this.langCode, required this.child})
      : super(key: key, child: child) {
    language = QudsTranslation.getLanguage(langCode) ?? currLanguage;
  }

  @override
  bool updateShouldNotify(covariant _InheritedLanguage oldWidget) {
    return this.language != oldWidget.language;
  }
}
