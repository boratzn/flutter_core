import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hive/hive.dart';
import 'pending_action.dart';

class SyncManager {
  static final SyncManager instance = SyncManager._();
  SyncManager._();

  // İşlemleri gerçekleştirecek fonksiyonların listesi
  final Map<String, Future<bool> Function(Map<String, dynamic>)> _handlers = {};
  late Box<PendingAction> _actionBox;

  Future<void> init() async {
    _actionBox = await Hive.openBox<PendingAction>('pending_actions');

    Connectivity().onConnectivityChanged.listen((
      List<ConnectivityResult> result,
    ) {
      if (result != ConnectivityResult.none) {
        processQueue();
      }
    });
  }

  void registerHandler(
    String key,
    Future<bool> Function(Map<String, dynamic>) handler,
  ) {
    _handlers[key] = handler;
  }

  void addToQueue(String methodName, Map<String, dynamic> data) {
    final action = PendingAction(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      methodName: methodName,
      payload: data,
      createdAt: DateTime.now(),
    );
    _actionBox.add(action);
  }

  Future<void> processQueue() async {
    if (_actionBox.isEmpty) return;

    for (var action in _actionBox.values.toList()) {
      if (_handlers.containsKey(action.methodName)) {
        final success = await _handlers[action.methodName]!(action.payload);
        if (success) {
          await action.delete();
        }
      }
    }
  }
}
