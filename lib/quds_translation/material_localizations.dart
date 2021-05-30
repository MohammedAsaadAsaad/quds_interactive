part of 'internals.dart';

class _LanguageMaterialLocalizations extends DefaultMaterialLocalizations {
  _LanguageMaterialLocalizations();
  @override
  String get openAppDrawerTooltip => 'Open navigation menu'.tr;

  @override
  String get backButtonTooltip => 'Back'.tr;

  @override
  String get closeButtonTooltip => 'Close'.tr;

  @override
  String get deleteButtonTooltip => 'Delete'.tr;

  @override
  String get moreButtonTooltip => 'More'.tr;

  @override
  String get nextMonthTooltip => 'Next month'.tr;

  @override
  String get previousMonthTooltip => 'Previous month'.tr;

  @override
  String get nextPageTooltip => 'Next page'.tr;

  @override
  String get previousPageTooltip => 'Previous page'.tr;

  @override
  String get firstPageTooltip => 'First page'.tr;

  @override
  String get lastPageTooltip => 'Last page'.tr;

  @override
  String get showMenuTooltip => 'Show menu'.tr;

  @override
  String get drawerLabel => 'Navigation menu'.tr;

  @override
  String get popupMenuLabel => 'Popup menu'.tr;

  @override
  String get dialogLabel => 'Dialog'.tr;

  @override
  String get alertDialogLabel => 'Alert'.tr;

  @override
  String get searchFieldLabel => 'Search'.tr;

  @override
  String get licensesPageTitle => 'Licenses'.tr;

  @override
  String get cancelButtonLabel => 'CANCEL'.tr;

  @override
  String get closeButtonLabel => 'CLOSE'.tr;

  @override
  String get continueButtonLabel => 'CONTINUE'.tr;

  @override
  String get copyButtonLabel => 'Copy'.tr;

  @override
  String get cutButtonLabel => 'Cut'.tr;

  @override
  String get okButtonLabel => 'OK'.tr;

  @override
  String get pasteButtonLabel => 'Paste'.tr;

  @override
  String get selectAllButtonLabel => 'Select all'.tr;

  @override
  String get viewLicensesButtonLabel => 'VIEW LICENSES'.tr;

  @override
  String get anteMeridiemAbbreviation => 'AM'.tr;

  @override
  String get postMeridiemAbbreviation => 'PM'.tr;

  @override
  String get timePickerHourModeAnnouncement => 'Select hours'.tr;

  @override
  String get timePickerMinuteModeAnnouncement => 'Select minutes'.tr;

  @override
  String get modalBarrierDismissLabel => 'Dismiss'.tr;

  @override
  String get signedInLabel => 'Signed in'.tr;

  @override
  String get hideAccountsLabel => 'Hide accounts'.tr;

  @override
  String get showAccountsLabel => 'Show accounts'.tr;

  @override
  String get reorderItemUp => 'Move up'.tr;

  @override
  String get reorderItemDown => 'Move down'.tr;

  @override
  String get reorderItemLeft => 'Move left'.tr;

  @override
  String get reorderItemRight => 'Move right'.tr;

  @override
  String get reorderItemToEnd => 'Move to the end'.tr;

  @override
  String get reorderItemToStart => 'Move to the start'.tr;

  @override
  String get expandedIconTapHint => 'Collapse'.tr;

  @override
  String get collapsedIconTapHint => 'Expand'.tr;

  @override
  String get refreshIndicatorSemanticLabel => 'Refresh'.tr;

  @override
  String get selectYearSemanticsLabel => 'Select year'.tr;

  @override
  String get unspecifiedDate => 'Date'.tr;

  @override
  String get unspecifiedDateRange => 'Date Range'.tr;

  @override
  String get dateInputLabel => 'Enter Date'.tr;

  @override
  String get dateRangeStartLabel => 'Start Date'.tr;

  @override
  String get dateRangeEndLabel => 'End Date'.tr;

  @override
  String get invalidDateFormatLabel => 'Invalid date format.'.tr;

  @override
  String get invalidDateRangeLabel => 'Invalid date range.'.tr;

  @override
  String get dateOutOfRangeLabel => 'Out of range.'.tr;

  @override
  String get saveButtonLabel => 'SAVE'.tr;

  @override
  String get datePickerHelpText => 'SELECT DATE'.tr;

  @override
  String get dateRangePickerHelpText => 'SELECT RANGE'.tr;

  @override
  String get calendarModeButtonLabel => 'Switch to calendar'.tr;

  @override
  String get inputDateModeButtonLabel => 'Switch to input'.tr;

  @override
  String get timePickerDialHelpText => 'SELECT TIME'.tr;

  @override
  String get timePickerInputHelpText => 'ENTER TIME'.tr;

  @override
  String get timePickerHourLabel => 'Hour'.tr;

  @override
  String get timePickerMinuteLabel => 'Minute'.tr;

  @override
  String get invalidTimeLabel => 'Enter a valid time'.tr;

  @override
  String get dialModeButtonLabel => 'Switch to dial picker mode'.tr;

  @override
  String get inputTimeModeButtonLabel => 'Switch to text input mode'.tr;

