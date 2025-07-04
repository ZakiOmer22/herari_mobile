import 'package:flutter/material.dart';
import 'package:majid/models/edit_branch_form.dart';
import 'package:majid/widgets/confirm_delete_modal.dart';

class BranchesPage extends StatefulWidget {
  final String avatarImagePath;

  const BranchesPage({Key? key, this.avatarImagePath = 'assets/avatar.jpg'})
    : super(key: key);

  @override
  State<BranchesPage> createState() => _BranchesPageState();
}

class _BranchesPageState extends State<BranchesPage> {
  int _selectedIndex = 1;
  String searchQuery = '';

  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, String>> branches = [
    {
      'name': 'Downtown Branch',
      'location': 'KM4, Mogadishu',
      'status': 'Active',
    },
    {
      'name': 'Airport Branch',
      'location': 'Wadajir, Mogadishu',
      'status': 'Inactive',
    },
    {
      'name': 'Bakara Branch',
      'location': 'Hodan, Mogadishu',
      'status': 'Active',
    },
  ];

  final Map<String, List<Map<String, dynamic>>> drawerSections = {
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

  void _onBottomNavTapped(int index) {
    setState(() => _selectedIndex = index);
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/dashboard');
        break;
      case 1:
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/settings');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/profile');
        break;
    }
  }

  List<Map<String, String>> get filteredBranches => branches
      .where(
        (branch) =>
            branch['name']!.toLowerCase().contains(searchQuery.toLowerCase()),
      )
      .toList();

  Widget buildDrawer() {
    return Drawer(
      child: SafeArea(
        child: ListView(
          children: [
            Container(
              color: const Color(0xFF002E38),
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 28,
                    backgroundImage: AssetImage('assets/logo.png'),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
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
                  leading: Icon(item['icon'], color: Colors.teal),
                  title: Text(item['label']),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(
                      context,
                      '/${item['label'].toLowerCase().replaceAll(' ', '_')}',
                    );
                  },
                ),
            ],
          ],
        ),
      ),
    );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: buildDrawer(),
      appBar: AppBar(
        backgroundColor: const Color(0xFF002E38),
        title: const Text('Branches', style: TextStyle(color: Colors.white)),
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Branch performance & quick overview. You can manage branches below.',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _infoCard(
                  'Total Branches',
                  branches.length.toString(),
                  Icons.location_city,
                  Colors.teal,
                ),
                _infoCard(
                  'Active',
                  branches
                      .where((b) => b['status'] == 'Active')
                      .length
                      .toString(),
                  Icons.check_circle,
                  Colors.green,
                ),
                _infoCard(
                  'Inactive',
                  branches
                      .where((b) => b['status'] == 'Inactive')
                      .length
                      .toString(),
                  Icons.cancel,
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
                      hintText: 'Search Branches...',
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Branch Name',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('Location', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Status', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Actions', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: filteredBranches.length,
                itemBuilder: (context, index) {
                  final branch = filteredBranches[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(branch['name']!),
                        Text(branch['location']!),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: branch['status'] == 'Active'
                                ? Colors.green.withOpacity(0.1)
                                : Colors.red.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            branch['status']!,
                            style: TextStyle(
                              color: branch['status'] == 'Active'
                                  ? Colors.green
                                  : Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (_) => EditBranchForm(
                                    branch: branch,
                                    onSave: (updatedBranch) {
                                      setState(() {
                                        branches[index] = updatedBranch;
                                      });
                                    },
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (_) => ConfirmDeleteModal(
                                    itemName: branch['name']!,
                                    onConfirm: () {
                                      setState(() {
                                        branches.removeAt(index);
                                      });
                                    },
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
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
