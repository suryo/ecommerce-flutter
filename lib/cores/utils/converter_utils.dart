part of core;

class ConverterUtils {
  static String durationToTime(Duration input) {
    return RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$').firstMatch("$input")?.group(1) ?? '$input';
  }

  static String? stringFormatYmd(String? date) {
    if (date == null) {
      return null;
    } else {
      var data = date.split("-");

      if (data.length < 3) data = date.split("/");
      if (data.length < 3) return null;

      var day = data[0];
      var month = data[1];
      var year = data[2];
      return "$year-$month-$day";
    }
  }

  static DateTime? dateFormatYmd(String? dateInput) {
    if (dateInput == null) {
      return null;
    } else {
      try {
        var date = dateInput.split(" ").first;
        var data = date.split("-");

        if (data.length < 3) data = date.split("/");
        if (data.length < 3) return null;

        var day = data[0];
        var month = data[1];
        var year = data[2];

        if (year.length < 4) return DateTime.parse(dateInput);

        return DateTime.parse("$year-$month-$day");
      } catch (e) {
        return null;
      }
    }
  }

  static String? stringFormatDmy(DateTime? date, [String? stringLocale]) {
    return date == null ? null : DateFormat("dd-MM-yyyy", stringLocale).format(date);
  }

  static String? stringFormatDmyHhMmA(DateTime? date, [String? stringLocale]) {
    return date == null ? null : DateFormat("dd-MM-yyyy, hh:mm a", stringLocale).format(date);
  }

  static String? stringFormatDmyHeader(DateTime? date, [String? stringLocale]) {
    return date == null ? null : DateFormat("EEEE, dd MMMM yyyy", stringLocale).format(date);
  }

  static DateTime? dateFormatYmdOnly(DateTime? date) {
    return date == null ? null : DateTime.parse(DateFormat("yyyy-MM-dd").format(date));
  }
}
