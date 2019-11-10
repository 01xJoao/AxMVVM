part of 'axmvvm.dart';

/// A object that contains information about resolving an dependency
class AxDependency {
  Type _typeRegistered;
  Lifestyle _registrationType;
  Object _registeredInstance;
  Function _factoryMethod;

  /// The lifestyle of registration, always get the same instance or new instance per type.
  Lifestyle get registrationType => _registrationType;

  /// The type of object to create.
  Type get typeRegistered => _typeRegistered;

  /// A reference to the object for instance registration.
  Object get registeredInstance => _registeredInstance;

  /// A function to create an instance of an object for type registrations.
  Function get factoryMethod => _factoryMethod;

  AxDependency(Type typeRegistered, Lifestyle registrationLifestyle, {Object registeredSingleton, Function registerTransient}){
    if (registrationLifestyle == null)
      throw ArgumentError('registration lifestyle cannot be null.');

    if (registrationLifestyle == Lifestyle.singletonRegistration && registeredSingleton == null)
      throw StateError('The registered instance cannot be null when the registration lifestyle is an instance registration.');
    
    if (registrationLifestyle == Lifestyle.transientRegistration && registerTransient == null)
      throw StateError('The factory method cannot be null when the registration lifestyle is a transient registration.');

    _typeRegistered = typeRegistered;
    _registrationType = registrationLifestyle;
    _registeredInstance = registeredSingleton;
    _factoryMethod = registerTransient;
  }
}