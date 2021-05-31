part of 'internals.dart';

/// A list view with the current languages list
class QudsLanguagesListView extends StatefulWidget {
  /// A callback that called if a change of app theme preferences occured
  final VoidCallback? onChanged;

  const QudsLanguagesListView({Key? key, this.onChanged}) : super(key: key);

  @override
  _LanguagesListViewState createState() => _LanguagesListViewState();
}

class _LanguagesListViewState extends State<QudsLanguagesListView>
    with SingleTickerProviderStateMixin {
  List<QudsLanguage> lst = [];

  @override
  void initState() {
    super.initState();
    fillResults();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        QudsCheckboxListTile(
          onChanged: (v) {
            QudsTranslation.provider.asPlatform.v = v;
            widget.onChanged?.call();
          },
          value: QudsTranslation.provider.asPlatform.v ?? true,
          title: Text('As Platform'.tr),
        ),
        AnimatedSize(
            alignment: Alignment.topCenter,
            vsync: this,
            curve: Curves.fastLinearToSlowEaseIn,
            duration: const Duration(milliseconds: 350),
            child: (QudsTranslation.provider.asPlatform.v ?? true)
                ? Container()
                : Column(children: [
                    _buildSearchField(),
                    for (var l in lst)
                      QudsAutoAnimatedOpacity(
                          child: QudsAutoAnimatedSlide(
                              duration: const Duration(milliseconds: 200),
                              xOffset: 0.1,
                              child: ListTile(
                                  onTap: () {
                                    QudsTranslation.setLanguage(l.toString());
                                    widget.onChanged?.call();
                                  },
                                  leading: Container(
                                      width: 40,
                                      alignment: Alignment.center,
                                      child: Image.asset(
                                        'assets/flags/${l.countryCode}.png',
                                        width: 30,
                                        package: 'quds_interactive',
                                      )),
                                  subtitle: Text(l.countryName ?? ''),
                                  title: Text(
                                    l.langName!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(fontSize: 16),
                                  ))))
                  ])),
      ],
    );
  }

  @override
  void dispose() {
    searchController.dispose();

    super.dispose();
  }

  TextEditingController searchController = TextEditingController();

  Widget _buildSearchField() {
    return Container(
      padding: EdgeInsets.all(10),
      width: double.infinity,
      child: TextField(
          autofocus: true,
          style: const TextStyle(height: 1),
          decoration: InputDecoration(
              hintText: 'Search'.tr,
              // contentPadding: EdgeInsets.all(0),
              prefixIcon: Container(
                  width: 30,
                  child: Center(
                      child: QudsAutoAnimatedCombinedIcons(
                          startIcon: Icons.remove, endIcon: Icons.search))),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
          controller: searchController,
          onChanged: (v) => fillResults()),
    );
  }

  void fillResults() {
    String str = searchController.text.trim().toLowerCase();
    lst.clear();

    for (var l in QudsTranslation.languages.values)
      if (_contains(l.langName, str) ||
          _contains(l.countryName, str) ||
          _contains(l.countryCode, str) ||
          _contains(l.langCode, str)) lst.add(l);

    if (mounted) setState(() {});
  }

  bool _contains(String? content, String s) =>
      content != null && content.toLowerCase().contains(s);
}
