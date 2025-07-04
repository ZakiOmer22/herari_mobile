import 'package:flutter/material.dart';

class UsersPage extends StatefulWidget {
  final String avatarImagePath;

  const UsersPage({Key? key, this.avatarImagePath = 'assets/avatar.jpg'})
    : super(key: key);

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  int _selectedIndex = 0;
  String searchQuery = '';

  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, String>> users = [
    {
      'username': 'admin',
      'role': 'Admin',
      'email': 'admin@herar.com',
      'status': 'Active',
    },
    {
      'username': 'hodan.y',
      'role': 'Staff',
      'email': 'hodan@herar.com',
      'status': 'Active',
    },
    {
      'username': 'mohamed.a',
      'role': 'Staff',
      'email': 'mohamed@herar.com',
      'status': 'Inactive',
    },
    {
      'username': 'fatima.m',
      'role': 'Admin',
      'email': 'fatima@herar.com',
      'status': 'Active',
    },
  ];

  List<Map<String, String>> get filteredUsers => users
      .where(
        (user) =>
            (user['username'] ?? '').toLowerCase().contains(
              searchQuery.toLowerCase(),
            ) ||
            (user['email'] ?? '').toLowerCase().contains(
              searchQuery.toLowerCase(),
            ) ||
            (user['role'] ?? '').toLowerCase().contains(
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
      case 'active':
        return Colors.green;
      case 'inactive':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    int totalUsers = users.length;
    int adminCount = users
        .where((u) => u['role']?.toLowerCase() == 'admin')
        .length;
    int staffCount = users
        .where((u) => u['role']?.toLowerCase() == 'staff')
        .length;

    return Scaffold(
      drawer: buildDrawer(),
      appBar: AppBar(
        backgroundColor: const Color(0xFF002E38),
        title: const Text('Users', style: TextStyle(color: Colors.white)),
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
              'Manage user accounts below.',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _infoCard(
                  'Total Users',
                  '$totalUsers',
                  Icons.group,
                  Colors.teal,
                ),
                _infoCard(
                  'Admins',
                  '$adminCount',
                  Icons.admin_panel_settings,
                  Colors.blue,
                ),
                _infoCard('Staff', '$staffCount', Icons.people, Colors.orange),
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
                      hintText: 'Search by username, email, or role...',
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
                    // TODO: Add new user logic
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
                        'Username',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Email',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Role',
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
                  rows: filteredUsers.map((user) {
                    return DataRow(
                      cells: [
                        DataCell(Text(user['username'] ?? '')),
                        DataCell(Text(user['email'] ?? '')),
                        DataCell(Text(user['role'] ?? '')),
                        DataCell(
                          Text(
                            user['status'] ?? '',
                            style: TextStyle(
                              color: _statusColor(user['status'] ?? ''),
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
                                onPressed: () {
                                  // TODO: Edit user
                                },
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  // TODO: Delete user
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
