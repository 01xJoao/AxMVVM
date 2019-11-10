part of axmvvm.bindings;

/// Class to expend for all StatelessWidgets that plan to use data in a bindablemodel for display.
///
/// Databinding is not allowed in a StatelessWidget per se as there is no ability to update
/// in either direction. Instead the values in the BindableBase can be retrived and used in construction of the widget.
abstract class AxStatelessWidget<B extends BindableBase> 
  extends StatelessWidget implements BindableModelHolder<B> {
  final B _bindableModel;
  
  @mustCallSuper
  AxStatelessWidget(this._bindableModel, {Key key}) : super(key: key) {
    if (_bindableModel is! BindableBase)
      throw ArgumentError('AxStatelessWidget objects must be of type BindableBase');
  }

  /// The class's bindablebase reference.
  @override
  B get bindableModel => _bindableModel;
}
