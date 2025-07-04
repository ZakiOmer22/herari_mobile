import 'package:flutter/material.dart';
import 'package:majid/screens/pages/appointement_page.dart';
import 'package:majid/screens/pages/assets_page.dart';
import 'package:majid/screens/pages/audit_log_page.dart';
import 'package:majid/screens/pages/departements_page.dart';
import 'package:majid/screens/pages/employee_page.dart';
import 'package:majid/screens/pages/expenses_page.dart';
import 'package:majid/screens/pages/inventory_page.dart';
import 'package:majid/screens/pages/invoices_page.dart';
import 'package:majid/screens/pages/known_test_page.dart';
import 'package:majid/screens/pages/lab_test_page.dart';
import 'package:majid/screens/pages/lab_test_result_page.dart';
import 'package:majid/screens/pages/leave_request_page.dart';
import 'package:majid/screens/pages/maintaince_page.dart';
import 'package:majid/screens/pages/medicines_pages.dart';
import 'package:majid/screens/pages/patients_page.dart';
import 'package:majid/screens/pages/payments_page.dart';
import 'package:majid/screens/pages/payroll_page.dart';
import 'package:majid/screens/pages/precrestions_page.dart';
import 'package:majid/screens/pages/roles_page.dart';
import 'package:majid/screens/pages/suppliers_page.dart';
import 'package:majid/screens/pages/users_page.dart';
import 'screens/splash_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/pages/branches_page.dart'; // <-- Import real BranchesPage

// Dummy placeholder page for all routes
class PlaceholderPage extends StatelessWidget {
  final String title;
  const PlaceholderPage(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text('This is the $title page')),
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HERARI Clinic Manager',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/dashboard': (context) => DashboardScreen(),

        // Hospital
        '/branches': (context) => const BranchesPage(),
        '/departments': (context) => const DepartmentsPage(),
        '/patients': (context) => const PatientsPage(),
        '/appointments': (context) => const AppointmentsPage(),

        // HR & Admin
        '/employees': (context) => const EmployeesPage(),
        '/leave_requests': (context) => const LeaveRequestsPage(),
        '/early_exit_requests': (context) =>
            const PlaceholderPage('Early Exit Requests'),
        '/payroll': (context) => const PayrollPage(),
        '/users': (context) => const UsersPage(),
        '/roles': (context) => const RolesPage(),

        // Finance
        '/invoices': (context) => const InvoicesPage(),
        '/payments': (context) => const PaymentsPage(),
        '/expenses': (context) => const ExpensesPage(),
        '/receipts': (context) => const PlaceholderPage('Receipts'),

        // Inventory & Pharmacy
        '/suppliers': (context) => const SuppliersPage(),
        '/inventory': (context) => const InventoryPage(),
        '/medicines': (context) => const MedicinesPage(),
        '/prescriptions': (context) => const PrescriptionsPage(),

        // Lab & Tests
        '/lab_tests': (context) => const LabTestsPage(),
        '/known_tests': (context) => const KnownTestsPage(),
        '/lab_test_results': (context) => const LabTestResultsPage(),

        // Assets
        '/assets': (context) => const AssetsPage(),
        '/maintenance_logs': (context) => const MaintenanceLogsPage(),

        // System
        '/audit_logs': (context) => const AuditLogsPage(),
      },
    );
  }
}
