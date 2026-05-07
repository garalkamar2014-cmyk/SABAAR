import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../models/app_state.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../widgets/widgets.dart';
import 'task_detail_screen.dart';
import 'invoice_detail_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final now = DateTime.now();
    final allTasks = state.projects.expand((p) => p.tasks).toList();
    final doneTasks = allTasks.where((t) => t.isDone).length;
    final pendingTasks = allTasks.where((t) => !t.isDone).length;
    final taskProgress = allTasks.isEmpty ? 0.0 : doneTasks / allTasks.length;
    final overdueInvoices = state.unpaidInvoices;

    return Scaffold(
      backgroundColor: AppTheme.bg,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              decoration: AppTheme.headerDecoration,
              padding: const EdgeInsets.fromLTRB(16, 54, 16, 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat('MMM d, yyyy').format(now).toUpperCase(),
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.navy.withOpacity(0.55),
                            letterSpacing: 0.4,
                          ),
                        ),
                        Text('TODAY', style: AppTheme.heading1),
                      ],
                    ),
                  ),
                  Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: AppTheme.lime,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${now.day}',
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        color: AppTheme.limeText,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const AppAvatar(),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 100),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Widgets Row
                Row(
                  children: [
                    Expanded(
                      child: _TaskProgressWidget(
                        progress: taskProgress,
                        done: doneTasks,
                        pending: pendingTasks,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _OverdueWidget(
                        count: overdueInvoices.length,
                        total: state.totalOverdueAmount,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Today's Tasks
                const SectionTitle("TODAY'S TASKS"),
                ...state.projects
                    .expand((p) => p.tasks
                        .where((t) => !t.isDone)
                        .map((t) => _TodayTaskRow(task: t, project: p)))
                    .take(5)
                    .toList(),
                const SizedBox(height: 16),

                // Today's Invoices
                const SectionTitle("TODAY'S INVOICES"),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1.5,
                  children: overdueInvoices
                      .take(6)
                      .map((inv) => _InvoiceChip(invoice: inv))
                      .toList(),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _TaskProgressWidget extends StatelessWidget {
  final double progress;
  final int done;
  final int pending;

  const _TaskProgressWidget({
    required this.progress,
    required this.done,
    required this.pending,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppTheme.cardDecoration,
      padding: const EdgeInsets.all(14),
      child: Column(
        children: [
          Text(
            'TASKS PROGRESS',
            style: GoogleFonts.inter(
              fontSize: 9,
              fontWeight: FontWeight.w700,
              color: AppTheme.textMuted,
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 72,
            height: 72,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 8,
                  backgroundColor: const Color(0xFFEAECE6),
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(AppTheme.teal),
                  strokeCap: StrokeCap.round,
                ),
                Text(
                  '${(progress * 100).round()}%',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.navy,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'DONE ',
                style: GoogleFonts.inter(
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textMuted),
              ),
              Text(
                '$done',
                style: GoogleFonts.inter(
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.navy),
              ),
              const SizedBox(width: 8),
              Text(
                'PEND ',
                style: GoogleFonts.inter(
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textMuted),
              ),
              Text(
                '$pending',
                style: GoogleFonts.inter(
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.navy),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _OverdueWidget extends StatelessWidget {
  final int count;
  final double total;

  const _OverdueWidget({required this.count, required this.total});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppTheme.cardDecoration,
      padding: const EdgeInsets.all(14),
      child: Column(
        children: [
          Text(
            'OVERDUE INVOICES',
            style: GoogleFonts.inter(
              fontSize: 9,
              fontWeight: FontWeight.w700,
              color: AppTheme.textMuted,
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '$count',
            style: GoogleFonts.inter(
              fontSize: 44,
              fontWeight: FontWeight.w900,
              color: AppTheme.navy,
              height: 1,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'PENDING INVOICES',
            style: GoogleFonts.inter(
              fontSize: 8,
              fontWeight: FontWeight.w700,
              color: AppTheme.textMuted,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppTheme.lime,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(vertical: 6),
            alignment: Alignment.center,
            child: Text(
              '${total.toStringAsFixed(0)} EGP',
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: AppTheme.limeText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TodayTaskRow extends StatelessWidget {
  final TaskModel task;
  final ProjectModel project;

  const _TodayTaskRow({required this.task, required this.project});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => TaskDetailScreen(task: task, project: project),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 6),
        decoration: AppTheme.cardDecoration,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.name,
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.navy,
                    ),
                  ),
                  Text(
                    project.name,
                    style: GoogleFonts.inter(
                      fontSize: 9,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.textMuted,
                    ),
                  ),
                ],
              ),
            ),
            const AppPill(text: 'DUE TODAY', bgColor: AppTheme.navy),
            const SizedBox(width: 6),
            ArrowButton(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      TaskDetailScreen(task: task, project: project),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InvoiceChip extends StatelessWidget {
  final InvoiceModel invoice;

  const _InvoiceChip({required this.invoice});

  @override
  Widget build(BuildContext context) {
    final state = context.read<AppState>();
    final project =
        state.projects.firstWhere((p) => p.id == invoice.projectId);

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) =>
              InvoiceDetailScreen(invoice: invoice, project: project),
        ),
      ),
      child: Container(
        decoration: AppTheme.cardDecoration,
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              project.name,
              style: GoogleFonts.inter(
                fontSize: 9,
                fontWeight: FontWeight.w700,
                color: AppTheme.navy,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              'OVERDUE',
              style: GoogleFonts.inter(
                fontSize: 8.5,
                fontWeight: FontWeight.w500,
                color: AppTheme.textMuted,
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${invoice.total.toStringAsFixed(0)} EGP',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.navy,
                  ),
                ),
                Container(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    color: AppTheme.navy,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.receipt_long,
                    color: Colors.white,
                    size: 13,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
