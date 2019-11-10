part of axmvvm.bindings;

/// Interface to be implemented by objects that retain references to models.
abstract class BindableModelHolder<T extends BindableBase> {
  /// The class's model reference.
  T get bindableModel;
}
