part of axmvvm.bindings;

/// Contains the data backing a PropertyInfo for an instance of a class.
class FieldData {
  final Object _value;
  final String _name;
  final int _id;

  FieldData(this._name, this._id, this._value);
  
  /// The name of the property.
  String get name => _name;

  /// An id for this FieldData within an instance of a class.
  ///
  /// This field is normally used by the axmvvm framework.
  int get id => _id;

  /// The current value of the property.
  Object get value => _value;
}
