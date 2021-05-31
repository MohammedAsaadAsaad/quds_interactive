part of 'internals.dart';

/// Similar to Theme widget with custom builder
class QudsThemedWidget extends StatelessWidget {
  /// The child builder of this [QudsThemedWidget]
  /// `theme`: The theme passed to the builder
  final Widget Function(BuildContext context, ThemeData theme) builder;
  final ThemeData? theme;

  /// Create an instance of [QudsThemedWidget]
  const QudsThemedWidget({Key? key, this.theme, required this.builder})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    var th = this.theme ?? Theme.of(context);
    return Theme(data: th, child: builder(context, th));
  }
}
