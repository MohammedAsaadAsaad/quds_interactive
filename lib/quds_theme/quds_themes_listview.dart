part of 'internals.dart';

/// A list view with theme options
class QudsThemesListView extends StatefulWidget {
  /// A callback that called if a change of app theme preferences occured
  final VoidCallback? onChanged;

  /// Create an instance of [QudsThemesListView]
  const QudsThemesListView({Key? key, this.onChanged}) : super(key: key);

  @override
  _ThemesListViewState createState() => _ThemesListViewState();
}

class _ThemesListViewState extends State<QudsThemesListView>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        QudsCheckboxListTile(
          onChanged: (v) {
            QudsTheme.provider.asPlatform.v = v;
            widget.onChanged?.call();
          },
          value: QudsTheme.provider.asPlatform.v ?? true,
          title: Text('As Platform'.tr),
        ),
        AnimatedSize(
            curve: Curves.fastLinearToSlowEaseIn,
            duration: const Duration(milliseconds: 350),
            vsync: this,
            child: (QudsTheme.provider.asPlatform.v ?? true)
                ? Container()
                : Column(
                    children: [
                      Divider(
                        height: 1,
                      ),
                      ListTile(
                          leading: Icon(Icons.brightness_5_outlined),
                          title: Text('Light'.tr),
                          onTap: () {
                            QudsTheme.provider.isDark.v = false;
                            widget.onChanged?.call();
                          }),
                      ListTile(
                          leading: Icon(Icons.brightness_3_rounded),
                          title: Text('Dark'.tr),
                          onTap: () {
                            QudsTheme.provider.isDark.v = true;
                            widget.onChanged?.call();
                          })
                    ],
                  ))
      ],
    );
  }
}
