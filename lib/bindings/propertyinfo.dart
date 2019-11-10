part of axmvvm.bindings;

/// Information about a property that can be bound to.
///
/// These are normally static references within a class that inherits from BindableBase.
class PropertyInfo {
  final String _name;
  final Type _type;
  Object _defaultValue;
  int _id = -1;

  /// Creates a new instance of PropertyInfo.
  ///
  /// [_name] - The name of the property, usualle the same as the name of the getter/setter
  /// [_type] - The type of the property.
  /// [_defaultValue] - A default value for the property if it has not been set.
  PropertyInfo(this._name, this._type, [Object defaultValue]) {
    if(defaultValue != null) {
      _defaultValue = defaultValue;
    } else {
      switch (_type) {
        case String: _defaultValue = ''; break;
        case int: _defaultValue = 0; break;
        case double: _defaultValue = 0.0; break;
        case DateTime: _defaultValue = DateTime.fromMicrosecondsSinceEpoch(0); break;
        case bool: _defaultValue = false; break;
        default: _defaultValue = null;
      }
    }
  }

  /// The name of the property.
  String get name => _name;

  /// The type of the property.
  Type get type => _type;

  /// A properties default value.
  ///
  /// Used if the property is called before being explicitly set.
  Object get defaultValue => _defaultValue;

  /// A unique id used by axmvvm to tie this propertyinfo to a backing field in a class instance.
  int get id => _id;

  void setIdentifier(int value) => _id = value;

  /// Used by axmvvm to create backing information for this property info.
  FieldData createFieldData() {
    return FieldData(_name, id, _defaultValue);
  }
}
