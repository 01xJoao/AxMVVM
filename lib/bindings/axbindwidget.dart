part of axmvvm.bindings;

/// This widget is for setting up bindings.
///
/// Used in axmvvm views, widget and custom widgets.
///
/// All it requires is that the bindings are setup against BinableBase objects
class AxBindWidget<T extends BindableBase> extends StatefulWidget {
  final Widget Function(BuildContext context) builder;
  final List<Bind> bindings;

  const AxBindWidget({@required this.bindings, @required this.builder});

  /// Returns a reference to a BindingWidget based on type.
  ///
  /// This looks up the context for an ancestor that is a BindingWidget of the supplied type.
  static AxBindWidget<T> ofType<T extends BindableBase>(BuildContext context) {
    final Type type = Utilities.typeOf<AxBindWidget<T>>();
    final AxBindWidget<T> bindingWidget = context.ancestorWidgetOfExactType(type) as AxBindWidget<T>;
    
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

  /// Returns a function that can be used with the OnChanged event on many StatefulWidgets.
  ///
  /// Passes any changes made by the user to the viewmodel
  Function getOnChanged(String key, {Object converterParameter}) {
    final Bind binding = _getBind(key);

    if(binding.direction == BindDirection.TwoWay)
      return (Object newValue) => setValue(key, newValue, converterParameter: converterParameter);
    else 
      throw ArgumentError('Bind is not of type TwoWay');
  }

  Bind _getBind(String key) {
    return bindings.singleWhere((Bind b) => b.key == key);
  }

  @override
  _AxBindWidgetState<T> createState() => _AxBindWidgetState<T>(bindings);
}

class _AxBindWidgetState<T> extends State<AxBindWidget<BindableBase>> {
  final List<Bind> _sourceBindings;
  final List<_BindingListener> _bindingListeners = <_BindingListener>[];

  _AxBindWidgetState(this._sourceBindings) {
    final List<BindableBase> addedListeners = <BindableBase>[];
    _sourceBindings.forEach((Bind b) => _createListener(b, addedListeners));
  }

  /// Creates a property listenter for a binding.
  ///
  /// If the bind is to a notification list, a listener is added to that as well.
  void _createListener(Bind binding, List<BindableBase> addedListeners) {
    if (!addedListeners.any((BindableBase b) => b == binding.source)) {
      final Function(String) propertyListener = (String fieldName) {
        final bool bindExists = _sourceBindings.any(
          (Bind b) => b.sourceProperty.name == fieldName && b.source == binding.source);
        if (binding.direction == BindDirection.TwoWay && (fieldName == '' || bindExists))
          if(mounted)
            setState((){});
      };

      binding.source.addPropertyListener(propertyListener);
      _bindingListeners.add(_BindingListener(binding.key, propertyListener, false));

      if (binding.source.getValue(binding.sourceProperty) is NotificationList) {
        final NotificationList<Object> notificationList = binding.source.getValue(binding.sourceProperty) as NotificationList<Object>;
        
        final Function listListener = () {
          if(mounted)
            setState((){});
        };

        notificationList.addListener(listListener);
        _bindingListeners.add(_BindingListener(binding.key, listListener, true));
      }
    }

    addedListeners.add(binding.source);
  }

  @override
  Widget build(BuildContext context) {
    return _BindingContext(widget.builder);
  }
  
  /// Called when the state is disposed.
  ///
  /// All subscriptions for bindings are cancelled.
  @override
  @mustCallSuper
  void dispose() {
    _bindingListeners.forEach((_BindingListener bl) {
      final Bind binding = _sourceBindings.singleWhere((Bind b) => b.key == bl.bindingKey);

      if (bl.isListListener) {
        final NotificationList<Object> notificationList = binding.source.getValue(binding.sourceProperty) as NotificationList<Object>;
        notificationList.removeListener(bl.listener);
      } else {
        binding.source.removePropertyListener(bl.listener);
      }
    });
    super.dispose();
  }
}

/// A context object for use internally by axmvvm for BindingWidgets.
class _BindingContext extends StatelessWidget {
  final Widget Function(BuildContext context) builder;

  const _BindingContext(this.builder);

  @override
  Widget build(BuildContext context) {
    return builder(context);
  }
}

/// A class used to track listeners so they can be removed as part of the dispose method.
class _BindingListener {
  final String _bindingKey;
  final Object _listener;
  final bool _isListListener;

  _BindingListener(this._bindingKey, this._listener, this._isListListener);

  String get bindingKey => _bindingKey;
  Object get listener => _listener;
  bool get isListListener => _isListListener;
}