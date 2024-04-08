part of core;

extension BuildContextExtension on BuildContext {
  ModalRoute<dynamic>? get modalRoute => ModalRoute.of(this);

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  double get screenWidth => MediaQuery.of(this).size.width;

  double get screenHeight => MediaQuery.of(this).size.height;

  ThemeData get theme => Theme.of(this);

  void maybePop<T extends Object?>([T? result]) async {
    if (!canPop()) return;
    return pop<T>(result);
  }

  // AppLocalization getLocalization() => AppLocalization.of(this)!;

  // AppLocalization get dict => AppLocalization.of(this)!;

  void dismissFocus() {
    final currentFocus = FocusScope.of(this);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  bool isVisible() {
    // Find the object which has the focus
    final object = findRenderObject();

    final viewport = RenderAbstractViewport.maybeOf(object);

    // If we are not working in a Scrollable, skip this routine
    if (viewport == null) {
      return false;
    }

    // Get the Scrollable state (in order to retrieve its offset)
    final scrollableState = Scrollable.maybeOf(this);

    // If Scrollable is null, skip this routine
    if (scrollableState == null) {
      return false;
    }

    // Get its offset
    final position = scrollableState.position;

    if (position.pixels > viewport.getOffsetToReveal(object!, 0.0).offset) {
      return false;
    } else if (position.pixels < viewport.getOffsetToReveal(object, 1.0).offset) {
      return false;
    } else {
      return true;
    }
  }
}
