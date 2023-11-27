
import 'package:zeinab_ahmad_project/datetime/date_time_helper.dart';
import 'package:flutter/material.dart';
import '../models/expense_item.dart';

class ExpenseData extends ChangeNotifier {
  List<ExpenseItem> _expenses = [];

  // ... (existing code)

  // Add this method to calculate the total amount
  double calculateTotalAmount() {
    double total = 0.0;
    for (ExpenseItem expense in _expenses) {
      total += double.tryParse(expense.amount) ?? 0.0;
    }
    return total;
  }

  //list of all expense
List<ExpenseItem> overallExpenseList=[];
  //get expense list
List<ExpenseItem> getAllExpenseList() {
  return overallExpenseList;
}
  //add new expense
void addNewExpense(ExpenseItem newExpense){
  overallExpenseList.add(newExpense);
  notifyListeners();
}

  //delete expense

void deleteExpense(ExpenseItem expense){
  overallExpenseList.remove(expense);
  notifyListeners();
}

  //get weekend from dataTime object
String getDayName(DateTime dateTime){
  switch(dateTime.weekday){
    case 1:
      return 'Mon';
      case 2:
    return 'Tue';
    case 3:
      return 'Wed';
    case 4:
      return 'Thur';
    case 5:
      return 'Fri';
    case 6:
      return 'Sat';
    case 7:
      return 'Sun';
      return 'Sat';
    case 7:
      return 'Sun';
    default:
      return '';
  }
}
  //get data for the start of the week
DateTime startOfWeekDate(){
  DateTime?startOfWeek;
  //get todays date
  DateTime today=DateTime.now();
  //go backward from today to find sunday
  for(int i=0;i<7;i++){
    if(getDayName(today.subtract(Duration(days: i)))=='Sun'){
      startOfWeek=today.subtract(Duration(days:i));
    }
  }
  return startOfWeek!;
}
  /*convert overall list of expense into a daily expense summary
overallExpenseList=
[food,2023/01/30,$10],
DailyExpenseSummary=
[20230103,$21],
 */
Map<String,double> calculateDailyExpenseSummary(){
  Map<String,double> dailyExpenseSummary= {
    //date (yyyymmdd):amountTotalForDay
  };
  for(var expense in overallExpenseList){
    String date=convertDateTimeToString(expense.dateTime);
    double amount=double.parse(expense.amount);
    if(dailyExpenseSummary.containsKey(date)){
      double currentAmount=dailyExpenseSummary[date]!;
      currentAmount+=amount;
      dailyExpenseSummary[date]=currentAmount;
    }
    else{
      dailyExpenseSummary.addAll({date:amount});
    }
  }
return dailyExpenseSummary;
}
}