  /// Returns the number of days in a month, according to the proleptic
  /// Gregorian calendar.
  ///
  /// This applies the leap year logic introduced by the Gregorian reforms of
  /// 1582. It will not give valid results for dates prior to that time.
  int _getDaysInMonth(int year, int month) {
    if (month == DateTime.february) {
      final bool isLeapYear =
          (year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0);
      if (isLeapYear) return 29;
      return 28;
    }
    const List<int> daysInMonth = <int>[
      31,
      -1,
      31,
      30,
      31,
      30,
      31,
      31,
      30,
      31,
      30,
      31
    ];
    return daysInMonth[month - 1];
  }

  @override
  String formatHour(TimeOfDay timeOfDay, {bool alwaysUse24HourFormat = false}) {
    final TimeOfDayFormat format =
        timeOfDayFormat(alwaysUse24HourFormat: alwaysUse24HourFormat);
    switch (format) {
      case TimeOfDayFormat.h_colon_mm_space_a:
        return formatDecimal(
            timeOfDay.hourOfPeriod == 0 ? 12 : timeOfDay.hourOfPeriod);
      case TimeOfDayFormat.HH_colon_mm:
        return _formatTwoDigitZeroPad(timeOfDay.hour);
      default:
        throw AssertionError('$runtimeType does not support $format.');
    }
  }

  /// Formats [number] using two digits, assuming it's in the 0-99 inclusive
  /// range. Not designed to format values outside this range.
  String _formatTwoDigitZeroPad(int number) {
    assert(0 <= number && number < 100);

    if (number < 10) return '0$number';

    return '$number';
  }

  @override
  String formatMinute(TimeOfDay timeOfDay) {
    final int minute = timeOfDay.minute;
    return minute < 10 ? '0$minute' : minute.toString();
  }

  @override
  String formatYear(DateTime date) => date.year.toString();

  @override
  String formatCompactDate(DateTime date) {
    // Assumes US mm/dd/yyyy format
    final String month = _formatTwoDigitZeroPad(date.month);
    final String day = _formatTwoDigitZeroPad(date.day);
    final String year = date.year.toString().padLeft(4, '0');
    return '$month/$day/$year';
  }

  @override
  String formatShortDate(DateTime date) {
    final String month = _shortMonths[date.month - DateTime.january];
    return '$month ${date.day}, ${date.year}';
  }

  @override
  String formatMediumDate(DateTime date) {
    final String day = _shortWeekdays[date.weekday - DateTime.monday];
    final String month = _shortMonths[date.month - DateTime.january];
    return '$day, $month ${date.day}';
  }

  @override
  String formatFullDate(DateTime date) {
    final String month = _months[date.month - DateTime.january];
    return '${_weekdays[date.weekday - DateTime.monday]}, $month ${date.day}, ${date.year}';
  }

  @override
  String formatMonthYear(DateTime date) {
    final String year = formatYear(date);
    final String month = _months[date.month - DateTime.january];
    return '$month $year';
  }

  @override
  String formatShortMonthDay(DateTime date) {
    final String month = _shortMonths[date.month - DateTime.january];
    return '$month ${date.day}';
  }

  @override
  DateTime? parseCompactDate(String? inputString) {
    if (inputString == null) {
      return null;
    }

    // Assumes US mm/dd/yyyy format
    final List<String> inputParts = inputString.split('/');
    if (inputParts.length != 3) {
      return null;
    }

    final int? year = int.tryParse(inputParts[2], radix: 10);
    if (year == null || year < 1) {
      return null;
    }

    final int? month = int.tryParse(inputParts[0], radix: 10);
    if (month == null || month < 1 || month > 12) {
      return null;
    }

    final int? day = int.tryParse(inputParts[1], radix: 10);
    if (day == null || day < 1 || day > _getDaysInMonth(year, month)) {
      return null;
    }
    return DateTime(year, month, day);
  }

  @override
  List<String> get narrowWeekdays => _narrowWeekdays;

  @override
  int get firstDayOfWeekIndex => 0; // narrowWeekdays[0] is 'S' for Sunday

  @override
  String get dateSeparator => '/';

  @override
  String get dateHelpText => 'mm/dd/yyyy';

  @override
  String dateRangeStartDateSemanticLabel(String fullDate) =>
      'Start date $fullDate';

  @override
  String dateRangeEndDateSemanticLabel(String fullDate) => 'End date $fullDate';

  String _formatDayPeriod(TimeOfDay timeOfDay) {
    switch (timeOfDay.period) {
      case DayPeriod.am:
        return anteMeridiemAbbreviation;
      case DayPeriod.pm:
        return postMeridiemAbbreviation;
    }
  }

  @override
  String formatDecimal(int number) {
    if (number > -1000 && number < 1000) return number.toString();

    final String digits = number.abs().toString();
    final StringBuffer result = StringBuffer(number < 0 ? '-' : '');
    final int maxDigitIndex = digits.length - 1;
    for (int i = 0; i <= maxDigitIndex; i += 1) {
      result.write(digits[i]);
      if (i < maxDigitIndex && (maxDigitIndex - i) % 3 == 0) result.write(',');
    }
    return result.toString();
  }

