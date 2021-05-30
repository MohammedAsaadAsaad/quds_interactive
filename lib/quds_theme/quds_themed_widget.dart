part of 'internals.dart';

class QudsThemedWidget extends StatelessWidget {
  final Widget Function(BuildContext context, ThemeData theme) builder;
  final ThemeData? theme;

  const QudsThemedWidget({Key? key, this.theme, required this.builder})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    var th = this.theme ?? Theme.of(context);
    return Theme(data: th, child: builder(context, th));
  }
}
