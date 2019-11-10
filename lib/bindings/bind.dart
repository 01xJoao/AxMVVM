part of axmvvm.bindings;

/// Used for a binding between a widget and a object that implements BindableBase.
///
/// This item is usually created within a axmvvm state object.
class Bind {
  final String _key;
  /// The source bindable base object.
  BindableBase source;
  BindDirection _bindingDirection;
  final PropertyInfo _sourceProperty;
  IValueConverter _valueConverter;
  Object value = OriginalValueNeverSet;

  Bind(this._key, this.source, this._sourceProperty, {BindDirection bindingDirection, IValueConverter valueConverter}) {
    _bindingDirection = bindingDirection ?? BindDirection.TwoWay;
    _valueConverter = valueConverter;
  }

  String get key => _key;

  /// If the binding only happens once or if it is able to be bi-directional.
  BindDirection get direction => _bindingDirection;

  /// The propertyInfo object being bound to on the source.
  PropertyInfo get sourceProperty => _sourceProperty;

  /// An optional value converter to be used if the value needs to be changed when moving back and
  /// forth from the widget to the source.
  IValueConverter get valueConverter => _valueConverter;
}
