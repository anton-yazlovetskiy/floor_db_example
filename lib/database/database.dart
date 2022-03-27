import 'dart:async';
import 'package:floor/floor.dart';
import 'package:floor_db_example/entity/employee.dart';
import 'package:floor_db_example/entity/employee_dao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
part 'database.g.dart'; //flutter packages pub run build_runner build

@Database(version: 1, entities: [Employee])
abstract class AppDatabase extends FloorDatabase {
  EmployeeDAO get employeeDAO;
}
