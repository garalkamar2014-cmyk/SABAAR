import 'package:flutter/material.dart';

// ── Project Status ──────────────────────────────────────────────────
enum ProjectStatus { active, onHold, completed }

extension ProjectStatusExt on ProjectStatus {
  String get label {
    switch (this) {
      case ProjectStatus.active:
        return 'ACTIVE';
      case ProjectStatus.onHold:
        return 'ON HOLD';
      case ProjectStatus.completed:
        return 'DONE';
    }
  }

  Color get bgColor {
    switch (this) {
      case ProjectStatus.active:
        return const Color(0xFF3ECFB0);
      case ProjectStatus.onHold:
        return const Color(0xFFD8E060);
      case ProjectStatus.completed:
        return const Color(0xFF1A2744);
    }
  }

  Color get textColor {
    switch (this) {
      case ProjectStatus.active:
        return const Color(0xFF0A3028);
      case ProjectStatus.onHold:
        return const Color(0xFF3A4A00);
      case ProjectStatus.completed:
        return Colors.white;
    }
  }
}

// ── Task Priority ────────────────────────────────────────────────────
enum TaskPriority { urgent, normal, low }

extension TaskPriorityExt on TaskPriority {
  String get label {
    switch (this) {
      case TaskPriority.urgent:
        return 'URGENT';
      case TaskPriority.normal:
        return 'NORMAL';
      case TaskPriority.low:
        return 'LOW';
    }
  }
}

// ── Invoice Status ───────────────────────────────────────────────────
enum InvoiceStatus { unpaid, paid }

extension InvoiceStatusExt on InvoiceStatus {
  String get label => this == InvoiceStatus.paid ? 'PAID' : 'UNPAID';
  Color get bgColor =>
      this == InvoiceStatus.paid ? const Color(0xFF1A2744) : const Color(0xFF3ECFB0);
  Color get textColor =>
      this == InvoiceStatus.paid ? Colors.white : const Color(0xFF0A3028);
}

// ── Task ─────────────────────────────────────────────────────────────
class TaskModel {
  final String id;
  String name;
  bool isDone;
  DateTime dueDate;
  TaskPriority priority;
  String description;
  double price;
  bool isInvoiced;

  TaskModel({
    required this.id,
    required this.name,
    this.isDone = false,
    required this.dueDate,
    this.priority = TaskPriority.normal,
    this.description = '',
    this.price = 0,
    this.isInvoiced = false,
  });
}

// ── Invoice Line ─────────────────────────────────────────────────────
class InvoiceLine {
  String taskName;
  int unit;
  double rate;

  InvoiceLine({required this.taskName, required this.unit, required this.rate});

  double get total => unit * rate;
}

// ── Invoice ───────────────────────────────────────────────────────────
class InvoiceModel {
  final String id;
  String invoiceNumber;
  InvoiceStatus status;
  DateTime dueDate;
  List<InvoiceLine> lines;
  String projectId;

  InvoiceModel({
    required this.id,
    required this.invoiceNumber,
    this.status = InvoiceStatus.unpaid,
    required this.dueDate,
    required this.lines,
    required this.projectId,
  });

  double get total => lines.fold(0, (sum, l) => sum + l.total);
}

// ── Project ────────────────────────────────────────────────────────────
class ProjectModel {
  final String id;
  String name;
  String clientName;
  String clientCity;
  String clientPhone;
  ProjectStatus status;
  List<TaskModel> tasks;
  List<InvoiceModel> invoices;
  String notes;
  DateTime? dueDate;

  ProjectModel({
    required this.id,
    required this.name,
    required this.clientName,
    this.clientCity = '',
    this.clientPhone = '',
    this.status = ProjectStatus.active,
    List<TaskModel>? tasks,
    List<InvoiceModel>? invoices,
    this.notes = '',
    this.dueDate,
  })  : tasks = tasks ?? [],
        invoices = invoices ?? [];

  int get doneTasks => tasks.where((t) => t.isDone).length;
  double get progress => tasks.isEmpty ? 0 : doneTasks / tasks.length;
  int get pendingInvoices =>
      invoices.where((i) => i.status == InvoiceStatus.unpaid).length;
}

// ── Space ──────────────────────────────────────────────────────────────
class SpaceModel {
  final String id;
  String name;
  String userName;
  Color color;
  List<ProjectModel> projects;

  SpaceModel({
    required this.id,
    required this.name,
    required this.userName,
    required this.color,
    List<ProjectModel>? projects,
  }) : projects = projects ?? [];

  int get totalTasks =>
      projects.fold(0, (sum, p) => sum + p.tasks.length);
  int get totalInvoices =>
      projects.fold(0, (sum, p) => sum + p.invoices.length);
}
