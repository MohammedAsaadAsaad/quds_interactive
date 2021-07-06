import 'package:flutter/material.dart';
import 'package:quds_interactive/quds_interactive.dart';
import 'package:quds_ui_kit/quds_ui_kit.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer();
  @override
  Widget build(BuildContext context) {
    return QudsLightDrawer(
      body: Column(
        children: [QudsSelectLanguageListTile(), QudsSelectThemeListTile()],
      ),
    );
  }
}
