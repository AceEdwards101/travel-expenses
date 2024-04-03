import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_expenses/widgets/expense_chart.dart';
import 'package:travel_expenses/widgets/expenses_list/expense_list.dart';
import 'package:travel_expenses/models/expense.dart';
import 'package:travel_expenses/widgets/new_expense.dart';
import 'package:travel_expenses/widgets/state.dart';



class Expenses extends StatefulWidget {
  const Expenses();

  @override
  State<Expenses> createState() {
    return _Expenses();
  }
}

class _Expenses extends State<Expenses> {
  // final List<Expense> _myExpenses = [
  //   Expense(
  //     title: 'Valentine Dinner',
  //     amount: 250,
  //     date: DateTime.now(),
  //     category: Category.food,
  //   ),
  //   Expense(
  //     title: 'Sky Diving',
  //     amount: 500.00,
  //     date: DateTime.now(),
  //     category: Category.experience,
  //   ),
  // ];

  void _openAddExpenseItemOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (modalContext) => const NewExpense(),
      backgroundColor: Theme.of(context).dialogTheme.backgroundColor,
    );
  }

 

 

  @override
  Widget build(context) {
    var state= Provider.of<ExpensesState>(context);
    Widget mainScreenContent = const Center(
      child: Text(' No Expenses here.. Please add some'),
    );
     
    void _removeExpense(Expense expense) {
      // final expenseIndex = _myExpenses.indexOf(expense);
        state.remove(expense.id);
      
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Expense Deleted'),
        duration: const Duration(seconds: 4),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
                state.add(expense);
            }),
      ));
    }

  return Consumer<ExpensesState>(
      builder: (context,state, child){

    if (state.getExpenseList().isNotEmpty) {
      mainScreenContent = ExpensesList(
        onRemoveExpense: _removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Travel Expenses Tracker"),
        actions: [
          IconButton(
            onPressed: _openAddExpenseItemOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Chart(expenses: state.getExpenseList()),
          Expanded(child: mainScreenContent)
        ],
      ),
    );
    });
  }
}
