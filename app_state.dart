import 'package:flutter/material.dart';
import 'models.dart';

class AppState extends ChangeNotifier {
  // Designer info
  String designerName = 'Abdullah Abdeen';
  String designerCity = 'Cairo, Egypt';
  String designerPhone = '+20 10 1455 9799';

  // Sample data
  List<ProjectModel> projects = [
    ProjectModel(
      id: 'p1',
      name: 'AL MEHAILY LAW',
      clientName: 'AL MEHAILY LAW FIRM',
      clientCity: 'Makkah, Saudi Arabia',
      clientPhone: '+966 54 098 2204',
      status: ProjectStatus.active,
      notes:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est a, mattis tellus.',
      dueDate: DateTime(2026, 1, 5),
      tasks: [
        TaskModel(
          id: 't1',
          name: 'LOGO DESIGN',
          isDone: true,
          dueDate: DateTime(2026, 1, 6),
          priority: TaskPriority.urgent,
          description: 'Design the main logo for the law firm.',
          price: 3000,
          isInvoiced: true,
        ),
        TaskModel(
          id: 't2',
          name: 'SOCIAL MEDIA DESIGN',
          isDone: true,
          dueDate: DateTime(2026, 1, 6),
          priority: TaskPriority.urgent,
          description: 'Create social media templates.',
          price: 3600,
          isInvoiced: true,
        ),
        TaskModel(
          id: 't3',
          name: 'PRINTABLE',
          isDone: true,
          dueDate: DateTime(2026, 1, 6),
          priority: TaskPriority.normal,
          description: 'Design printable materials.',
          price: 6000,
          isInvoiced: true,
        ),
        TaskModel(
          id: 't4',
          name: 'STICKERS',
          isDone: false,
          dueDate: DateTime(2026, 1, 6),
          priority: TaskPriority.normal,
          description: 'Design sticker pack.',
          price: 4500,
          isInvoiced: false,
        ),
        TaskModel(
          id: 't5',
          name: 'COMPANY PROFILE',
          isDone: false,
          dueDate: DateTime(2026, 1, 6),
          priority: TaskPriority.low,
          description: 'Design company profile document.',
          price: 0,
          isInvoiced: false,
        ),
      ],
      invoices: [
        InvoiceModel(
          id: 'i1',
          invoiceNumber: '#0002',
          status: InvoiceStatus.paid,
          dueDate: DateTime(2025, 1, 10),
          projectId: 'p1',
          lines: [
            InvoiceLine(taskName: 'LOGO DESIGN', unit: 1, rate: 3000),
            InvoiceLine(taskName: 'SOCIAL MEDIA DESIGN', unit: 12, rate: 300),
            InvoiceLine(taskName: 'PRINTABLE', unit: 5, rate: 300),
            InvoiceLine(taskName: 'STICKERS', unit: 6, rate: 750),
          ],
        ),
      ],
    ),
    ProjectModel(
      id: 'p2',
      name: 'BLOOMY BUNNY',
      clientName: 'BLOOMY BUNNY',
      clientCity: 'Cairo, Egypt',
      clientPhone: '+20 10 0000 0000',
      status: ProjectStatus.active,
      dueDate: DateTime(2026, 1, 5),
      tasks: [
        TaskModel(
          id: 't6',
          name: 'LOGO DESIGN',
          isDone: true,
          dueDate: DateTime(2025, 1, 5),
          priority: TaskPriority.urgent,
          price: 3000,
        ),
        TaskModel(
          id: 't7',
          name: 'BRAND IDENTITY',
          isDone: false,
          dueDate: DateTime(2025, 1, 5),
          priority: TaskPriority.urgent,
          price: 5000,
        ),
      ],
      invoices: [
        InvoiceModel(
          id: 'i2',
          invoiceNumber: '#0003',
          status: InvoiceStatus.unpaid,
          dueDate: DateTime(2025, 2, 4),
          projectId: 'p2',
          lines: [
            InvoiceLine(taskName: 'LOGO DESIGN', unit: 1, rate: 5000),
          ],
        ),
      ],
    ),
    ProjectModel(
      id: 'p3',
      name: 'RIFAD LAW FIRM',
      clientName: 'RIFAD LAW FIRM',
      clientCity: 'Riyadh, Saudi Arabia',
      clientPhone: '+966 50 000 0000',
      status: ProjectStatus.onHold,
      dueDate: DateTime(2026, 1, 30),
      tasks: List.generate(
        10,
        (i) => TaskModel(
          id: 'tp3_$i',
          name: 'TASK ${i + 1}',
          isDone: false,
          dueDate: DateTime(2026, 1, 30),
        ),
      ),
      invoices: [
        InvoiceModel(
          id: 'i3',
          invoiceNumber: '#0004',
          status: InvoiceStatus.unpaid,
          dueDate: DateTime(2026, 1, 30),
          projectId: 'p3',
          lines: [
            InvoiceLine(taskName: 'RETAINER', unit: 1, rate: 5000),
          ],
        ),
      ],
    ),
    ProjectModel(
      id: 'p4',
      name: 'NEXUS TECH',
      clientName: 'NEXUS TECH',
      clientCity: 'Dubai, UAE',
      clientPhone: '+971 50 000 0000',
      status: ProjectStatus.completed,
      dueDate: DateTime(2026, 1, 5),
      tasks: List.generate(
        8,
        (i) => TaskModel(
          id: 'tp4_$i',
          name: 'TASK ${i + 1}',
          isDone: true,
          dueDate: DateTime(2026, 1, 5),
        ),
      ),
      invoices: [
        InvoiceModel(
          id: 'i4',
          invoiceNumber: '#0005',
          status: InvoiceStatus.unpaid,
          dueDate: DateTime(2025, 2, 4),
          projectId: 'p4',
          lines: [
            InvoiceLine(taskName: 'BRAND PACKAGE', unit: 1, rate: 5000),
          ],
        ),
      ],
    ),
    ProjectModel(
      id: 'p5',
      name: 'AA MEDIA',
      clientName: 'AA MEDIA',
      clientCity: 'Cairo, Egypt',
      clientPhone: '+20 10 0000 0001',
      status: ProjectStatus.completed,
      dueDate: DateTime(2026, 1, 5),
      tasks: List.generate(
        8,
        (i) => TaskModel(
          id: 'tp5_$i',
          name: 'TASK ${i + 1}',
          isDone: true,
          dueDate: DateTime(2026, 1, 5),
        ),
      ),
      invoices: [],
    ),
    ProjectModel(
      id: 'p6',
      name: 'DIAMOND STEPS',
      clientName: 'DIAMOND STEPS',
      clientCity: 'Alexandria, Egypt',
      clientPhone: '+20 10 0000 0002',
      status: ProjectStatus.completed,
      dueDate: DateTime(2026, 1, 6),
      tasks: List.generate(
        8,
        (i) => TaskModel(
          id: 'tp6_$i',
          name: 'TASK ${i + 1}',
          isDone: true,
          dueDate: DateTime(2026, 1, 6),
        ),
      ),
      invoices: [],
    ),
  ];

