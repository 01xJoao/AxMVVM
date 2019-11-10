part of axmvvm.bindings;

/// Used to define a property changed listener that sends notifications when
/// particular properties have changed.
typedef PropertyChangedListener = void Function(String propertyName);

abstract class BindableBase {
  FieldManager _fieldManager = FieldManager();
  ObserverList<PropertyChangedListener> _listeners = ObserverList<PropertyChangedListener>();

  /// Returns the current value for a property.
  ///
  /// If the property has not been set, the default value will be returned.
  @protected
  Object getValue(PropertyInfo propertyInfo) {
    return _fieldManager.getValue(propertyInfo);
  }

  /// Set a new value to a property.
  /// 
  /// Updates the listners if the value changes.
  @protected
  void setValue(PropertyInfo propertyInfo, Object value) {
    if (_fieldManager.getValue(propertyInfo) != value) {
      _fieldManager.setValue(propertyInfo, value);
      _notifyPropertyListeners(propertyInfo.name);
    }
  }
  /// Adds a listener that when called returns the string name of a property that has changed as a parameter.
  void addPropertyListener(PropertyChangedListener listener) {
    _listeners.add(listener);
  }

  /// Removes a property listener
  void removePropertyListener(PropertyChangedListener listener) {
    if(_listeners != null)
      _listeners.remove(listener);
  }

  void _notifyPropertyListeners(String propertyName) {
    //notifyListeners();
    if(_listeners != null) {
      final List<PropertyChangedListener> localListeners = List<PropertyChangedListener>.from(_listeners);
      for(void Function(String) listener in localListeners) {
        if(_listeners.contains(listener))
          listener(propertyName);
      }
    }
  }

  /// Check if there is any listners
  bool get hasPropertyListeners => _listeners?.isNotEmpty;

  /// Clears BindableBase
  void dispose() {
    _listeners = null;
    _fieldManager = null;
  }
}