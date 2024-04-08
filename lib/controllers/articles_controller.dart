import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fl_ecommerce/models/employee.dart'; // Import model


class ArticlesController {
  late List<Employee> _employees;

  Future<List<Employee>> fetchEmployees() async {
    final response = await http.get(Uri.parse('https://dummy.restapiexample.com/api/v1/employees'));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body)['data'] as List<dynamic>;
      _employees = jsonData.map((e) => Employee.fromJson(e)).toList();
      return _employees;
    } else {
      throw Exception('Failed to load employees');
    }
  }

  List<Employee> filterEmployees(List<Employee> employees, String query) {
    if (query.isEmpty) return employees;
    final searchLower = query.toLowerCase();
    return employees.where((employee) =>
      employee.name.toLowerCase().contains(searchLower) ||
      employee.salary.toString().toLowerCase().contains(searchLower) ||
      employee.age.toString().toLowerCase().contains(searchLower)
    ).toList();
  }
}
