import 'package:flutter/material.dart';

import 'package:wallet_app/models/expense.dart';
import 'package:wallet_app/widgets/expenses_list/expenses_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
  });

  final Function(Expense exp) onRemoveExpense;
  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Dismissible(
          key: ValueKey(expenses[index]),
          onDismissed: (direction) => onRemoveExpense(expenses[index]),
          background: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Theme.of(context).colorScheme.error.withOpacity(0.7),
            ),
            margin: EdgeInsets.symmetric(
                horizontal: Theme.of(context).cardTheme.margin!.horizontal),
          ),
          child: ExpensesItem(expense: expenses[index]),
        );
      },
      itemCount: expenses.length,
    );
  }
}
