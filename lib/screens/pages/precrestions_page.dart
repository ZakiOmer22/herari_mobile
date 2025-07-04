import 'package:flutter/material.dart';

class PrescriptionsPage extends StatefulWidget {
  final String avatarImagePath;

  const PrescriptionsPage({
    Key? key,
    this.avatarImagePath = 'assets/avatar.jpg',
  }) : super(key: key);

  @override
  State<PrescriptionsPage> createState() => _PrescriptionsPageState();
}

class _PrescriptionsPageState extends State<PrescriptionsPage> {
  int _selectedIndex = 0;
  String searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> prescriptions = [
    {
      'prescription_id': 'PR001',
      'patient': 'Ahmed Ali',
      'doctor': 'Dr. Yusuf',
      'date': '2025-07-01',
      'medicines': 'Paracetamol, Amoxicillin',
    },
    {
      'prescription_id': 'PR002',
      'patient': 'Fatima Mohamed',
      'doctor': 'Dr. Amina',
      'date': '2025-07-02',
      'medicines': 'Ibuprofen',
    },
    {
      'prescription_id': 'PR003',
      'patient': 'Abdirahman Yusuf',
      'doctor': 'Dr. Hassan',
      'date': '2025-07-03',
      'medicines': 'Cetirizine',
    },
  ];

  List<Map<String, dynamic>> get filteredPrescriptions =>
      prescriptions.where((pres) {
        final q = searchQuery.toLowerCase();
        return pres['prescription_id'].toLowerCase().contains(q) ||
            pres['patient'].toLowerCase().contains(q) ||
            pres['doctor'].toLowerCase().contains(q);
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
    final total = prescriptions.length;

    return Scaffold(
      drawer: buildDrawer(),
      appBar: AppBar(
        backgroundColor: const Color(0xFF002E38),
        title: const Text(
          'Prescriptions',
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
              'Review prescribed medications to patients.',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _infoCard(
                  'Total Prescriptions',
                  '$total',
                  Icons.description,
                  Colors.teal,
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
                      hintText: 'Search by ID, patient, or doctor...',
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
                    // TODO: Add prescription logic
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
                    DataColumn(label: Text('Prescription ID')),
                    DataColumn(label: Text('Patient')),
                    DataColumn(label: Text('Doctor')),
                    DataColumn(label: Text('Date')),
                    DataColumn(label: Text('Medicines')),
                    DataColumn(label: Text('Actions')),
                  ],
                  rows: filteredPrescriptions.map((pres) {
                    return DataRow(
                      cells: [
                        DataCell(Text(pres['prescription_id'])),
                        DataCell(Text(pres['patient'])),
                        DataCell(Text(pres['doctor'])),
                        DataCell(Text(pres['date'])),
                        DataCell(Text(pres['medicines'])),
                        DataCell(
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.blueAccent,
                                ),
                                onPressed: () {
                                  // TODO: Edit logic
                                },
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  // TODO: Delete logic
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
