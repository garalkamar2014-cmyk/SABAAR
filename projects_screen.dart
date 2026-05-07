import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../models/app_state.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../widgets/widgets.dart';
import 'project_detail_screen.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
                      Text('PROJECTS', style: AppTheme.heading1),
                    ],
                  ),
                ),
                Icon(Icons.calendar_today_outlined,
                    color: AppTheme.navy, size: 20),
                const SizedBox(width: 10),
                const AppAvatar(),
              ],
            ),
          ),

          // Tab Bar
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
                fontSize: 9.5,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.2,
              ),
              unselectedLabelStyle: GoogleFonts.inter(
                fontSize: 9.5,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.2,
              ),
              dividerColor: Colors.transparent,
              tabs: [
                Tab(text: 'ACTIVE ${state.activeProjects.length}'),
                Tab(text: 'ON HOLD ${state.onHoldProjects.length}'),
                Tab(text: 'COMPLETED ${state.completedProjects.length}'),
              ],
            ),
          ),
          const SizedBox(height: 8),

          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _ProjectList(projects: state.activeProjects),
                _ProjectList(projects: state.onHoldProjects),
                _ProjectList(projects: state.completedProjects),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProjectList extends StatelessWidget {
  final List<ProjectModel> projects;

  const _ProjectList({required this.projects});

  @override
  Widget build(BuildContext context) {
    if (projects.isEmpty) {
      return const _EmptyState();
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(14, 4, 14, 100),
      itemCount: projects.length,
      itemBuilder: (_, i) => ProjectCard(project: projects[i]),
    );
  }
}

class ProjectCard extends StatelessWidget {
  final ProjectModel project;

  const ProjectCard({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ProjectDetailScreen(projectId: project.id),
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
                      builder: (_) =>
                          ProjectDetailScreen(projectId: project.id),
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'TASKS ${project.doneTasks} / ${project.tasks.length}',
                style: GoogleFonts.inter(
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textMuted,
                ),
              ),
            ),
            const SizedBox(height: 3),
            AppProgressBar(value: project.progress),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  'PENDING ',
                  style: GoogleFonts.inter(
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textMuted,
                  ),
                ),
                Text(
                  '${project.pendingInvoices}',
                  style: GoogleFonts.inter(
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.navy,
                  ),
                ),
                const SizedBox(width: 6),
                if (project.dueDate != null)
                  AppPill(
                    text: project.status == ProjectStatus.active
                        ? 'DUE TODAY'
                        : DateFormat('MMM dd, yyyy').format(project.dueDate!),
                    bgColor: project.status == ProjectStatus.active
                        ? AppTheme.navy
                        : AppTheme.lime,
                    textColor: project.status == ProjectStatus.active
                        ? Colors.white
                        : AppTheme.limeText,
                  ),
                const Spacer(),
                AppPill(
                  text: project.status.label,
                  bgColor: project.status.bgColor,
                  textColor: project.status.textColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.grass_outlined,
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
}
