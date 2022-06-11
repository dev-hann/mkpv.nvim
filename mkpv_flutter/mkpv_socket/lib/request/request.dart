library request;

part 'request_type.dart';

class Request {
  Request(this.typeIndex, [this.data]);
  final int typeIndex;

  RequestType get type => RequestType.values[typeIndex];

  final dynamic data;

  factory Request.fromMap(dynamic map) {
    final data = Map<String, dynamic>.from(map);
    return Request(data["typeIndex"], data["data"]);
  }

  factory Request.connect() {
    return Request(RequestType.connect.index);
  }
  factory Request.update(String data) {
    return Request(RequestType.update.index, data);
  }

  factory Request.close() {
    return Request(RequestType.close.index);
  }
  Map<String, dynamic> toMap() {
    return {
      "typeIndex": typeIndex,
      "data": data,
    };
  }
}
