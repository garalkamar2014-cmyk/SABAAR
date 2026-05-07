// task_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/app_state.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../widgets/widgets.dart';

class TaskDetailScreen extends StatelessWidget {
  final TaskModel task;
  final ProjectModel project;

  const TaskDetailScreen({
    super.key,
    required this.task,
    required this.project,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Center(
          child: GestureDetector(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFBFC2BC),
                borderRadius: BorderRadius.circular(22),
              ),
              padding: const EdgeInsets.all(18),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.name,
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: AppTheme.navy,
                      letterSpacing: -0.3,
                    ),
                  ),
                  Text(
                    project.name,
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.navy,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _MetaCell(
                        label: 'Status',
                        child: const AppPill(
                          text: 'DUE TODAY',
                          bgColor: AppTheme.navy,
                        ),
                      ),
                      const SizedBox(width: 8),
                      _MetaCell(
                        label: 'Due',
                        child: AppPill.lime('JAN 10, 2025'),
                      ),
                      const SizedBox(width: 8),
                      _MetaCell(
                        label: 'Priority',
                        child: AppPill(
                          text: task.priority.label,
                          bgColor: AppTheme.teal,
                          textColor: const Color(0xFF0A3028),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Description',
                    style: GoogleFonts.inter(
                      fontSize: 9.5,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.navy,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppTheme.navy.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      task.description.isNotEmpty
                          ? task.description
                          : 'No description added.',
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF444444),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Status',
                            style: GoogleFonts.inter(
                              fontSize: 8.5,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.navy.withOpacity(0.6),
                            ),
                          ),
                          const SizedBox(height: 3),
                          AppPill(
                            text:
                                task.isInvoiced ? 'INVOICED' : 'NOT INVOICED',
                            bgColor: AppTheme.teal,
                            textColor: const Color(0xFF0A3028),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Price',
                            style: GoogleFonts.inter(
                              fontSize: 8.5,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.navy.withOpacity(0.6),
                            ),
                          ),
                          const SizedBox(height: 3),
                          AppPill.lime(
                              '${task.price.toStringAsFixed(0)} EGP'),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _PopupButton(
                        label: 'VIEW PROJECT',
                        icon: Icons.list_alt_outlined,
                        onTap: () => Navigator.pop(context),
                      ),
                      const SizedBox(width: 8),
                      _PopupButton(
                        label: 'RESCHEDULE TASK',
                        icon: Icons.calendar_today_outlined,
                        onTap: () {},
                      ),
                      const SizedBox(width: 8),
                      _PopupButton(
                        label: 'MARK AS DONE',
                        icon: Icons.check,
                        iconBg: AppTheme.lime,
                        onTap: () {
                          context
                              .read<AppState>()
                              .toggleTask(project.id, task.id);
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MetaCell extends StatelessWidget {
  final String label;
  final Widget child;

  const _MetaCell({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 8.5,
            fontWeight: FontWeight.w600,
            color: AppTheme.navy.withOpacity(0.6),
          ),
        ),
        const SizedBox(height: 3),
        child,
      ],
    );
  }
}

class _PopupButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color? iconBg;
  final VoidCallback onTap;

  const _PopupButton({
    required this.label,
    required this.icon,
    this.iconBg,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: AppTheme.navy.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 4),
          child: Column(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: iconBg ?? Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: AppTheme.navy, size: 14),
              ),
              const SizedBox(height: 5),
              Text(
                label,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 7.5,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.navy,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
