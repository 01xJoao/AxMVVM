part of axmvvm.bindings;

/// Manages the backing field data for an instance of the BindableBase class.
class FieldManager {
  final List<FieldData> _fieldDataList = <FieldData>[];

  /// Get's the value for a property info on a class instance.
  Object getValue(PropertyInfo propertyInfo) {
    final FieldData fieldData = _getFieldData(propertyInfo);
    return fieldData.value;
  }

  /// Set's a new value for a property info on a class instance.
  void setValue(PropertyInfo propertyInfo, Object value) {
    final FieldData fieldData = _getFieldData(propertyInfo);
    fieldData.value = value;
  }

  FieldData _getFieldData(PropertyInfo propertyInfo) {
    if(!_fieldDataList.any((FieldData fd) => fd.id == propertyInfo.id))
      return _registerPropertyInfo(propertyInfo);
    else
      return _fieldDataList.singleWhere((FieldData fd) => fd.id == propertyInfo.id);
  }

  FieldData _registerPropertyInfo(PropertyInfo propertyInfo) {
    propertyInfo._setIdentifier(_fieldDataList.length);
    final FieldData fieldData = propertyInfo._createFieldData();
    _fieldDataList.add(fieldData);
    return fieldData;
  }
}