  @override
  String formatTimeOfDay(TimeOfDay timeOfDay,
      {bool alwaysUse24HourFormat = false}) {
    // Not using intl.DateFormat for two reasons:
    //
    // - DateFormat supports more formats than our material time picker does,
    //   and we want to be consistent across time picker format and the string
    //   formatting of the time of day.
    // - DateFormat operates on DateTime, which is sensitive to time eras and
    //   time zones, while here we want to format hour and minute within one day
    //   no matter what date the day falls on.
    final StringBuffer buffer = StringBuffer();

    // Add hour:minute.
    buffer
      ..write(
          formatHour(timeOfDay, alwaysUse24HourFormat: alwaysUse24HourFormat))
      ..write(':')
      ..write(formatMinute(timeOfDay));

    if (alwaysUse24HourFormat) {
      // There's no AM/PM indicator in 24-hour format.
      return '$buffer';
    }

    // Add AM/PM indicator.
    buffer..write(' ')..write(_formatDayPeriod(timeOfDay));
    return '$buffer';
  }

  @override
  String licensesPackageDetailText(int licenseCount) {
    assert(licenseCount >= 0);
    switch (licenseCount) {
      case 0:
        return 'No licenses.';
      case 1:
        return '1 license.';
      default:
        return '$licenseCount ' + 'licenses.'.tr;
    }
  }

  @override
  String pageRowsInfoTitle(
      int firstRow, int lastRow, int rowCount, bool rowCountIsApproximate) {
    return rowCountIsApproximate
        ? '$firstRow–$lastRow of about $rowCount'
        : '$firstRow–$lastRow of $rowCount';
  }

  @override
  String get rowsPerPageTitle => 'Rows per page:'.tr;

  @override
  String tabLabel({required int tabIndex, required int tabCount}) {
    assert(tabIndex >= 1);
    assert(tabCount >= 1);
    return 'Tab $tabIndex of $tabCount';
  }

  @override
  String selectedRowCountTitle(int selectedRowCount) {
    switch (selectedRowCount) {
      case 0:
        return 'No items selected';
      case 1:
        return '1 item selected';
      default:
        return '$selectedRowCount ' + 'items selected'.tr;
    }
  }

  @override
  ScriptCategory get scriptCategory => ScriptCategory.englishLike;

  @override
  TimeOfDayFormat timeOfDayFormat({bool alwaysUse24HourFormat = false}) {
    return alwaysUse24HourFormat
        ? TimeOfDayFormat.HH_colon_mm
        : TimeOfDayFormat.h_colon_mm_space_a;
  }

  @override
  String remainingTextFieldCharacterCount(int remaining) {
    switch (remaining) {
      case 0:
        return 'No characters remaining'.tr;
      case 1:
        return '1 character remaining'.tr;
      default:
        return '$remaining ' + 'characters remaining'.tr;
    }
  }

  // Ordered to match DateTime.monday=1, DateTime.sunday=6
  List<String> get _shortWeekdays => <String>[
        'Mon'.tr,
        'Tue'.tr,
        'Wed'.tr,
        'Thu'.tr,
        'Fri'.tr,
        'Sat'.tr,
        'Sun'.tr,
      ];

  // Ordered to match DateTime.monday=1, DateTime.sunday=6
  List<String> get _weekdays => <String>[
        'Monday'.tr,
        'Tuesday'.tr,
        'Wednesday'.tr,
        'Thursday'.tr,
        'Friday'.tr,
        'Saturday'.tr,
        'Sunday'.tr,
      ];

  List<String> get _narrowWeekdays => <String>[
        'Sun_day_abb_1'.tr,
        'Mon_day_abb_1'.tr,
        'Tue_day_abb_1'.tr,
        'Wed_day_abb_1'.tr,
        'Thu_day_abb_1'.tr,
        'Fri_day_abb_1'.tr,
        'Sat_day_abb_1'.tr,
      ];

  List<String> get _shortMonths => <String>[
        'Jan_abb'.tr,
        'Feb_abb'.tr,
        'Mar_abb'.tr,
        'Apr_abb'.tr,
        'May_abb'.tr,
        'Jun_abb'.tr,
        'Jul_abb'.tr,
        'Aug_abb'.tr,
        'Sep_abb'.tr,
        'Oct_abb'.tr,
        'Nov_abb'.tr,
        'Dec_abb'.tr,
      ];

  List<String> get _months => <String>[
        'January'.tr,
        'February'.tr,
        'March'.tr,
        'April'.tr,
        'May'.tr,
        'June'.tr,
        'July'.tr,
        'August'.tr,
        'September'.tr,
        'October'.tr,
        'November'.tr,
        'December'.tr,
      ];
}

class _MaterialLocalizationsDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const _MaterialLocalizationsDelegate();
  @override
  Future<_LanguageMaterialLocalizations> load(Locale locale) {
    return SynchronousFuture(_LanguageMaterialLocalizations());
  }

  @override
  bool shouldReload(_MaterialLocalizationsDelegate old) => false;
  @override
  bool isSupported(Locale locale) => true;
}
