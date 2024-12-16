import 'package:wallet_app/chart/chart_bar.dart';
import 'package:flutter/material.dart';
import '../models/expense.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.expenses});
  final List<Expense> expenses;
  List<ExpenseBucket> get buckets {
    return [
      ExpenseBucket.forCategory(category: Category.food, allExpenses: expenses),
      ExpenseBucket.forCategory(
          category: Category.leisure, allExpenses: expenses),
      ExpenseBucket.forCategory(
          category: Category.travel, allExpenses: expenses),
      ExpenseBucket.forCategory(category: Category.work, allExpenses: expenses),
    ];
  }

  double get maxTotalExpenses {
    double max = 0;
    for (var e in buckets) {
      if (e.totalExpenses > max) {
        max = e.totalExpenses;
      }
    }
    return max;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      width: double.infinity,
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.3),
            Theme.of(context).colorScheme.primary.withOpacity(0.0),
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final e in buckets)
                  ChartBar(
                    fill: (e.totalExpenses == 0)
                        ? 0
                        : e.totalExpenses / maxTotalExpenses,
                  ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: buckets
                .map(
                  (e) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(
                        Expense.categoryIcons[e.category],
                        color: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.7),
                      ),
                    ),
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}
