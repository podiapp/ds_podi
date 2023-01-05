part of '../utils.dart';

///Inicia a transição de página com animação de FadeInOut
class FadePageRoute<T> extends PageRoute<T> {
  final Widget? page;
  final RouteSettings settings;

  FadePageRoute({this.page, required this.settings}) : super(settings: settings);

  @override
  Color get barrierColor => Colors.transparent;

  @override
  String? get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) =>
      FadeTransition(opacity: animation, child: page);

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => Duration(milliseconds: 300);
}
