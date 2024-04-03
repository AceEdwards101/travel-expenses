import 'package:flutter/foundation.dart' hide Category;
import 'package:flutter/material.dart';
import 'package:travel_expenses/models/expense.dart';
import 'dart:collection';

class ExpensesState extends ChangeNotifier 
{
   final List<Expense> _myExpenses = [
    Expense(
      title: 'Valentine Dinner',
      amount: 250,
      date: DateTime.now(),
      category: Category.food,
    ),
    Expense(
      title: 'Sky Diving',
      amount: 500.00,
      date: DateTime.now(),
      category: Category.experience,
    ),
  ];

  /// An unmodifiable view of the items in the cart.
  UnmodifiableListView<Expense> get expenses => UnmodifiableListView(_myExpenses);

  Expense getExpense(int index)
  {
    return _myExpenses[index];
  }

  List<Expense> getExpenseList()
  {
    return _myExpenses;
  }
  /// Adds [item] to cart. This and [removeAll] are the only ways to modify the
  /// cart from the outside.
  void add(Expense expense) {
    _myExpenses.add(expense);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  void remove(id){
    _myExpenses.removeWhere((item) => item.id == id);
    notifyListeners();
  }
}
