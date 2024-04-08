import 'package:flutter/material.dart';
import 'package:fl_ecommerce/controllers/articles_controller.dart'; // Import model
import 'package:fl_ecommerce/models/employee.dart'; // Import model



class ArticlesPage extends StatefulWidget {
  @override
  _ArticlesPageState createState() => _ArticlesPageState();
}

class _ArticlesPageState extends State<ArticlesPage> {
  final ArticlesController _controller = ArticlesController();
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late List<Employee> _employees;
  late List<Employee> _filteredEmployees;

  @override
  void initState() {
    super.initState();
    _loadEmployees();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          onChanged: _onSearchTextChanged,
          decoration: InputDecoration(
            hintText: 'Search by name, salary, or age',
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: Icon(Icons.clear),
              onPressed: _clearSearch,
            ),
          ),
        ),
      ),
      body: _buildEmployeeGrid(),
    );
  }

  Widget _buildEmployeeGrid() {
    return RefreshIndicator(
      onRefresh: _loadEmployees,
      child: GridView.builder(
        controller: _scrollController,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: _filteredEmployees.length,
        itemBuilder: (context, index) {
          final employee = _filteredEmployees[index];
          return _buildEmployeeCard(employee);
        },
      ),
    );
  }

  Widget _buildEmployeeCard(Employee employee) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              employee.name,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Salary: ${employee.salary.toString()}'),
            Text('Age: ${employee.age.toString()}'),
          ],
        ),
      ),
    );
  }

  Future<void> _loadEmployees() async {
    final employees = await _controller.fetchEmployees();
    setState(() {
      _employees = employees;
      _filteredEmployees = _employees;
    });
  }

  void _onScroll() {
    if (_scrollController.position.atEdge && _scrollController.position.pixels > 0) {
      _loadEmployees();
    }
  }

  void _onSearchTextChanged(String query) {
    setState(() {
      _filteredEmployees = _controller.filterEmployees(_employees, query);
    });
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {
      _filteredEmployees = _employees;
    });
  }
}


