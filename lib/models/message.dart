part of axmvvm.models;

/// A message to send to the subscription service.
class Message {
  final String _name;
  final Object _parameter;

  Message(this._name, this._parameter);

  /// The name of the sending message.
  ///
  /// Messages will be delived to subscriptions with a matching name.
  String get name => _name;

  /// A parameter to send with the message.
  ///
  /// The parameter will be deliverd to the message handler of any matching subscriptions.
  Object get parameter => _parameter;
}
