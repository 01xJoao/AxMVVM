part of axmvvm.bindings;

/// Class to expend for all StatelessViews that plan to use data in a viewmodel for display.
///
/// Databinding is not allowed in a StatelessWidget per se as there is no ability to update
/// in either direction. Instead the values in the ViewModel can be retrived and used
/// in construction of the widget.
abstract class AxStatelessView<V extends ViewModel>
    extends StatelessWidget implements ViewModelHolder<V> {

  final V _viewModel;
 
  @mustCallSuper
  AxStatelessView(this._viewModel, {Key key}) : super(key: key) {
    if (_viewModel is! ViewModel)
      throw ArgumentError('AxStatelessView objects must be of type ViewModel');
  }

  /// The class's viewmodel reference.
  @override
  V get viewModel => _viewModel;
  
  /// Builds the presentaiton for the widget.
  @override
  @mustCallSuper
  Widget build(BuildContext context) {
    AxCore.container.getInstance<IMessageService>().publish(Message(Constants.buildContext, context));
    return null;
  }
}