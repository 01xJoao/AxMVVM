part of axmvvm.services;

class LocalizationService implements ILocalizationService {

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