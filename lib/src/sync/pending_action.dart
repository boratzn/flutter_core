import 'package:hive/hive.dart';

part 'pending_action.g.dart'; // Otomatik üretilecek dosya

@HiveType(typeId: 0)
class PendingAction extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String methodName;
  @HiveField(2)
  final Map<String, dynamic> payload;
  @HiveField(3)
  final DateTime createdAt;

  PendingAction({
    required this.id,
    required this.methodName,
    required this.payload,
    required this.createdAt,
  });
}