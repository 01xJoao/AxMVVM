part of axmvvm.bindings;

/// Interface to be implemented by objects that retain references to viewmodels.
abstract class ViewModelHolder<T extends ViewModel> {
  /// The class's viewmodel reference.
  T get viewModel;
}
