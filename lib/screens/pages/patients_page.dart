import 'package:flutter/material.dart';

class PatientsPage extends StatefulWidget {
  final String avatarImagePath;

  const PatientsPage({Key? key, this.avatarImagePath = 'assets/avatar.jpg'})
    : super(key: key);

  @override
  State<PatientsPage> createState() => _PatientsPageState();
}

class _PatientsPageState extends State<PatientsPage> {
  int _selectedIndex = 1;
  String searchQuery = '';

  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, String>> patients = [
    {
      'full_name': 'Ahmed Ali',
      'date_of_birth': '1992-07-14',
      'gender': 'Male',
      'phone_number': '0612345678',
    },
    {
      'full_name': 'Fatima Mohamed',
      'date_of_birth': '1988-03-22',
      'gender': 'Female',
      'phone_number': '0623456789',
    },
    {
      'full_name': 'Abdirahman Yusuf',
      'date_of_birth': '2000-01-05',
      'gender': 'Male',
      'phone_number': '0634567890',
    },
    {
      'full_name': 'Ayaan Warsame',
      'date_of_birth': '1995-11-02',
      'gender': 'Female',
      'phone_number': '0619988776',
    },
    {
      'full_name': 'Khadar Hassan',
      'date_of_birth': '1982-05-20',
      'gender': 'Male',
      'phone_number': '0655544332',
    },
    {
      'full_name': 'Zahra Abdulle',
      'date_of_birth': '1993-09-13',
      'gender': 'Female',
      'phone_number': '0688765432',
    },
    {
      'full_name': 'Mohamed Nur',
      'date_of_birth': '1979-12-01',
      'gender': 'Male',
      'phone_number': '0612233445',
    },
    {
      'full_name': 'Ilhan Ahmed',
      'date_of_birth': '1998-04-18',
      'gender': 'Female',
      'phone_number': '0698761234',
    },
    {
      'full_name': 'Yasin Abdikadir',
      'date_of_birth': '1985-08-11',
      'gender': 'Male',
      'phone_number': '0623344556',
    },
    {
      'full_name': 'Nasteexo Hassan',
      'date_of_birth': '1990-06-07',
      'gender': 'Female',
      'phone_number': '0656677889',
    },
    {
      'full_name': 'Hodan Abdi',
      'date_of_birth': '1996-10-25',
      'gender': 'Female',
      'phone_number': '0682345678',
    },
    {
      'full_name': 'Mahad Shire',
      'date_of_birth': '1983-01-30',
      'gender': 'Male',
      'phone_number': '0665432109',
    },
    {
      'full_name': 'Rahma Noor',
      'date_of_birth': '1991-02-17',
      'gender': 'Female',
      'phone_number': '0678765432',
    },
    {
      'full_name': 'Liban Ali',
      'date_of_birth': '1987-12-08',
      'gender': 'Male',
      'phone_number': '0643210987',
    },
    {
      'full_name': 'Sahra Mohamed',
      'date_of_birth': '1999-07-21',
      'gender': 'Female',
      'phone_number': '0601122334',
    },
  ];

  List<Map<String, String>> get filteredPatients => patients
      .where(
        (patient) => (patient['full_name'] ?? '').toLowerCase().contains(
          searchQuery.toLowerCase(),
        ),
      )
      .toList();

  void _onBottomNavTapped(int index) {
    setState(() => _selectedIndex = index);
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/dashboard');
        break;
      case 1:
        // current page, do nothing
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/settings');
        break;
      case 3:
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: buildDrawer(),
      appBar: AppBar(
        backgroundColor: const Color(0xFF002E38),
        title: const Text('Patients', style: TextStyle(color: Colors.white)),
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
              'Patient list & management overview. You can manage patient records below.',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _infoCard(
                  'Total Patients',
                  patients.length.toString(),
                  Icons.people,
                  Colors.teal,
                ),
                _infoCard(
                  'Male',
                  patients
                      .where((p) => p['gender'] == 'Male')
                      .length
                      .toString(),
                  Icons.male,
                  Colors.blue,
                ),
                _infoCard(
                  'Female',
                  patients
                      .where((p) => p['gender'] == 'Female')
                      .length
                      .toString(),
                  Icons.female,
                  Colors.pink,
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
                      hintText: 'Search Patients...',
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
                    // TODO: Add patient logic here
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
                        'Full Name',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Date of Birth',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Gender',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Phone',
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
                  rows: filteredPatients.map((patient) {
                    return DataRow(
                      cells: [
                        DataCell(Text(patient['full_name'] ?? '')),
                        DataCell(Text(patient['date_of_birth'] ?? '')),
                        DataCell(Text(patient['gender'] ?? '')),
                        DataCell(Text(patient['phone_number'] ?? '')),
                        DataCell(
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                                onPressed: () {
                                  // TODO: Open edit patient form/modal
                                },
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  // TODO: Open confirm delete dialog
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
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Patients'),
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
