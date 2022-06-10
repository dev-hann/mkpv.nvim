import 'dart:async';
import 'dart:io';

import 'package:watcher/watcher.dart';

typedef WatchCallback = Function(WatchEvent);

class WatcherService {
  FileWatcher? fileWatcher;
  late StreamSubscription fileStream;
  void initWatch(String filePath) {
    if (fileWatcher != null) {}
    fileWatcher = FileWatcher(filePath);
    refreshData();
    fileStream = fileWatcher!.events.listen(notifyListeners);
  }

  String data = "";

  void refreshData() {
    if (fileWatcher == null) return;
    final file = File(fileWatcher!.path);
    data = file.readAsStringSync();
  }

  final List<WatchCallback> listenerList = [];

  void notifyListeners(WatchEvent event) {
    for (final listener in listenerList) {
      listener(event);
    }
  }

  void addListener(WatchCallback listener) {
    if (listenerList.contains(listener)) return;
    listenerList.add(listener);
  }

  void removeListener(WatchCallback listener) {
    listenerList.remove(listener);
  }
}
