import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_expenses/models/expense.dart';
import 'package:travel_expenses/widgets/expenses_list/expense_item.dart';
import 'package:travel_expenses/widgets/state.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key, required this.onRemoveExpense});


  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(context) {
    return Consumer<ExpensesState>(
      builder: (context,state, child){
      return ListView.builder(
        itemCount: state.getExpenseList().length,
        itemBuilder: (listContext, index) => Dismissible(
          onDismissed: (direction) {
            onRemoveExpense(state.getExpense(index),);
            print(direction); //tried to see what gets printed when we swipe left and right, may be you could use this to have background colours?
          },
          key: ValueKey(state.getExpense(index)),
          background: Container(
            color: Theme.of(context).colorScheme.error.withOpacity(0.75),
            margin: EdgeInsets.symmetric(
              horizontal: Theme.of(context).cardTheme.margin!.horizontal,
            ),
          ),
          child: ExpenseItem(state.getExpense(index)),
          ) 
        
      );
  });
  }
}
