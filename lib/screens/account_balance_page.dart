import 'package:flutter/material.dart';

import '../widgets/hoverable_card.dart';
import '../widgets/watermark_background.dart';

class AccountBalancePage extends StatelessWidget {
  const AccountBalancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Balance', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF1B5E20),
      ),
      body: WatermarkBackground(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            HoverableCard(
              padding: EdgeInsets.zero,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.green.shade600,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: const [
                    Text(
                      'Total Remaining Balance',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFFB9F6CA),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      '₱ 0.00',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Status: Fully Paid (Free Higher Education Act)',
                      style: TextStyle(
                        color: Color(0xFFB9F6CA),
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              'Tuition & Fee Breakdown',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),

            HoverableCard(
              child: Column(
                children: const [
                  _BalanceRow(label: 'Tuition Fee (18 Units)', amount: '₱ 9,000.00'),
                  SizedBox(height: 10),
                  _BalanceRow(label: 'Laboratory Fees', amount: '₱ 2,500.00'),
                  SizedBox(height: 10),
                  _BalanceRow(label: 'Miscellaneous Fees', amount: '₱ 3,800.00'),
                  Divider(height: 24),
                  _BalanceRow(
                    label: 'Subtotal Assessment',
                    amount: '₱ 15,300.00',
                    isBold: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              'Payment / Subsidy Applied',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),

            HoverableCard(
              child: Row(
                children: [
                  const Icon(
                    Icons.check_circle,
                    color: Color(0xFF2E7D32),
                    size: 28,
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'CHED UNIFAST Subsidy / Grant',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Applied upon enrollment',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Text(
                    '- ₱ 15,300.00',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E7D32),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BalanceRow extends StatelessWidget {
  final String label;
  final String amount;
  final bool isBold;

  const _BalanceRow({
    required this.label,
    required this.amount,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontSize: 14,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      color: Colors.black,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: style),
        Text(amount, style: style),
      ],
    );
  }
}