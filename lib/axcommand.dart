part of axmvvm;

/// Used by viewmodels and other BindableBase objects to execute a command/function.
///
/// A command object should be returned by a property get statement.
class AxCommand {
  AxCommand(Function function, [Function canExecuteFunction]) {
    _function = function;
    _canExecuteFunction = canExecuteFunction ?? () => true;
  }
  
  Function _function;
  Function _canExecuteFunction;

  /// Execute's the function on the BindableBase object.
  Function get execute => _function;
  /// Execute's the function on the BindableBase object if allowed.
  Function get executeIf => _canExecuteFunction() ? _function : (){};
  /// Checks if function can be executed on the BindableBase object.
  Function get canExecute => _canExecuteFunction;
}