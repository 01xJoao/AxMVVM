part of axmvvm.models;

class Messenger {
  final String _name;
  StreamController<Object> _streamController = StreamController<Object>.broadcast();

  Messenger(this._name);

  String get name => _name;
  StreamController<Object> get streamController => _streamController;

  void close() {
    _streamController?.close();
    _streamController = null;
  }
}