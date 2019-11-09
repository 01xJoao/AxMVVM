part of axmvvm.utilities;

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
