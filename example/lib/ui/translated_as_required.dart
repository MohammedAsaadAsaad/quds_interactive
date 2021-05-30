import 'package:flutter/material.dart';
import 'package:quds_interactive/quds_interactive.dart';

class TranslatedAsRequired extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var lang = QudsTranslated.of(context);
    return Text(lang.translate('hi_message'));
  }
}
