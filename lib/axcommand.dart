part of axmvvm;

typedef Action = void Function();
typedef ActionParam<Tparam> = void Function({Tparam param});

/// Used by ViewModels and other BindableBase objects to execute a command/function.
///
/// A command object should be returned by a property get statement.
class AxCommand<T> {
  AxCommand({Action action, ActionParam<T> actionParam, Function canExecute}) {
    if(action != null)
      _action = ({T param}) => action();
    else if(actionParam != null)
      _action = actionParam; 
    else
      throw ArgumentError('function cannot be null');

    _canExecuteFunction = canExecute ?? () => true;
  }
  
  ActionParam<T> _action;
  Function _canExecuteFunction;

  /// Execute's the function on the BindableBase object.
  ActionParam<T> get execute => _action;
  /// Execute's the function on the BindableBase object if allowed.
  Function get executeIf => _canExecuteFunction() ? _action : (){};
  /// Checks if function can be executed on the BindableBase object.
  Function get canExecute => _canExecuteFunction; 
}