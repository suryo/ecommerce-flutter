part of core;

class HelperUtils {
  static Color generateRandomColor() {
    return Colors.primaries[Random().nextInt(Colors.primaries.length)];
  }

  static void copyText(String text) {
    Clipboard.setData(ClipboardData(text: text));
  }

  static String shortString(String text) {
    return "${text.substring(0, 5)}...${text.substring(text.length - 4, text.length)}";
  }

  Future<void> launchURL(String url) async {
    await FlutterWebBrowser.openWebPage(
      url: url,
      customTabsOptions: const CustomTabsOptions(
          // toolbarColor: context.theme.primaryColor,
          // colorScheme: CustomTabsColorScheme.dark,
          // secondaryToolbarColor: Colors.green,
          // navigationBarColor: Colors.amber,
          // addDefaultShareMenuItem: true,
          // instantAppsEnabled: true,
          // showTitle: true,
          // urlBarHidingEnabled: true,
          ),
      safariVCOptions: SafariViewControllerOptions(
        // barCollapsingEnabled: true,
        // preferredBarTintColor: context.theme.primaryColor,
        preferredControlTintColor: ThemeData().colorScheme.primary,
        // dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
        // modalPresentationCapturesStatusBarAppearance: true,
      ),
    );
  }

  String chatWA({
    required String title,
    required String noWA, // or 6281280414863
    required String content,
  }) {
    return "https://api.whatsapp.com/send?phone=$noWA&text=$content";
  }

  String? getPhoneCode(String? text) {
    if (text?.contains("(") ?? false) {
      return (text?.isEmpty ?? true) ? null : text?.substring((text.indexOf("(")) + 1, text.indexOf(")")).trim();
    }
    return null;
  }

  String? removePhoneCode(String? text) {
    if (text?.contains("(") ?? false) {
      return (text?.isEmpty ?? true) ? null : text?.replaceRange(text.indexOf("("), (text.indexOf(")")) + 1, "").trim();
    }

    return text;
  }

  String? stringTag(String? text) {
    if (text == null) return null;
    var stringArr = text.trim().toLowerCase().split(" ");
    return stringArr.join("-");
  }

  // Create searchIndex for searching
  List<String> searchIndex(String? text) {
    if (text == null) return [];
    List<String> searchIndex = [];
    var titleArr = text.split(" ");
    for (int i = 0; i < titleArr.length; i++) {
      for (int y = 1; y < titleArr[i].length + 1; y++) {
        var data = titleArr[i].substring(0, y).toLowerCase();
        if (!searchIndex.contains(data)) searchIndex.add(data);
      }
    }
    return searchIndex;
  }
}
