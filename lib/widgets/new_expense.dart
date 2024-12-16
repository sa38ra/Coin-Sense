import 'dart:developer';
import 'package:wallet_app/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});
  final void Function(Expense expense) onAddExpense;
  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  Category _selectedCategory = Category.work;
  DateTime? _selectedDate = DateTime.now();
  final formatter = DateFormat.yMd();

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _amountController.dispose();
  }

  String? _amountError;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              TextField(
                maxLength: 40,
                controller: _titleController,
                decoration: InputDecoration(
                  label: Text(
                    'Title',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                ),
                style:
                    TextStyle(color: Theme.of(context).colorScheme.secondary),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: _amountController,
                      decoration: InputDecoration(
                        label: Text(
                          'Amount',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary),
                        ),
                        prefixText: '\$',
                        fillColor: Theme.of(context).colorScheme.secondary,
                      ),
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          (_selectedDate == null)
                              ? 'no selected date'
                              : formatter.format(_selectedDate!),
                          style: TextStyle(
                            color: (_selectedDate == null)
                                ? Theme.of(context).colorScheme.error
                                : Theme.of(context).colorScheme.primary,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            final now = DateTime.now();
                            final DateTime? pickedDate = await showDatePicker(
                                context: context,
                                firstDate:
                                    DateTime(now.year, now.month - 1, now.day),
                                initialDate: now,
                                lastDate:
                                    DateTime(now.year, now.month, now.day + 5));
                            setState(() {
                              _selectedDate = pickedDate;
                            });
                          },
                          icon: const Icon(Icons.calendar_month),
                        )
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Category',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  DropdownButton(
                      value: _selectedCategory,
                      items: Category.values
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(
                                e.name.toUpperCase(),
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (newCat) {
                        if (newCat == null) return;
                        setState(() {
                          _selectedCategory = newCat;
                        });
                      }),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 204, 49, 38),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final enteredAmount =
                          double.tryParse(_amountController.text);
                      final isInvalideAmount =
                          enteredAmount == null || enteredAmount <= 0;
                      if (isInvalideAmount ||
                          _titleController.text.trim().isEmpty ||
                          _selectedDate == null) {
                        showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                                  title: const Text('Invalid input!!'),
                                  content: const Text(
                                      'please make sure that title, amount and date was entered correctly.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('okey'),
                                    ),
                                  ],
                                ));
                      } else {
                        widget.onAddExpense(
                          Expense(
                              title: _titleController.text,
                              amount: enteredAmount,
                              date: _selectedDate!,
                              category: _selectedCategory),
                        );
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Save Expense'),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
