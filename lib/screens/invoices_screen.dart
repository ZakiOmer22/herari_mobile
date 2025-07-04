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
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/invoiceDetails', arguments: data);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
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
                Icon(Icons.more_vert),
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
                  "\$${data['amount']}",
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
                    "${data['address']}",
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                ),
              ],
            ),
            SizedBox(height: 4),
            Text(
              "${data['date']}",
              style: TextStyle(color: Colors.grey[500], fontSize: 12),
            ),
          ],
        ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F8FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text("Invoices", style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search, color: Colors.black),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert, color: Colors.black),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
            controller: _tabController,
            indicatorColor: Colors.transparent,
            labelPadding: EdgeInsets.symmetric(horizontal: 8),
            onTap: (_) => setState(() {}),
            tabs: [
              buildTab("Active", _tabController.index == 0),
              buildTab("Rejected", _tabController.index == 1),
              buildTab("Dispatched", _tabController.index == 2),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                buildInvoiceList("Active"),
                buildInvoiceList("Rejected"),
                buildInvoiceList("Dispatched"),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long, color: Colors.green),
            label: "Invoices",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: "Settings",
          ),
        ],
      ),
    );
  }

  Widget buildInvoiceList(String status) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: ListView(
        children: invoiceData
            .where((o) => o['status'] == status)
            .map((invoice) => buildInvoiceCard(invoice))
            .toList(),
      ),
    );
  }
}
