part of axmvvm.models;

/// Helper class for translation.
class Location {
  final Locale locale;
  Map<String, String> _localizedValues;

  Location(this.locale);

  Future<void> loadLocalizedValues(String path) async {
    final String data = await rootBundle.loadString('$path${locale.languageCode}.json');
    final dynamic jsonString = json.decode(data);
    _localizedValues = <String, String>{};

    jsonString.forEach((String key, dynamic value) {
      _localizedValues[key] = value.toString();
    });
  }

  String locate(String key) {
    return _localizedValues[key];
  }
}
