part of '../pre_translated.dart';

class EnUSLanguageDetails extends QudsLanguageDetails {
  @override
  String get abbreviatedName => 'En';

  @override
  String get countryCode => 'US';

  @override
  String get langCode => 'en';

  @override
  TextDirection get textDirection => TextDirection.ltr;

  @override
  String get langName => 'English';

  @override
  String get countryName => 'United States';

  @override
  Map<String, String> get dictionary => {
        'back': 'Back',
        'save': 'Save',
        'Change Language': 'Change Language',
        'Select language': 'Select Language',
        'exit': 'Exit',
        'Toggle Theme': 'Toggle Theme',
        //Abbreviated months (3 letters)
        'Jan_abb': 'Jan',
        'Feb_abb': 'Feb',
        'Mar_abb': 'May',
        'Apr_abb': 'Apr',
        'May_abb': 'May',
        'Jun_abb': 'Jun',
        'Jul_abb': 'Jul',
        'Aug_abb': 'Aug',
        'Sep_abb': 'Sep',
        'Oct_abb': 'Oct',
        'Nov_abb': 'Nov',
        'Dec_abb': 'Dec',
        //Abbreviated days (1 letter)
        'Sun_day_abb_1': 'S',
        'Mon_day_abb_1': 'M',
        'Tue_day_abb_1': 'T',
        'Wed_day_abb_1': 'W',
        'Thu_day_abb_1': 'T',
        'Fri_day_abb_1': 'F',
        'Sat_day_abb_1': 'S',
      };
}
