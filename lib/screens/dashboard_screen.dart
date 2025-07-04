import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> analytics = const [
    {
      'label': 'Patients',
      'value': '220',
      'icon': Icons.people,
      'color': Color(0xFF219EBC),
    },
    {
      'label': 'Doctors',
      'value': '35',
      'icon': Icons.local_hospital,
      'color': Color(0xFF023047),
    },
    {
      'label': 'Appointments',
      'value': '128',
      'icon': Icons.calendar_today,
      'color': Colors.orange,
    },
    {
      'label': 'Revenue',
      'value': '\$25,430',
      'icon': Icons.attach_money,
      'color': Colors.green,
    },
    {
      'label': 'Invoices',
      'value': '92',
      'icon': Icons.receipt_long,
      'color': Colors.deepPurple,
    },
    {
      'label': 'Reports',
      'value': '17',
      'icon': Icons.bar_chart,
      'color': Colors.pink,
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

  Widget buildCard(Map<String, dynamic> data) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: data['color'].withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: data['color'], width: 0.9),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(data['icon'], size: 30, color: data['color']),
          const Spacer(),
          Text(
            data['value'],
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: data['color'],
            ),
          ),
          Text(data['label'], style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  Widget buildDrawer(BuildContext context) {
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
                  leading: Icon(item['icon'], color: Colors.teal),
                  title: Text(item['label']),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(
                      context,
                      '/${item['label'].toString().toLowerCase().replaceAll(' ', '_')}',
                    );
                  },
                ),
            ],
          ],
        ),
      ),
    );
  }

  Widget buildWelcomeCard() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF219EBC),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Text(
        '👋 Welcome, Admin! Here is a quick overview of the clinic today.',
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }

  Widget buildChart() {
    return SizedBox(
      height: 220,
      child: LineChart(
        LineChartData(
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  return Text(
                    ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'][value.toInt() % 5],
                    style: const TextStyle(fontSize: 10),
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          lineBarsData: [
            LineChartBarData(
              isCurved: true,
              spots: const [
                FlSpot(0, 3),
                FlSpot(1, 5),
                FlSpot(2, 2),
                FlSpot(3, 7),
                FlSpot(4, 6),
              ],
              color: const Color(0xFF219EBC),
              barWidth: 3,
              dotData: FlDotData(show: false),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildQuickTable() {
    final tableData = [
      {'Name': 'Ahmed Y.', 'Type': 'Lab Test', 'Status': 'Pending'},
      {'Name': 'Fatima A.', 'Type': 'Prescription', 'Status': 'Dispensed'},
      {'Name': 'Mohamed I.', 'Type': 'Invoice', 'Status': 'Paid'},
    ];

    Color statusColor(String status) {
      switch (status) {
        case 'Pending':
          return Colors.orange;
        case 'Paid':
          return Colors.green;
        case 'Dispensed':
          return Colors.blue;
        default:
          return Colors.grey;
      }
    }

    return DataTable(
      columns: const [
        DataColumn(label: Text('Name')),
        DataColumn(label: Text('Type')),
        DataColumn(label: Text('Status')),
      ],
      rows: tableData.map((row) {
        return DataRow(
          cells: [
            DataCell(Text(row['Name']!)),
            DataCell(Text(row['Type']!)),
            DataCell(
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: statusColor(row['Status']!).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  row['Status']!,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: statusColor(row['Status']!),
                  ),
                ),
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          buildWelcomeCard(),
          GridView.count(
            crossAxisCount: MediaQuery.of(context).size.width < 600 ? 2 : 3,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: analytics.map((e) => buildCard(e)).toList(),
          ),
          const SizedBox(height: 32),
          buildChart(),
          const SizedBox(height: 32),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade200),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Recent Activities',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                buildQuickTable(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: buildDrawer(context),
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 1,
        title: const Text(
          'Dashboard',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none, color: Colors.black),
          ),
        ],
      ),
      backgroundColor: const Color(0xFFF7F8FA),
      body: buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        selectedItemColor: const Color(0xFF219EBC),
        unselectedItemColor: Colors.grey,
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
