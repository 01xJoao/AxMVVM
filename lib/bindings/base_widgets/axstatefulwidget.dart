part of axmvvm.bindings;

// Class to expend for all AxStatefulWidget that plan to use databinding and be bound to a bindablebase.
abstract class AxStatefulWidget<B extends BindableBase> 
  extends StatefulWidget implements BindableModelHolder<B> {
  final B _bindableModel;

  @mustCallSuper
  const AxStatefulWidget(this._bindableModel, {Key key}) : super(key: key);

  /// The class's bindablebase reference.
  @override
  B get bindableModel => _bindableModel;
}
