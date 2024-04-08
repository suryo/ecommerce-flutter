part of core;

class DialogUtils {
  static const DialogTransitionType animationType = DialogTransitionType.slideFromBottom;

  static Future<void> messageSuccess(
    BuildContext context, {
    String? title,
    required String message,
    Duration? duration,
  }) async {
    // await ProgressUtils.hide();

    final snackBar = SnackBar(
      /// need to set following properties for best effect of awesome_snackbar_content
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: title ?? 'Success',
        message: message,

        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
        contentType: ContentType.success,
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static Future<void> messageError(BuildContext context,
      {String? title, required String message, Duration? duration}) async {
    debugPrint("[ERROR] : ${message.toString()}");
    // await ProgressUtils.hide();

    final snackBar = SnackBar(
      /// need to set following properties for best effect of awesome_snackbar_content
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: title ?? 'Error',
        message: message,

        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
        contentType: ContentType.failure,
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static Future<T?> info<T>(
    BuildContext context, {
    String? title,
    String? content,
    String? lottiePath,
    EdgeInsets? lottiePadding,
    String? labelButton,
    Function()? onClicked,
    Widget? customWidget,
    bool isBackAfterYes = true,
    EdgeInsets? insetPadding,
  }) async {
    return await showAnimatedDialog(
      context: context,
      barrierDismissible: true,
      animationType: animationType,
      curve: Curves.ease,
      // curve: Curves.fastOutSlowIn,
      barrierColor: Colors.black.withOpacity(0.8),
      builder: (_) => InfoDialog(
        title: title,
        content: content,
        lottiePath: lottiePath,
        lottiePadding: lottiePadding,
        padding: insetPadding,
        labelButton: labelButton,
        customWidget: customWidget,
        onPressed: () {
          if (isBackAfterYes) context.maybePop();
          if (onClicked != null) onClicked();
        },
      ),
    );
  }

  static Future<T?> confirm<T>(
    BuildContext context, {
    String? title,
    String? content,
    String? lottiePath,
    String? labelNoButton,
    Function()? onNoClicked,
    String? labelYesButton,
    Function()? onYesClicked,
    Widget? customWidget,
    bool isBackAfterYes = true,
    EdgeInsets? insetPadding,
  }) async {
    return await showAnimatedDialog(
      context: context,
      barrierDismissible: true,
      animationType: animationType,
      curve: Curves.ease,
      // curve: Curves.fastOutSlowIn,
      barrierColor: Colors.black.withOpacity(0.8),
      builder: (_) => ConfirmDialog(
        title: title,
        content: content,
        insetPadding: insetPadding,
        lottiePath: lottiePath,
        customWidget: customWidget,
        labelLeftButton: labelYesButton,
        onLeftPressed: () {
          if (isBackAfterYes) context.maybePop();
          if (onYesClicked != null) onYesClicked();
        },
        labelRightButton: labelNoButton,
        onRightPressed: () {
          context.maybePop();
          if (onNoClicked != null) onNoClicked();
        },
      ),
    );
  }
}
