part of axmvvm.services;

/// Supports the publish/subscribe design pattern.
///
/// The Messenge Service allows for loose coupling between objects where anything in the system can
/// send information of interest without being aware of what other parts of the system may use that information.
abstract class IMessageService {
  /// Adds a subscription to receive notifications when events occur.
  void subscribe(Subscription subscription);

  /// Removes an existing subscription.
  ///
  /// If the subscription does not exist this method does nothing.
  void unsubscribe(Subscription subscription);

  /// Publishes a message to be received by any subscribers.
  ///
  /// If there are no subscripbers to the messange name, this method will do nothing.
  void publish(Message message);

  /// Clears all existing subscriptions.
  void clearAllSubscriptions();
}