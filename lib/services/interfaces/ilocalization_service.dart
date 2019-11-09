part of axmvvm.services;

abstract class ILocalizationService extends LocalizationsDelegate<Location> {
  void initialize(String root, List<Locale> supportedLocales);
  void setLanguage(String language);
  String currentLanguage();
  String localize(String key);
}