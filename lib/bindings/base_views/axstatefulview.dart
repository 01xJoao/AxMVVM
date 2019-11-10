part of axmvvm.bindings;

/// Class to expend for all AxStatefulView that plan to use databinding and be bound to a viewmodel.
abstract class AxStatefulView<V extends ViewModel>
    extends StatefulWidget implements ViewModelHolder<V> {
  
  final V _viewModel;
  final Map<String, bool> _isBottomView = <String, bool>{};

  @mustCallSuper
  AxStatefulView(this._viewModel, {bool isBottomNavigationView, Key key}) : super(key: key) {
    _isBottomView['isBottomNavigationView'] = isBottomNavigationView;
  }

  /// The class's viewmodel reference.
  @override
  V get viewModel => _viewModel;

  /// If this is a bottom naviation view.
  bool get isBottomNavigationView => _isBottomView['isBottomNavigationView'] ?? false;
}