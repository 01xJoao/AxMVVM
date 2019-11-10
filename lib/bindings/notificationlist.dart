part of axmvvm.bindings;

/// The NotificationList extends a normal list base and adds a ChangeNotifier
///
/// notifyListeners is called when any items are added or removed from the list.
class NotificationList<E> extends ListBase<E> with ChangeNotifier {
  @override
  int length;

  @override
  E operator [](int index) {
    // TODO: implement []
    return null;
  }

  @override
  void operator []=(int index, E value) {
    // TODO: implement []=
  }
}