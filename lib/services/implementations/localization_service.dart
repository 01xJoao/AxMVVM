part of axmvvm.services;

class LocalizationService extends BindableBase implements ILocalizationService {

  static PropertyInfo localeProperty = PropertyInfo(Constants.locate, Locale, null);
  String get locale => getValue(localeProperty);
  set _locale(Locale locale) => setValue(localeProperty, locale);

  static PropertyInfo localizationReadyProperty = PropertyInfo(Constants.localizationReady, bool, false);
  bool get localization => getValue(localizationReadyProperty);
  set _localization(bool ready) => setValue(localizationReadyProperty, ready);


  @override
  void initialize(String root, List<Locale> supportedLocales) {
  }

  @override
  String currentLanguage() {
    return null;
  }

  @override
  bool isSupported(Locale locale) {
    return null;
  }

  @override
  Future<Location> load(Locale locale) {
    return null;
  }

  @override
  String localize(String key) {
    return null;
  }

  @override
  void setLanguage(String language) {
  }

  @override
  bool shouldReload(LocalizationsDelegate<Location> old) {
    return null;
  }

  @override
  Type get type => null;
}