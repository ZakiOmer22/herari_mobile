import 'package:flutter/material.dart';

class PayrollPage extends StatefulWidget {
  final String avatarImagePath;

  const PayrollPage({Key? key, this.avatarImagePath = 'assets/avatar.jpg'})
    : super(key: key);

  @override
  State<PayrollPage> createState() => _PayrollPageState();
}

class _PayrollPageState extends State<PayrollPage> {
  int _selectedIndex = 0; // Home default
  String searchQuery = '';

  final TextEditingController _searchController = TextEditingController();

  // Sample payroll data
  final List<Map<String, dynamic>> payrolls = [
    {
      'employee': 'Ali Hassan',
      'department': 'Neurology',
      'month': 'June 2025',
      'basic_salary': 5000,
      'allowances': 500,
      'deductions': 200,
      'net_salary': 5300,
      'status': 'Paid',
    },
    {
      'employee': 'Hodan Yusuf',
      'department': 'HR',
      'month': 'June 2025',
      'basic_salary': 4500,
      'allowances': 300,
      'deductions': 150,
      'net_salary': 4650,
      'status': 'Pending',
    },
    {
      'employee': 'Mohamed Abdi',
      'department': 'Finance',
      'month': 'June 2025',
      'basic_salary': 4800,
      'allowances': 400,
      'deductions': 100,
      'net_salary': 5100,
      'status': 'Paid',
    },
  ];

  List<Map<String, dynamic>> get filteredPayrolls => payrolls
      .where(
        (payroll) =>
            (payroll['employee'] as String).toLowerCase().contains(
              searchQuery.toLowerCase(),
            ) ||
            (payroll['department'] as String).toLowerCase().contains(
              searchQuery.toLowerCase(),
            ) ||
            (payroll['month'] as String).toLowerCase().contains(
              searchQuery.toLowerCase(),
            ) ||
            (payroll['status'] as String).toLowerCase().contains(
              searchQuery.toLowerCase(),
            ),
      )
      .toList();

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

  Widget _infoCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          border: Border.all(color: color.withOpacity(0.4)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
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

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'paid':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'unpaid':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    int totalPayrolls = payrolls.length;
    int paidCount = payrolls
        .where((p) => p['status']?.toLowerCase() == 'paid')
        .length;
    int pendingCount = payrolls
        .where((p) => p['status']?.toLowerCase() == 'pending')
        .length;

    return Scaffold(
      drawer: buildDrawer(),
      appBar: AppBar(
        backgroundColor: const Color(0xFF002E38),
        title: const Text('Payroll', style: TextStyle(color: Colors.white)),
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
              'Manage payroll records below.',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _infoCard(
                  'Total Payrolls',
                  totalPayrolls.toString(),
                  Icons.payments,
                  Colors.teal,
                ),
                _infoCard(
                  'Paid',
                  paidCount.toString(),
                  Icons.check_circle,
                  Colors.green,
                ),
                _infoCard(
                  'Pending',
                  pendingCount.toString(),
                  Icons.pending_actions,
                  Colors.orange,
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
                      hintText: 'Search by employee, department, or status...',
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
                    // TODO: Add payroll logic here
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
                  columnSpacing: 20,
                  columns: const [
                    DataColumn(
                      label: Text(
                        'Employee',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Department',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Month',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Basic Salary',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Allowances',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Deductions',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Net Salary',
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
                  rows: filteredPayrolls.map((payroll) {
                    return DataRow(
                      cells: [
                        DataCell(Text(payroll['employee'] ?? '')),
                        DataCell(Text(payroll['department'] ?? '')),
                        DataCell(Text(payroll['month'] ?? '')),
                        DataCell(Text('\$${payroll['basic_salary']}')),
                        DataCell(Text('\$${payroll['allowances']}')),
                        DataCell(Text('\$${payroll['deductions']}')),
                        DataCell(Text('\$${payroll['net_salary']}')),
                        DataCell(
                          Text(
                            payroll['status'] ?? '',
                            style: TextStyle(
                              color: _statusColor(payroll['status'] ?? ''),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DataCell(
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                                tooltip: 'Edit',
                                onPressed: () {
                                  // TODO: Open edit payroll form/modal
                                },
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                tooltip: 'Delete',
                                onPressed: () {
                                  // TODO: Confirm and delete payroll
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
