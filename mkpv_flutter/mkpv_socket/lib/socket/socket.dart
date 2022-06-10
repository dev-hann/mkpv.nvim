part of mkpv_socket;

class MkpvSocket {
  MkpvSocket(this._socket);
  final Socket _socket;

  static Future<MkpvSocket> connect({String? address, int? port}) async {
    final tmpSocket =
        await Socket.connect(address ?? defaultAddress, port ?? defaultPort);
    tmpSocket.encoding = utf8;
    return MkpvSocket(tmpSocket);
  }

  StreamSubscription? socketStream;
  void _closeSocketStream() {
    if (socketStream != null) {
      socketStream!.cancel();
    }
  }

  void send(Request request) {
    _socket.write(json.encode(request.toMap()));
  }

  void addListener({
    required Function(Request request) onData,
    Function()? onDone,
    Function(dynamic)? onError,
  }) {
    _closeSocketStream();
    socketStream = _socket.listen(
      (data) {
        // final msg = String.fromCharCodes(data);
        final msg = utf8.decode(data);
        onData(Request.fromMap(json.decode(msg)));
      },
      onDone: onDone,
      onError: onError,
    );
  }

  void dispose() {
    _closeSocketStream();
    _socket.close();
  }
}
