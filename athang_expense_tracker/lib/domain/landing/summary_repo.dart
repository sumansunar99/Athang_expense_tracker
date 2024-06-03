import 'dart:convert';
import 'package:athang_expense_tracker/domain/landing/summary_model.dart';
import 'package:athang_expense_tracker/plugins/http.dart';

Future<SummaryModel> loadSummaryData() async{
  final res = await GetRequest('summary');
  print(jsonDecode(res.body));
  final temp = jsonDecode(res.body)['data'];
  return SummaryModel(
    expenses: temp['expenses'],
    income: temp['income'],
    openingBalance: temp['openingBalance'],
    maxExpense: temp['maxExpense'],
    totalTransactionsThisMonth: temp['totalTransactionsThisMonth'],
  );
}

// 1. load data in homescreen
// pass the data to components

// 2. load data in providers
// trigger load data function in homescreen
// display through components

// 3. load data in the respective components