part of axmvvm.services;

class LocalizationService extends BindableBase implements ILocalizationService {
  String _root;
  Location _currentLocation;
  List<Locale> _supportedLocales;

  static PropertyInfo localeProperty = PropertyInfo(Constants.locate, Locale, null);
  String get locale => getValue(localeProperty);
  set _locale(Locale locale) => setValue(localeProperty, locale);

  static PropertyInfo localizationReadyProperty = PropertyInfo(Constants.localizationReady, bool, false);
  bool get localization => getValue(localizationReadyProperty);
  set _localization(bool ready) => setValue(localizationReadyProperty, ready);

  @override
  void initialize(String root, List<Locale> supportedLocales){
    try {
      _supportedLocales = supportedLocales;
      _root = root;
    } catch (e) {
      throw ArgumentError(e.toString());
    }
  } 

  @override
  String currentLanguage() => _currentLocation?.locale?.languageCode;

  @override
  String localize(String key) => _currentLocation?.locate(key);

  @override
  Future<Location> load(Locale locale) async {
    try {
      _currentLocation = Location(locale);
      await _currentLocation.loadLocalizedValues(_root);
      return _currentLocation;
    } catch (e) {
      throw ArgumentError(e.toString());
    } finally {
      _localization = true;
    }
  }

  @override
  void setLanguage(String language) {
    try {
      for (Locale supportedLocale in _supportedLocales) {
        if (supportedLocale.languageCode == language){
          _locale = supportedLocale;
          break;
        }
      }
    } catch (e) {
      throw ArgumentError(e.toString());
    }
  }

  @override
  bool isSupported(Locale locale) => true;

  @override
  bool shouldReload(LocalizationsDelegate<Location> old) => true;

  @override
  Type get type => null;
}