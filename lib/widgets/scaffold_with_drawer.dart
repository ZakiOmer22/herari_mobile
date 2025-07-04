import 'package:flutter/material.dart';

class ScaffoldWithDrawer extends StatelessWidget {
  final Widget body;
  final int selectedIndex;
  final String title;

  const ScaffoldWithDrawer({
    Key? key,
    required this.body,
    required this.selectedIndex,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void onTap(int index) {
      if (index == selectedIndex) return;

      switch (index) {
        case 0:
          Navigator.pushReplacementNamed(context, '/');
          break;
      }
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              const DrawerHeader(
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
              buildDrawerItem(Icons.dashboard, "Dashboard"),
              buildDrawerItem(Icons.people, "Patients"),
              buildDrawerItem(Icons.receipt_long, "Invoices"),
              buildDrawerItem(Icons.settings, "Settings"),
              const Divider(),
              buildDrawerItem(Icons.logout, "Logout"),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.account_circle_outlined),
            onPressed: () {},
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: onTap,
        selectedItemColor: Colors.green,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'Invoices',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
        ],
      ),
      body: body,
    );
  }

  Widget buildDrawerItem(IconData icon, String label) {
    return ListTile(
      leading: Icon(icon, color: Colors.green),
      title: Text(label),
      onTap: () {},
    );
  }
}
