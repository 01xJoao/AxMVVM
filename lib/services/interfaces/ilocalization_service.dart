part of axmvvm.services;

/// Interface for the localization service for use by viewmodels.
///
/// An implementation of this class is the basis to glabalizing the application.
abstract class ILocalizationService extends LocalizationsDelegate<Location> {
  /// Initialize the service by giving the root for the json l10n files.
  void initialize(String root, List<Locale> supportedLocales);

  /// Set a different language of the system prefferred language.
  void setLanguage(String language);

  /// Get the current language used by the application.
  String currentLanguage();

  /// Get a localized word with the given [key]
  String localize(String key);
}