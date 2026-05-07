import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../models/app_state.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../widgets/widgets.dart';

class InvoiceDetailScreen extends StatelessWidget {
  final InvoiceModel invoice;
  final ProjectModel project;

  const InvoiceDetailScreen({
    super.key,
    required this.invoice,
    required this.project,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bg,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFC8CAC4),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      project.clientName,
                                      style: GoogleFonts.inter(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w900,
                                        color: AppTheme.navy,
                                        letterSpacing: -0.3,
                                        height: 1.2,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      'CLIENT NAME\n${project.clientCity}\nTEL: ${project.clientPhone}',
                                      style: GoogleFonts.inter(
                                        fontSize: 9,
                                        fontWeight: FontWeight.w500,
                                        color: AppTheme.textMuted,
                                        height: 1.6,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: AppTheme.navy.withOpacity(0.12),
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 9, vertical: 7),
                                child: Row(
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          'EDIT',
                                          style: GoogleFonts.inter(
                                            fontSize: 8,
                                            fontWeight: FontWeight.w700,
                                            color: AppTheme.navy,
                                          ),
                                        ),
                                        Text(
                                          'INVOICE',
                                          style: GoogleFonts.inter(
                                            fontSize: 8,
                                            fontWeight: FontWeight.w700,
                                            color: AppTheme.navy,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 6),
                                    Container(
                                      width: 26,
                                      height: 26,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(8),
                                      ),
                                      child: const Icon(
                                        Icons.edit_outlined,
                                        color: AppTheme.navy,
                                        size: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'ABDULLAH ABDEEN\nCairo, Egypt\nTEL: +20 10 1455 9799',
                              textAlign: TextAlign.right,
                              style: GoogleFonts.inter(
                                fontSize: 9,
                                fontWeight: FontWeight.w700,
                                color: AppTheme.navy,
                                height: 1.6,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Divider(
                              color: Color(0xFFB0B2AC), thickness: 1),
                          const SizedBox(height: 8),

                          // Table Header
                          Row(
                            children: [
                              SizedBox(
                                width: 24,
                                child: Text('No.',
                                    style: _headerStyle()),
                              ),
                              Expanded(
                                  child: Text('TASKS',
                                      style: _headerStyle())),
                              SizedBox(
                                  width: 36,
                                  child: Text('UNIT',
                                      style: _headerStyle(),
                                      textAlign: TextAlign.center)),
                              SizedBox(
                                  width: 42,
                                  child: Text('UNIT',
                                      style: _headerStyle(),
                                      textAlign: TextAlign.center)),
                              SizedBox(
                                  width: 48,
                                  child: Text('PRICE',
                                      style: _headerStyle(),
                                      textAlign: TextAlign.right)),
                            ],
                          ),
                          const SizedBox(height: 6),

                          // Lines
                          ...invoice.lines.asMap().entries.map((e) {
                            final i = e.key;
                            final line = e.value;
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: Row(
                                children: [
                                  _Cell(text: '${i + 1}', width: 24),
                                  const SizedBox(width: 4),
                                  Expanded(child: _Cell(text: line.taskName)),
                                  const SizedBox(width: 4),
                                  _Cell(
                                      text: '${line.unit}',
                                      width: 36,
                                      centered: true),
                                  const SizedBox(width: 4),
                                  _Cell(
                                      text:
                                          line.rate.toStringAsFixed(0),
                                      width: 42,
                                      centered: true),
                                  const SizedBox(width: 4),
                                  SizedBox(
                                    width: 48,
                                    child: Text(
                                      line.total.toStringAsFixed(0),
                                      style: GoogleFonts.inter(
                                        fontSize: 9,
                                        fontWeight: FontWeight.w600,
                                        color: AppTheme.navy,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                          const SizedBox(height: 8),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              '+ ADD TASK',
                              style: GoogleFonts.inter(
                                fontSize: 9.5,
                                fontWeight: FontWeight.w700,
                                color: AppTheme.teal,
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),
                          const Divider(
                              color: Color(0xFFB0B2AC), thickness: 1),
                          const SizedBox(height: 10),
                          Text(
                            'INVOICE',
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              color: AppTheme.navy,
                            ),
                          ),
                          const SizedBox(height: 7),
                          Container(
                            decoration: BoxDecoration(
                              color: AppTheme.navy.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'INVOICE NUMBER: ${invoice.invoiceNumber}',
                                  style: GoogleFonts.inter(
                                    fontSize: 9,
                                    fontWeight: FontWeight.w700,
                                    color: AppTheme.navy,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    AppPill(
                                      text: invoice.status.label,
                                      bgColor: invoice.status.bgColor,
                                      textColor: invoice.status.textColor,
                                    ),
                                    const SizedBox(width: 6),
                                    AppPill.lime(DateFormat('MMM dd, yyyy')
                                        .format(invoice.dueDate)),
                                    const Spacer(),
                                    AppPill(
                                      text:
                                          'TOTAL: ${invoice.total.toStringAsFixed(0)} EGP',
                                      bgColor: AppTheme.navy,
                                      fontSize: 8,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 160)),
            ],
          ),

          // Action buttons
          Positioned(
            bottom: 80,
            left: 14,
            right: 14,
            child: Row(
              children: [
                _ActionBtn(
                    label: 'SEND INVOICE',
                    icon: Icons.send_outlined,
                    onTap: () {}),
                const SizedBox(width: 8),
                _ActionBtn(
                    label: 'DOWNLOAD PDF',
                    icon: Icons.download_outlined,
                    onTap: () {}),
                const SizedBox(width: 8),
                _ActionBtn(
                  label: invoice.status == InvoiceStatus.unpaid
                      ? 'MARK PAID'
                      : 'MARK UNPAID',
                  icon: invoice.status == InvoiceStatus.unpaid
                      ? Icons.check_circle_outline
                      : Icons.cancel_outlined,
                  onTap: () {
                    context.read<AppState>().markInvoicePaid(invoice.id);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),

          // Back nav
          Positioned(
            bottom: 14,
            left: 14,
            right: 14,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(26),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.28),
                  borderRadius: BorderRadius.circular(26),
                  border: Border.all(color: Colors.white.withOpacity(0.55)),
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 9),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
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
            ),
          ),
        ],
      ),
    );
  }

  TextStyle _headerStyle() => GoogleFonts.inter(
        fontSize: 8.5,
        fontWeight: FontWeight.w700,
        color: AppTheme.textMuted,
      );
}

class _Cell extends StatelessWidget {
  final String text;
  final double? width;
  final bool centered;

  const _Cell({required this.text, this.width, this.centered = false});

  @override
  Widget build(BuildContext context) {
    final cell = Container(
      decoration: BoxDecoration(
        color: const Color(0xFFB8BAB4),
        borderRadius: BorderRadius.circular(6),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 9,
          fontWeight: FontWeight.w600,
          color: AppTheme.navy,
        ),
        textAlign: centered ? TextAlign.center : TextAlign.left,
        overflow: TextOverflow.ellipsis,
      ),
    );

    return width != null ? SizedBox(width: width, child: cell) : cell;
  }
}

class _ActionBtn extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _ActionBtn(
      {required this.label, required this.icon, required this.onTap});

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
