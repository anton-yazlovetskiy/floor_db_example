import 'package:floor/floor.dart';
import 'package:floor_db_example/entity/employee.dart';

@dao
abstract class EmployeeDAO {
  @Query('SELECT * FROM Employee')
  Stream<List<Employee>> getAllEmployee();

  @Query('SELECT * FROM Employee WHERE id = :id')
  Stream<Employee?> getAllEmployeeById(int id);

  @Query('DELETE FROM Employee')
  Future<void> deleteAllEmployee();

  @insert
  Future<void> insertEmployee(Employee employee);

  @update
  Future<void> updateEmployee(Employee employee);

  @delete
  Future<void> deleteEmployee(Employee employee);
}
