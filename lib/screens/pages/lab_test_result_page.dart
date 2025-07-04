import 'package:flutter/material.dart';

class LabTestResultsPage extends StatefulWidget {
  final String avatarImagePath;

  const LabTestResultsPage({
    Key? key,
    this.avatarImagePath = 'assets/avatar.jpg',
  }) : super(key: key);

  @override
  State<LabTestResultsPage> createState() => _LabTestResultsPageState();
}

class _LabTestResultsPageState extends State<LabTestResultsPage> {
  int _selectedIndex = 0;
  String searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> testResults = [
    {
      'result_id': 'LTR001',
      'patient': 'Ahmed Ali',
      'test': 'Blood Test',
      'date': '2025-07-01',
      'result': 'Normal',
    },
    {
      'result_id': 'LTR002',
      'patient': 'Fatima Mohamed',
      'test': 'X-Ray',
      'date': '2025-07-02',
      'result': 'Fracture Detected',
    },
    {
      'result_id': 'LTR003',
      'patient': 'Abdirahman Yusuf',
      'test': 'MRI',
      'date': '2025-07-03',
      'result': 'Clear',
    },
  ];

  List<Map<String, dynamic>> get filteredResults => testResults.where((res) {
    final q = searchQuery.toLowerCase();
    return res['result_id'].toLowerCase().contains(q) ||
        res['patient'].toLowerCase().contains(q) ||
        res['test'].toLowerCase().contains(q);
  }).toList();

  void _onBottomNavTapped(int index) {
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

  Drawer buildDrawer() {
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
    final total = testResults.length;
    final pending = testResults
        .where((r) => r['result'].toLowerCase() == 'pending')
        .length;
    final completed = total - pending;

    return Scaffold(
      drawer: buildDrawer(),
      appBar: AppBar(
        backgroundColor: const Color(0xFF002E38),
        title: const Text(
          'Lab Test Results',
          style: TextStyle(color: Colors.white),
        ),
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
              'Review patient lab test results.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _infoCard(
                  'Total Results',
                  '$total',
                  Icons.fact_check,
                  Colors.blueGrey,
                ),
                _infoCard(
                  'Pending Tests',
                  '$pending',
                  Icons.pending_actions,
                  Colors.orange,
                ),
                _infoCard(
                  'Completed',
                  '$completed',
                  Icons.check_circle,
                  Colors.green,
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
                      hintText: 'Search by ID, patient or test...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: () {},
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
                    DataColumn(label: Text('Result ID')),
                    DataColumn(label: Text('Patient')),
                    DataColumn(label: Text('Test')),
                    DataColumn(label: Text('Date')),
                    DataColumn(label: Text('Result')),
                    DataColumn(label: Text('Actions')),
                  ],
                  rows: filteredResults.map((res) {
                    return DataRow(
                      cells: [
                        DataCell(Text(res['result_id'])),
                        DataCell(Text(res['patient'])),
                        DataCell(Text(res['test'])),
                        DataCell(Text(res['date'])),
                        DataCell(Text(res['result'])),
                        DataCell(
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.blueAccent,
                                ),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {},
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
