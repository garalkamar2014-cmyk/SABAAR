import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/app_state.dart';
import '../widgets/widgets.dart';
import 'dashboard_screen.dart';
import 'projects_screen.dart';
import 'invoices_screen.dart';
import 'spaces_screen.dart';
import 'new_project_screen.dart';
import 'new_invoice_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;
  bool _showAddMenu = false;

  final List<Widget> _screens = const [
    DashboardScreen(),
    ProjectsScreen(),
    InvoicesScreen(),
    SpacesScreen(),
  ];

  void _onNavTap(int index) {
    setState(() {
      _currentIndex = index;
      _showAddMenu = false;
    });
  }

  void _onPlusTap() {
    setState(() => _showAddMenu = !_showAddMenu);
  }

  void _openNewProject() {
    setState(() => _showAddMenu = false);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const NewProjectScreen()),
    );
  }

  void _openNewInvoice() {
    setState(() => _showAddMenu = false);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const NewInvoiceScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(
            index: _currentIndex,
            children: _screens,
          ),
          GlassNavBar(
            currentIndex: _currentIndex,
            onTap: _onNavTap,
            onPlusTap: _onPlusTap,
          ),
          if (_showAddMenu)
            AddMenuOverlay(
              showNewSpace: _currentIndex == 3,
              onNewProject: _openNewProject,
              onNewInvoice: _openNewInvoice,
              onAiMode: () => setState(() => _showAddMenu = false),
              onNewSpace: () => setState(() => _showAddMenu = false),
              onDismiss: () => setState(() => _showAddMenu = false),
            ),
        ],
      ),
    );
  }
}
