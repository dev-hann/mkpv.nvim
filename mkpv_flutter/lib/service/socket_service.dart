import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

typedef SocketCallback = Function(Map<String, dynamic>);

class SocketService {
  late Socket socket;

  late StreamSubscription socketStream;

  Future connect() async {
    socket = await Socket.connect('localhost', 55555);
    socketStream = socket.listen(onData);
  }

  void dispose() {
    socketStream.cancel();
  }

  void onData(Uint8List rawData) {
    final msg = String.fromCharCodes(rawData);
    final data = json.decode(msg);
    for (final listener in listenerList) {
      listener(data);
    }
  }

  final List<SocketCallback> listenerList = [];

  void addListener(SocketCallback listener) {
    if (listenerList.contains(listener)) return;
    listenerList.add(listener);
  }

  void removeListener(SocketCallback listener) {
    listenerList.remove(listener);
  }

  void send(Map<String, dynamic> data) {
    socket.write(json.encode(data));
  }
}
