import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class Expense {
  static const uuid = Uuid();
  final dateFormat = DateFormat.yMd();

  String get formattedDate {
    return dateFormat.format(date);
  }

  static const categoryIcons = {
    Category.food: Icons.lunch_dining,
    Category.leisure: Icons.movie,
    Category.travel: Icons.directions_car_sharp,
    Category.work: Icons.work,
  };
  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4();
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;
}

class ExpenseBucket {
  ExpenseBucket({required this.category, required this.expenses});
  ExpenseBucket.forCategory(
      {required this.category, required List<Expense> allExpenses})
      : expenses = allExpenses.where((e) => e.category == category).toList();
  final Category category;
  final List<Expense> expenses;
  double get totalExpenses {
    double sum = 0;
    for (var ex in expenses) {
      sum += ex.amount;
    }
    return sum;
  }
}

enum Category { food, travel, leisure, work }
