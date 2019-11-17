part of axmvvm.models;

class LocalizationHelper {
  String pathToJson;
  Locale defaultLocale;
  List<Locale> supportedLocales;
  
  /// [pathToJson] for the json files directory ex: ('lib/res/lang/')
  /// 
  /// The json files must be named as languageCode ex: ('en.json', 'pt.json', ...)
  /// 
  /// First default locale will be the first in [supportedLocales] if [defaultLocale] is null.
  LocalizationHelper(this.pathToJson, this.supportedLocales, {this.defaultLocale});
}