  List<SpaceModel> spaces = [
    SpaceModel(
      id: 's1',
      name: 'MY WORKSPACE',
      userName: 'ABDULLAH ABDEEN',
      color: const Color(0xFF3ECFB0),
    ),
    SpaceModel(
      id: 's2',
      name: 'DESIGN STUDIO',
      userName: 'USER NAME',
      color: const Color(0xFFA8C830),
    ),
    SpaceModel(
      id: 's3',
      name: 'FREELANCE HUB',
      userName: 'USER NAME',
      color: const Color(0xFF2A2A2A),
    ),
  ];

  // Getters
  List<ProjectModel> get activeProjects =>
      projects.where((p) => p.status == ProjectStatus.active).toList();

  List<ProjectModel> get onHoldProjects =>
      projects.where((p) => p.status == ProjectStatus.onHold).toList();

  List<ProjectModel> get completedProjects =>
      projects.where((p) => p.status == ProjectStatus.completed).toList();

  List<InvoiceModel> get allInvoices =>
      projects.expand((p) => p.invoices).toList();

  List<InvoiceModel> get unpaidInvoices =>
      allInvoices.where((i) => i.status == InvoiceStatus.unpaid).toList();

  List<InvoiceModel> get paidInvoices =>
      allInvoices.where((i) => i.status == InvoiceStatus.paid).toList();

  List<TaskModel> get todayTasks {
    final today = DateTime.now();
    return projects.expand((p) => p.tasks).where((t) {
      return !t.isDone &&
          t.dueDate.year == today.year &&
          t.dueDate.month == today.month &&
          t.dueDate.day == today.day;
    }).toList();
  }

  double get totalOverdueAmount =>
      unpaidInvoices.fold(0, (sum, i) => sum + i.total);

  // Mutations
  void addProject(ProjectModel project) {
    projects.add(project);
    notifyListeners();
  }

  void updateProject(ProjectModel project) {
    final idx = projects.indexWhere((p) => p.id == project.id);
    if (idx != -1) {
      projects[idx] = project;
      notifyListeners();
    }
  }

  void deleteProject(String id) {
    projects.removeWhere((p) => p.id == id);
    notifyListeners();
  }

  void toggleTask(String projectId, String taskId) {
    final proj = projects.firstWhere((p) => p.id == projectId);
    final task = proj.tasks.firstWhere((t) => t.id == taskId);
    task.isDone = !task.isDone;
    notifyListeners();
  }

  void markInvoicePaid(String invoiceId) {
    for (final p in projects) {
      for (final inv in p.invoices) {
        if (inv.id == invoiceId) {
          inv.status = InvoiceStatus.paid;
          notifyListeners();
          return;
        }
      }
    }
  }

  void addInvoice(String projectId, InvoiceModel invoice) {
    final proj = projects.firstWhere((p) => p.id == projectId);
    proj.invoices.add(invoice);
    notifyListeners();
  }

  ProjectModel? getProject(String id) {
    try {
      return projects.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }
}
