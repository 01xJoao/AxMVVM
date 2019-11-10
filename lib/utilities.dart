part of axmvvm;

class Utilities {
  /// Returns a type object for a generic.
  static Type typeOf<T>() => T;

  /// Returns a string view name based on a viewmodel type.
  static String getViewFromViewModelType<T extends ViewModel>() {
    final String typeName = Utilities.typeOf<T>().toString();
    return typeName.replaceAll('ViewModel', 'View');
  }
}

/// Contains static variables for items used by axmvvm.
class Constants {
  static const String buildContext = 'BuildContext';
  static const String locate = 'Locale';
  static const String localizationReady = 'LocalizationReady';
}

/// Interface for valueConverters that change data from one format to another and back.
///
/// This is typically used by data binding to convert the value from a bindableBase
/// into a format that is expected by a widget and back again.
abstract class IValueConverter {
  /// Converts data from a BindableBase property into a format usable by a widget.
  Object convert(Object source, Object value, {Object parameter});

  /// Takes data from a widget and converts it into a format that is expected by a BindableBase property.
  Object convertBack(Object source, Object value, {Object parameter});
}

/// Used to tell if a Binding object's original value was ever set.
class OriginalValueNeverSet {}

/// What type of binding to create.
enum Lifestyle { transientRegistration, singletonRegistration }

/// What type of binding to create.
enum BindDirection { OneTime, TwoWay }