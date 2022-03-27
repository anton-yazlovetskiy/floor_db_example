import 'package:floor/floor.dart';

@entity
class Employee {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  String firstName;
  String lastName;
  String? email;

  Employee({
    this.id,
    required this.firstName,
    required this.lastName,
    this.email,
  });
}
