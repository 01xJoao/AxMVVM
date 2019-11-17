part of axmvvm.services;

/// Supports the publish/subscribe design pattern.
///
/// The Messenge Service allows for loose coupling between objects where anything in the system can
/// send information of interest without being aware of what other parts of the system may use that information.
class MessageService implements IMessageService {
  final List<Subscription> _subscriptions = <Subscription>[];
  final List<Messenger> _messengers = <Messenger>[];

  /// Adds a subscription to receive notifications when events occur.
  @override
  void subscribe(Subscription subscription) {
    if (subscription == null)
      throw ArgumentError('A subscription must be provided.');

    _subscriptions.add(subscription);

    if (!_messengers.any((Messenger m) => m.name == subscription.name))
      _messengers.add(Messenger(subscription.name));

    final Messenger messenger = _messengers.singleWhere((Messenger m) => m.name == subscription.name);
    messenger.streamController.stream.asBroadcastStream().listen(subscription.messageHandler);
  }

  /// Removes an existing subscription.
  ///
  /// If the subscription does not exist this method does nothing.
  @override
  void unsubscribe(Subscription subscription) {
    if (subscription == null)
      throw ArgumentError('A subscription must be provided.');

    _subscriptions.remove(subscription);

    if (!_subscriptions.any((Subscription s) => s.name == subscription.name)) {
      final Messenger messenger = _messengers.singleWhere((Messenger m) => m.name == subscription.name);
      messenger.close();
      _messengers.remove(messenger);
    }
  }

  /// Publishes a message to be received by any subscribers.
  ///
  /// If there are no subscripbers to the messange name, this method will do nothing.
  @override
  void publish(Message message) {
    if (message == null)
      throw ArgumentError('A message must be provided.');

    if (_messengers.any((Messenger m) => m.name == message.name)) {
      final Messenger messenger = _messengers.singleWhere((Messenger m) => m.name == message.name);
      messenger.streamController.add(message.parameter);
    }
  }

  /// Clears all existing subscriptions.
  @override
  void clearAllSubscriptions() {
    _messengers.forEach((Messenger m) => m.close());
    _subscriptions.clear();
    _messengers.clear();
  }
}