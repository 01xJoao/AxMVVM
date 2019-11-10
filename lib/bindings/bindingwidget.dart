part of axmvvm.bindings;

/// This widget is for setting up bindings.
///
/// Used in axmvvm views, widget and custom widgets.
///
/// All it requires is that the bindings are setup against BinableBase objects
class BindingWidget<T extends BindableBase> extends StatefulWidget {
  final Widget Function(BuildContext context) builder;
  final List<Bind> bindings;

  const BindingWidget({@required this.bindings, @required this.builder});

  @override
  State<StatefulWidget> createState() {
    return null;
  }

  /// Returns a reference to a BindingWidget based on type.
  ///
  /// This looks up the context for an ancestor that is a BindingWidget of the supplied type.
  static BindingWidget<T> ofType<T extends BindableBase>(BuildContext context) {
    final Type type = Utilities.typeOf<BindingWidget<T>>();
    final BindingWidget<T> bindingWidget = context.ancestorWidgetOfExactType(type) as BindingWidget<T>;
    
    if (bindingWidget != null)
      return bindingWidget;
    else
      throw ArgumentError('No BindingWidgets found for the specified type.');
  }

    /// Returns the value for a binding.
  ///
  /// This uses the [key] that was set up with the binding. Additionally
  /// a [converterParameter] can be passed that will be send to a value
  /// converter if supplied with the binding.
  Object getValue(String key, {Object converterParameter}) {
    final Bind bind = _getBind(key);
    Object returnValue;
    
    if(bind.direction == BindDirection.OneTime && (bind.value != OriginalValueNeverSet)) {
      returnValue = bind.value;
    } else if (bind.valueConverter == null) {
      returnValue = bind.source.getValue(bind.sourceProperty);
    } else {
      returnValue = bind.valueConverter.convert(
        bind.source, 
        bind.source.getValue(bind.sourceProperty),
        parameter: converterParameter
      );
    }

    if(bind.value == OriginalValueNeverSet && bind.direction == BindDirection.OneTime)
      bind.value = returnValue;

    return returnValue;
  }

  /// Sets a value back into the BindableBase object.
  ///
  /// This uses the [key] that was set up with the binding. Additionally
  /// a [converterParameter] can be passed that will be send to a value
  /// converter if supplied with the binding. The [value] is the new value to
  /// set into the property specified by the binding.
  void setValue(String key, Object value, {Object converterParameter}) {
    final Bind binding = _getBind(key);

    if (binding.valueConverter == null) {
      binding.source.setValue(binding.sourceProperty, value);
    } else {
      binding.source.setValue(
        binding.sourceProperty,
        binding.valueConverter.convertBack(binding.source, value,
        parameter: converterParameter)
      );
    }
  }

  Bind _getBind(String key) {
    return bindings.singleWhere((Bind b) => b.key == key);
  }

}