part of axmvvm.bindings;

/// Contains the data backing a PropertyInfo for an instance of a class.
class FieldData {
  final String _name;
  final int _id;
  Object value;

  FieldData(this._name, this._id, this.value);
  
  /// The name of the property.
  String get name => _name;

  /// An id for this FieldData within an instance of a class.
  ///
  /// This field is normally used by the axmvvm framework.
  int get id => _id;
}
