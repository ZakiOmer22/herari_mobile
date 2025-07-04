import 'package:flutter/material.dart';

class InvoicesScreen extends StatefulWidget {
  const InvoicesScreen({Key? key}) : super(key: key);

  @override
  State<InvoicesScreen> createState() => _InvoicesScreenState();
}

class _InvoicesScreenState extends State<InvoicesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> invoiceData = [
    {
      'status': 'Active',
      'id': '#213421',
      'amount': '4560',
      'address': 'Branch A - Neurology Dept.',
      'date': 'Wed, 17 May | 08:30 AM',
      'color': Colors.orange,
    },
    {
      'status': 'Rejected',
      'id': '#213426',
      'amount': '3000',
      'address': 'Branch B - Pediatrics Dept.',
      'date': 'Fri, 19 May | 11:00 AM',
      'color': Colors.red,
    },
    {
      'status': 'Dispatched',
      'id': '#213429',
      'amount': '4900',
      'address': 'Branch C - Emergency Wing',
      'date': 'Sun, 21 May | 10:00 AM',
      'color': Colors.green,
    },
  ];

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  Widget buildInvoiceCard(Map<String, dynamic> data) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Invoice ${data['status']}",
                style: TextStyle(
                  color: data['color'],
                  fontWeight: FontWeight.w600,
                ),
              ),
              PopupMenuButton<String>(
                icon: Icon(Icons.more_vert),
                itemBuilder: (context) => [
                  PopupMenuItem(value: 'view', child: Text('View Details')),
                  PopupMenuItem(value: 'cancel', child: Text('Cancel Invoice')),
                ],
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "ID ${data['id']}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "\$ ${data['amount']}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.location_on, color: Colors.grey, size: 16),
              SizedBox(width: 4),
              Expanded(
                child: Text(
                  data['address'],
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
          Text(
            data['date'],
            style: TextStyle(color: Colors.grey[500], fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget buildTab(String label, bool selected) {
    return Tab(
      child: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: selected ? Color(0xFF2E7D32) : Colors.grey,
        ),
      ),
    );
  }

  Widget buildAnalyticsCard(String label, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        margin: EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, size: 28, color: Color(0xFF2E7D32)),
            SizedBox(height: 6),
            Text(
              value,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(label, style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget buildBottomBar() {
    return BottomAppBar(
      color: Colors.white,
      elevation: 8,
      child: SizedBox(
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.home_outlined, color: Colors.grey),
                Text('Home', style: TextStyle(fontSize: 12)),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.receipt_long, color: Colors.green),
                Text(
                  'Invoices',
                  style: TextStyle(fontSize: 12, color: Colors.green),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.settings_outlined, color: Colors.grey),
                Text('Settings', style: TextStyle(fontSize: 12)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDrawerItem({required IconData icon, required String label}) {
    return ListTile(
      leading: Icon(icon, color: Colors.green),
      title: Text(label),
      onTap: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F8FA),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Color(0xFF2E7D32)),
                child: Center(
                  child: Text(
                    "Clinic Dashboard",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              buildDrawerItem(icon: Icons.dashboard, label: "Dashboard"),
              buildDrawerItem(icon: Icons.people, label: "Patients"),
              buildDrawerItem(icon: Icons.receipt_long, label: "Invoices"),
              buildDrawerItem(icon: Icons.history, label: "Transactions"),
              buildDrawerItem(
                icon: Icons.account_balance_wallet,
                label: "Finance",
              ),
              buildDrawerItem(icon: Icons.settings, label: "Settings"),
              Divider(),
              buildDrawerItem(icon: Icons.logout, label: "Log Out"),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        titleSpacing: 16,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Invoices",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.search, color: Colors.black),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.more_vert, color: Colors.black),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: buildBottomBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                buildAnalyticsCard("Total Invoices", "36", Icons.receipt),
                buildAnalyticsCard("Paid", "24", Icons.check_circle_outline),
                buildAnalyticsCard("Unpaid", "12", Icons.pending_actions),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TabBar(
              controller: _tabController,
              indicatorColor: Colors.transparent,
              labelPadding: EdgeInsets.symmetric(horizontal: 8),
              tabs: [
                buildTab("Active", _tabController.index == 0),
                buildTab("Rejected", _tabController.index == 1),
                buildTab("Dispatched", _tabController.index == 2),
              ],
              onTap: (_) => setState(() {}),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: ListView(
                    children: invoiceData
                        .where((o) => o['status'] == 'Active')
                        .map((invoice) => buildInvoiceCard(invoice))
                        .toList(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: ListView(
                    children: invoiceData
                        .where((o) => o['status'] == 'Rejected')
                        .map((invoice) => buildInvoiceCard(invoice))
                        .toList(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: ListView(
                    children: invoiceData
                        .where((o) => o['status'] == 'Dispatched')
                        .map((invoice) => buildInvoiceCard(invoice))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
