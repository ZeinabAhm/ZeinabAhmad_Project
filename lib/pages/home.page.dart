import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeinab_ahmad_project/components/expense_summar.dart';
import 'package:zeinab_ahmad_project/components/expense_tile.dart';
import 'package:zeinab_ahmad_project/data/expense_data.dart';
import 'package:zeinab_ahmad_project/models/expense_item.dart';
import 'package:zeinab_ahmad_project/More_Info_Page.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //text controllers
  final newExpenseNameController = TextEditingController();
  final newExpenseAmountController = TextEditingController();
  final newExpenseBudgetController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      // Show the budget-setting dialog when the app starts
      showBudgetDialog();
    });
  }

  void showBudgetDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dialog dismissal on outside tap
      builder: (context) =>
          AlertDialog(
            title: Text('Set Your Budget For Today'),
            content: TextField(
              controller: newExpenseBudgetController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Enter your budget",
              ),
            ),
            actions: [
              MaterialButton(
                onPressed: () {
                  // Save the budget and close the dialog
                  Navigator.pop(context);
                },
                child: Text('Save'),
              ),
            ],
          ),
    );
  }

  //add new expense
  void addNewExpense() {
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: Text(' Add new expense'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                //expense name
                TextField(
                  controller: newExpenseNameController,
                  decoration: const InputDecoration(
                    hintText: "Expense Name",
                  ),
                ),
                //expense amount
                TextField(
                  controller: newExpenseAmountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: "Dollor",
                  ),
                ),
              ], //children
            ),
            actions: [
              //save button
              MaterialButton(
                onPressed: save,
                child: Text('Save'),
              ),
              //cancel button
              MaterialButton(
                onPressed: cancel,
                child: Text('Cancel'),
              ),
            ],
          ),
    );
  }

  void save() {
    // Get the entered budget from the controller
    double budget = double.tryParse(newExpenseBudgetController.text) ?? 0.0;

    // Get the entered amount from the controller
    double expenseAmount = double.tryParse(newExpenseAmountController.text) ?? 0.0;

    // Create a copy of the current expenses
    List<ExpenseItem> currentExpenses = Provider.of<ExpenseData>(context, listen: false).getAllExpenseList();

    // Calculate the total amount of current expenses
    double totalExpenses = Provider.of<ExpenseData>(context, listen: false).calculateTotalAmount();

    // Calculate the total expense including the new one
    double totalWithNewExpense = totalExpenses + expenseAmount;

    // Check if the total expenses exceed the budget
    if (totalWithNewExpense >= budget) {
      // Show a warning message
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Oops, Budget Exceeded', style: TextStyle(color: Colors.red)),
          content: Text('The total expenses will exceed your budget with the new expense.', style: TextStyle(color: Colors.red)),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else {
      // Continue with saving the expense if it doesn't exceed the budget
      ExpenseItem newExpense = ExpenseItem(
        name: newExpenseNameController.text,
        amount: expenseAmount.toString(), // Fix: Use the parsed expenseAmount here
        dateTime: DateTime.now(),
      );

      // Add the new expense to the list
      //currentExpenses.add(newExpense);

      // Update the total amount with the new expense
      double updatedTotal = currentExpenses
          .map((expense) => double.tryParse(expense.amount) ?? 0.0)
          .fold(0, (previous, current) => previous + current);

      // Check if the updated total exceeds the budget
      if (updatedTotal >= budget) {
        // Show a warning message
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Oops, Budget Exceeded', style: TextStyle(color: Colors.red)),
            content: Text('The total expenses will exceed your budget with the new expense.', style: TextStyle(color: Colors.red)),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      } else {
        // Add new expense
        Provider.of<ExpenseData>(context, listen: false).addNewExpense(newExpense);

        // Close the dialog
        Navigator.pop(context);
        clear();
      }
    }
  }




  //cancel
  void cancel() {
    Navigator.pop(context);
    clear();
  }


// Finish button callback
  void finish() {
    // Get the list of expenses
    List<ExpenseItem> allExpenses = Provider.of<ExpenseData>(context, listen: false).getAllExpenseList();

    // Calculate the total amount of expenses
    double totalAmount = allExpenses
        .map((expense) => double.tryParse(expense.amount) ?? 0.0)
        .fold(0, (previous, current) => previous + current);

    // Show a dialog with the total amount
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Total Expenses'),
        content: Text('The total amount of your expenses is $totalAmount.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  //clear
  void clear() {
    newExpenseNameController.clear();
    newExpenseAmountController.clear();
  }

  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) =>
          Scaffold(
            backgroundColor: Colors.grey[300],
            floatingActionButton: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Add a "New Expense" button
                FloatingActionButton(
                  onPressed: addNewExpense,
                  backgroundColor: Colors.black,
                  child: const Icon(Icons.add),
                ),
                SizedBox(height: 16), // Adjust the spacing

                // Add a "Finish" button
                FloatingActionButton(
                  onPressed: finish,
                  backgroundColor: Colors.black,
                  child: const Icon(Icons.attach_money),
                ),
                SizedBox(height: 25),

                FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MoreInfoPage()),
                    );
                  },
                  backgroundColor: Colors.black,
                  child: const Icon(Icons.info),
                ),
                SizedBox(height: 16),

              ],
            ),
            body: ListView(
              children: [
                // Weekly summary
                ExpenseSummary(startOfWeek: value.startOfWeekDate()),
                const SizedBox(height: 20),

                // Expense list
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: value
                      .getAllExpenseList()
                      .length,
                  itemBuilder: (context, index) =>
                      ExpenseTile(
                        name: value.getAllExpenseList()[index].name,
                        amount: value.getAllExpenseList()[index].amount,
                        dateTime: value.getAllExpenseList()[index].dateTime,
                      ),
                ),
              ],
            ),
          ),
    );
  }
}