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

  /// Call this method on top of the widget tree to call viewmodel's close method when pressing back button
  /// 
  /// This will remove the swipe back gesture
  Widget handleBackButton({Widget view}){
    return WillPopScope(
      onWillPop: () async { 
        _viewModel.close();
        return false;
      },
      child: view ?? const SizedBox(),
    );
  } 
}