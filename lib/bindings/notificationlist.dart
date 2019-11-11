part of axmvvm.bindings;

/// The NotificationList extends a normal list base and adds a ChangeNotifier
///
/// notifyListeners is called when any items are added or removed from the list.

class NotificationList<E> extends ListBase<E> with ChangeNotifier {
  List<E> _list = <E>[];

  NotificationList();

  @override
  int get length => _list.length;

  @override
  set length(int newLength) => _list.length = newLength;

  @override
  E operator [](int index) => _list[index];

  @override
  void operator []=(int index, E value) => _list[index] = value;

  @override
  void add(E element) {
    super.add(element);
    notifyListeners();
  }

  @override
  void addAll(Iterable<E> iterable) {
    super.addAll(iterable);
    notifyListeners();
  }

  @override
  bool remove(Object element) {
    final bool returnValue = super.remove(element);
    notifyListeners();
    return returnValue;
  }

  @override
  void removeWhere(bool test(E element)) {
    super.removeWhere(test);
    notifyListeners();
  }

  @override
  void retainWhere(bool test(E element)) {
    super.retainWhere(test);
    notifyListeners();
  }

  factory NotificationList.filled(int length, E fill, {bool growable = false}) {
    final NotificationList<E> returnList = NotificationList<E>();

    returnList._list = List<E>.filled(length, fill, growable: growable);
    return returnList;
  }

  factory NotificationList.from(Iterable<E> elements, {bool growable = true}) {
    final NotificationList<E> returnList = NotificationList<E>();

    returnList._list = List<E>.from(elements, growable: growable);
    return returnList;
  }

  factory NotificationList.generate(int length, E generator(int index), {bool growable = true}) {
    final NotificationList<E> returnList = NotificationList<E>();

    returnList._list = List<E>.generate(length, generator, growable: growable);
    return returnList;
  }

  factory NotificationList.unmodifiable(Iterable<E> elements) {
    final NotificationList<E> returnList = NotificationList<E>();

    returnList._list = List<E>.unmodifiable(elements);
    return returnList;
  }

  factory NotificationList.of(Iterable<E> elements, {bool growable = true}) {
    return NotificationList<E>.from(elements, growable: growable);
  }

  static void copyRange<T>(NotificationList<T> targetList, int at, NotificationList<T> sourceList, [int start, int end]) {
    List.copyRange(targetList, at, sourceList, start, end);
  }

  static void writeIterable<T>(NotificationList<T> targetList, int at, Iterable<T> sourceList) {
    List.writeIterable(targetList, at, sourceList);
  }
}