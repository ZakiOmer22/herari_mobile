import 'package:flutter/material.dart';

class ExpensesPage extends StatefulWidget {
  final String avatarImagePath;

  const ExpensesPage({Key? key, this.avatarImagePath = 'assets/avatar.jpg'})
    : super(key: key);

  @override
  State<ExpensesPage> createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  int _selectedIndex = 0;
  String searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> expenses = [
    {
      'expense_no': 'EXP1001',
      'description': 'Medical Supplies',
      'date': '2025-06-20',
      'amount': 1200.00,
      'status': 'Paid',
    },
    {
      'expense_no': 'EXP1002',
      'description': 'Staff Training',
      'date': '2025-06-28',
      'amount': 800.50,
      'status': 'Pending',
    },
    {
      'expense_no': 'EXP1003',
      'description': 'Equipment Maintenance',
      'date': '2025-07-02',
      'amount': 600.00,
      'status': 'Overdue',
    },
  ];

  List<Map<String, dynamic>> get filteredExpenses => expenses.where((exp) {
    final q = searchQuery.toLowerCase();
    return exp['expense_no'].toLowerCase().contains(q) ||
        exp['description'].toLowerCase().contains(q) ||
        exp['status'].toLowerCase().contains(q);
  }).toList();

  void _onBottomNavTapped(int index) {
    if (index < 0 || index >= 3) return;
    setState(() => _selectedIndex = index);
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/dashboard');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/settings');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/profile');
        break;
    }
  }

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'paid':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'overdue':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Widget _infoCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.4)),
        ),
        child: Column(
          children: [
            Icon(icon, size: 28, color: color),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(title, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget buildDrawer() {
    final drawerSections = {
      'Hospital': [
        {'label': 'Branches', 'icon': Icons.location_city},
        {'label': 'Departments', 'icon': Icons.apartment},
        {'label': 'Patients', 'icon': Icons.person},
        {'label': 'Appointments', 'icon': Icons.calendar_today},
      ],
      'HR & Admin': [
        {'label': 'Employees', 'icon': Icons.badge},
        {'label': 'Leave Requests', 'icon': Icons.time_to_leave},
        {'label': 'Early Exit Requests', 'icon': Icons.exit_to_app},
        {'label': 'Payroll', 'icon': Icons.payments},
        {'label': 'Users', 'icon': Icons.admin_panel_settings},
        {'label': 'Roles', 'icon': Icons.security},
      ],
      'Finance': [
        {'label': 'Invoices', 'icon': Icons.receipt},
        {'label': 'Payments', 'icon': Icons.payment},
        {'label': 'Expenses', 'icon': Icons.money_off},
        {'label': 'Receipts', 'icon': Icons.receipt_long},
      ],
      'Inventory & Pharmacy': [
        {'label': 'Suppliers', 'icon': Icons.local_shipping},
        {'label': 'Inventory', 'icon': Icons.inventory},
        {'label': 'Medicines', 'icon': Icons.medical_services},
        {'label': 'Prescriptions', 'icon': Icons.description},
      ],
      'Lab & Tests': [
        {'label': 'Lab Tests', 'icon': Icons.science},
        {'label': 'Known Tests', 'icon': Icons.list_alt},
        {'label': 'Lab Test Results', 'icon': Icons.fact_check},
      ],
      'Assets': [
        {'label': 'Assets', 'icon': Icons.business},
        {'label': 'Maintenance Logs', 'icon': Icons.build},
      ],
      'System': [
        {'label': 'Audit Logs', 'icon': Icons.history},
      ],
    };

    return Drawer(
      child: SafeArea(
        child: ListView(
          children: [
            Container(
              color: const Color(0xFF002E38),
              padding: const EdgeInsets.all(20),
              child: Row(
                children: const [
                  CircleAvatar(
                    radius: 28,
                    backgroundImage: AssetImage('assets/logo.png'),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Herar Neurology\nClinic Manager',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        height: 1.3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            for (var section in drawerSections.entries) ...[
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Text(
                  section.key.toUpperCase(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ),
              for (var item in section.value)
                ListTile(
                  leading: Icon(item['icon'] as IconData, color: Colors.teal),
                  title: Text(item['label'] as String),
                  onTap: () {
                    Navigator.pop(context);
                    final label = item['label'] as String;
                    Navigator.pushReplacementNamed(
                      context,
                      '/${label.toLowerCase().replaceAll(' ', '_')}',
                    );
                  },
                ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final totalExpenses = expenses.length;
    final paidCount = expenses
        .where((e) => e['status'].toLowerCase() == 'paid')
        .length;
    final pendingCount = expenses
        .where((e) => e['status'].toLowerCase() == 'pending')
        .length;
    final overdueCount = expenses
        .where((e) => e['status'].toLowerCase() == 'overdue')
        .length;

    return Scaffold(
      drawer: buildDrawer(),
      appBar: AppBar(
        backgroundColor: const Color(0xFF002E38),
        title: const Text('Expenses', style: TextStyle(color: Colors.white)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundImage: AssetImage(widget.avatarImagePath),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Manage your expenses below.',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _infoCard(
                  'Total',
                  '$totalExpenses',
                  Icons.money_off,
                  Colors.blueGrey,
                ),
                _infoCard(
                  'Paid',
                  '$paidCount',
                  Icons.check_circle,
                  Colors.green,
                ),
                _infoCard(
                  'Pending',
                  '$pendingCount',
                  Icons.hourglass_top,
                  Colors.orange,
                ),
                _infoCard(
                  'Overdue',
                  '$overdueCount',
                  Icons.warning,
                  Colors.red,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: (val) => setState(() => searchQuery = val),
                    decoration: InputDecoration(
                      hintText: 'Search expense #, description or status...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Add expense logic
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(
                      label: Text(
                        'Expense #',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Description',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Amount',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Status',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Actions',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                  rows: filteredExpenses.map((exp) {
                    return DataRow(
                      cells: [
                        DataCell(Text(exp['expense_no'])),
                        DataCell(Text(exp['description'])),
                        DataCell(Text(exp['date'])),
                        DataCell(Text('\$${exp['amount'].toStringAsFixed(2)}')),
                        DataCell(
                          Text(
                            exp['status'],
                            style: TextStyle(
                              color: _statusColor(exp['status']),
                            ),
                          ),
                        ),
                        DataCell(
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.blueAccent,
                                ),
                                onPressed: () {
                                  // TODO: Edit expense
                                },
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  // TODO: Delete expense
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF219EBC),
        unselectedItemColor: Colors.grey,
        onTap: _onBottomNavTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
