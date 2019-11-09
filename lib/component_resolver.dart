part of axmvvm;

class ComponentResolver {
  /// Container of dependency registrations.
  static List<DependencyRegistration> _dependencyContainer;

  ComponentResolver() {
    _dependencyContainer ??= <DependencyRegistration>[];
  }
  
  /// Get the instance of a object previously registered in the container.
  T getInstance<T>() {
    final Type targetType = Utilities.typeOf<T>();

    if (!_dependencyContainer.any((DependencyRegistration r) => identical(r.typeRegistered, targetType)))
      throw StateError('The type ' + targetType.toString() + ' is not registered with the IoC container.');

    final DependencyRegistration registration = 
      _dependencyContainer.singleWhere((DependencyRegistration dr) => identical(dr.typeRegistered, targetType));

    if (registration.registrationType == Lifestyle.singletonRegistration)
      return registration.registeredInstance;
    else
      return registration.factoryMethod();
  }

  /// Registers an [instance] of an object of the generic type.
  ///
  /// All calls to resolve based on this type will always return the registered instance (singleton).
  void registerSingleton<T>(T instance) {
    _checkDependencyRegistration<T>();
    _dependencyContainer.add(DependencyRegistration(T, Lifestyle.singletonRegistration, registeredSingleton: instance));
  }

  /// Registers a type that can be resolved.
  ///
  /// The [factoryMethod] is a reference to a function that should create an instance of this type.
  void registerTransient<T>(Function factoryMethod){
    _checkDependencyRegistration<T>();
    _dependencyContainer.add(DependencyRegistration(T, Lifestyle.transientRegistration, registerTransient: factoryMethod));
  }

  /// Removes all registrations from the dependency injection container.
  void resetRegistrations() {
    _dependencyContainer = <DependencyRegistration>[];
  }

  void _checkDependencyRegistration<T>() {
    if(_dependencyContainer.any((DependencyRegistration dr) => identical(dr.typeRegistered, Utilities.typeOf<T>())))
      throw StateError('The same type cannot be registered twice');
  }
}