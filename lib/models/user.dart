import 'package:hive/hive.dart';

part 'user.g.dart';  // Archivo generado por Hive

@HiveType(typeId: 0)  // typeId debe ser único
class User {
  @HiveField(0)
  String name;

  @HiveField(1)
  int age;

  User(this.name, this.age);
}