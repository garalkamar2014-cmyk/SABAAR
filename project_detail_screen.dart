import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/app_state.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../widgets/widgets.dart';
import 'task_detail_screen.dart';
import 'invoice_detail_screen.dart';
import 'new_invoice_screen.dart';

class ProjectDetailScreen extends StatelessWidget {
  final String projectId;

  const ProjectDetailScreen({super.key, required this.projectId});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final project = state.getProject(projectId);

    if (project == null) {
      return const Scaffold(body: Center(child: Text('Project not found')));
    }

    return Scaffold(
      backgroundColor: AppTheme.bg,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: _ProjectHeader(project: project)),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(14, 14, 14, 160),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    const SectionTitle('TASKS'),
                    ...project.tasks.map(
                      (task) => _TaskItem(task: task, project: project),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Text(
                          '+ ADD TASK',
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.teal,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const SectionTitle('NOTES'),
                    Container(
                      decoration: AppTheme.cardDecoration,
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        project.notes.isNotEmpty
                            ? project.notes
                            : 'No notes added yet.',
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.textMuted,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '+ ADD NOTES',
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.teal,
                      ),
                    ),
                    const SizedBox(height: 14),
                    const SectionTitle('INVOICE'),
                    ...project.invoices.map(
                      (inv) => GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => InvoiceDetailScreen(
                              invoice: inv,
                              project: project,
                            ),
                          ),
                        ),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          decoration: AppTheme.cardDecoration,
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'INVOICE NUMBER: ${inv.invoiceNumber}',
                                style: GoogleFonts.inter(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: AppTheme.navy,
                                ),
                              ),
                              const SizedBox(height: 7),
                              Row(
                                children: [
                                  AppPill(
                                    text: inv.status.label,
                                    bgColor: inv.status.bgColor,
                                    textColor: inv.status.textColor,
                                  ),
                                  const SizedBox(width: 6),
                                  AppPill.lime(
                                    'JAN 10, 2025',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (project.invoices.isEmpty)
                      Text(
                        'No invoices yet.',
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          color: AppTheme.textMuted,
                        ),
                      ),
                  ]),
                ),
              ),
            ],
          ),

          // Action Row
          Positioned(
            bottom: 80,
            left: 14,
            right: 14,
            child: Row(
              children: [
                _ActionButton(
                  label: 'ADD TASK',
                  icon: Icons.add_box_outlined,
                  onTap: () {},
                ),
                const SizedBox(width: 8),
                _ActionButton(
                  label: 'CREATE INVOICE',
                  icon: Icons.receipt_outlined,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          NewInvoiceScreen(preselectedProject: project),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                _ActionButton(
                  label: 'CANCEL PROJECT',
                  icon: Icons.close,
                  onTap: () {
                    context.read<AppState>().deleteProject(projectId);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),

          // Back button in nav area
          Positioned(
            bottom: 14,
            left: 14,
            right: 14,
            child: _BackNav(onBack: () => Navigator.pop(context)),
          ),
        ],
      ),
    );
  }
}

class _ProjectHeader extends StatelessWidget {
  final ProjectModel project;

  const _ProjectHeader({required this.project});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppTheme.headerDecoration,
      padding: const EdgeInsets.fromLTRB(16, 54, 16, 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CLIENT NAME',
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.textMuted,
                  ),
                ),
                Text(
                  project.name,
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: AppTheme.navy,
                    letterSpacing: -0.4,
                  ),
                ),
                const SizedBox(height: 8),
                AppPill(
                  text: project.status.label,
                  bgColor: project.status.bgColor,
                  textColor: project.status.textColor,
                ),
              ],
            ),
          ),
          SizedBox(
            width: 70,
            height: 70,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: project.progress,
                  strokeWidth: 8,
                  backgroundColor: AppTheme.navy.withOpacity(0.15),
                  valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.lime),
                  strokeCap: StrokeCap.round,
                ),
                Text(
                  '${(project.progress * 100).round()}%',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.navy,
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

class _TaskItem extends StatelessWidget {
  final TaskModel task;
  final ProjectModel project;

  const _TaskItem({required this.task, required this.project});

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
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => context
                  .read<AppState>()
                  .toggleTask(project.id, task.id),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: task.isDone ? AppTheme.navy : Colors.transparent,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: task.isDone ? AppTheme.navy : Colors.grey.shade400,
                    width: 2,
                  ),
                ),
                child: task.isDone
                    ? const Icon(Icons.check, size: 10, color: Colors.white)
                    : null,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                task.name,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color:
                      task.isDone ? AppTheme.textMuted : AppTheme.navy,
                  decoration: task.isDone
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
            ),
            AppPill.lime('JAN 06, 2026'),
            const SizedBox(width: 6),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      TaskDetailScreen(task: task, project: project),
                ),
              ),
              child: Container(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  color: AppTheme.teal,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.arrow_forward,
                    color: Colors.white, size: 13),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: AppTheme.navy.withOpacity(0.07),
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
          child: Column(
            children: [
              Text(
                label,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 8,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.navy,
                  letterSpacing: 0.2,
                ),
              ),
              const SizedBox(height: 5),
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: AppTheme.navy, size: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BackNav extends StatelessWidget {
  final VoidCallback onBack;

  const _BackNav({required this.onBack});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(26),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.28),
          borderRadius: BorderRadius.circular(26),
          border: Border.all(color: Colors.white.withOpacity(0.55)),
          boxShadow: [
            BoxShadow(
              color: AppTheme.navy.withOpacity(0.12),
              blurRadius: 32,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: onBack,
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppTheme.navy,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Icon(Icons.arrow_back,
                    color: Colors.white, size: 22),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
