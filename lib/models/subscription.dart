part of axmvvm.models;

/// A subscription to be used with the MessageService.
class Subscription {
  final String _name;
  final Function(Object parameter) _messageHandler;

  Subscription(this._name, this._messageHandler);

  /// The name of the subscription to listen to messages for.
  ///
  /// Any messages sent with this name will be delivered to the message handler.
  String get name => _name;

  /// The method to call when a message is recieved for the name. 
  /// 
  /// The [parameter] containes the payload of the message.
  Function(Object parameter) get messageHandler => _messageHandler;
}
