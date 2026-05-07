import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../models/app_state.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../widgets/widgets.dart';
import 'invoice_detail_screen.dart';

class InvoicesScreen extends StatefulWidget {
  const InvoicesScreen({super.key});

  @override
  State<InvoicesScreen> createState() => _InvoicesScreenState();
}

class _InvoicesScreenState extends State<InvoicesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();

    return Scaffold(
      backgroundColor: AppTheme.bg,
      body: Column(
        children: [
          Container(
            decoration: AppTheme.headerDecoration,
            padding: const EdgeInsets.fromLTRB(16, 54, 16, 14),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat('MMM d, yyyy')
                            .format(DateTime.now())
                            .toUpperCase(),
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.navy.withOpacity(0.55),
                          letterSpacing: 0.4,
                        ),
                      ),
                      Text('INVOICES', style: AppTheme.heading1),
                    ],
                  ),
                ),
                const Icon(Icons.calendar_today_outlined,
                    color: AppTheme.navy, size: 20),
                const SizedBox(width: 10),
                const AppAvatar(),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(14, 10, 14, 0),
            decoration: BoxDecoration(
              color: AppTheme.navy.withOpacity(0.07),
              borderRadius: BorderRadius.circular(14),
            ),
            padding: const EdgeInsets.all(3),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(11),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              labelColor: AppTheme.navy,
              unselectedLabelColor: AppTheme.textMuted,
              labelStyle: GoogleFonts.inter(
                  fontSize: 9.5, fontWeight: FontWeight.w700),
              unselectedLabelStyle: GoogleFonts.inter(
                  fontSize: 9.5, fontWeight: FontWeight.w700),
              dividerColor: Colors.transparent,
              tabs: [
                Tab(text: 'UNPAID ${state.unpaidInvoices.length}'),
                Tab(text: 'PAID ${state.paidInvoices.length}'),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _InvoiceList(invoices: state.unpaidInvoices),
                _InvoiceList(invoices: state.paidInvoices),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InvoiceList extends StatelessWidget {
  final List<InvoiceModel> invoices;

  const _InvoiceList({required this.invoices});

  @override
  Widget build(BuildContext context) {
    if (invoices.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.receipt_long_outlined,
                size: 64, color: AppTheme.navy.withOpacity(0.2)),
            const SizedBox(height: 10),
            Text(
              'NOTHING HERE',
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: AppTheme.navy.withOpacity(0.3),
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
      );
    }

    final state = context.read<AppState>();

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(14, 4, 14, 100),
      itemCount: invoices.length,
      itemBuilder: (_, i) {
        final inv = invoices[i];
        final project =
            state.projects.firstWhere((p) => p.id == inv.projectId);
        return InvoiceCard(invoice: inv, project: project);
      },
    );
  }
}

class InvoiceCard extends StatelessWidget {
  final InvoiceModel invoice;
  final ProjectModel project;

  const InvoiceCard({super.key, required this.invoice, required this.project});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) =>
              InvoiceDetailScreen(invoice: invoice, project: project),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: AppTheme.cardDecoration,
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        project.name,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: AppTheme.navy,
                          letterSpacing: -0.2,
                        ),
                      ),
                      Text(
                        'CLIENT NAME',
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
                ArrowButton(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => InvoiceDetailScreen(
                        invoice: invoice,
                        project: project,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                AppPill(
                  text: invoice.dueDate.isBefore(DateTime.now())
                      ? 'DUE TODAY'
                      : DateFormat('MMM dd, yyyy').format(invoice.dueDate),
                  bgColor: invoice.dueDate.isBefore(DateTime.now())
                      ? AppTheme.navy
                      : const Color(0xFFE0E2DC),
                  textColor: invoice.dueDate.isBefore(DateTime.now())
                      ? Colors.white
                      : const Color(0xFF555555),
                ),
                const SizedBox(width: 6),
                AppPill.lime('${invoice.total.toStringAsFixed(0)} EGP'),
                const Spacer(),
                AppPill(
                  text: invoice.status.label,
                  bgColor: invoice.status.bgColor,
                  textColor: invoice.status.textColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
