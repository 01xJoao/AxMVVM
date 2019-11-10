part of axmvvm.models;

class LocalizationHelper {
  String root;
  Locale defaultLocale;
  List<Locale> supportedLocales;
  
  /// [root] for the json files ex: ('lib/res/lang/')
  /// 
  /// The json files must be named as languageCode ex: ('en.json', 'pt.json', ...)
  /// 
  /// First default locale will be the first in [supportedLocales] if [defaultLocale] is not passed
  LocalizationHelper(this.root, this.supportedLocales, {this.defaultLocale});
}