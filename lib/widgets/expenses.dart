import 'package:wallet_app/chart/chart.dart';
import 'package:wallet_app/models/expense.dart';
import 'package:wallet_app/widgets/expenses_list/expenses_list.dart';
import 'package:wallet_app/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        category: Category.work,
        title: 'Fultter Course',
        amount: 90.9,
        date: DateTime.now()),
    Expense(
        category: Category.food,
        title: 'Breakfast',
        amount: 15.7,
        date: DateTime.now()),
    Expense(
        category: Category.leisure,
        title: 'Cenima',
        amount: 30,
        date: DateTime.now()),
    Expense(
        category: Category.work,
        title: 'Fultter Course',
        amount: 90.9,
        date: DateTime.now()),
    Expense(
        category: Category.food,
        title: 'Breakfast',
        amount: 15.7,
        date: DateTime.now()),
    Expense(
        category: Category.leisure,
        title: 'Cenima',
        amount: 30,
        date: DateTime.now()),
  ];

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    setState(() {
      _registeredExpenses.remove(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Coin Sense"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (ctx) {
                      return NewExpense(
                        onAddExpense: _addExpense,
                      );
                    });
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Center(
        child: width < 500
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Chart(expenses: _registeredExpenses),
                  Expanded(
                    child: ExpensesList(
                      expenses: _registeredExpenses,
                      onRemoveExpense: _removeExpense,
                    ),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Chart(expenses: _registeredExpenses),
                  ),
                  Expanded(
                    child: ExpensesList(
                      expenses: _registeredExpenses,
                      onRemoveExpense: _removeExpense,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
