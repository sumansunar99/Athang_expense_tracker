import 'dart:convert';

import 'package:athang_expense_tracker/plugins/http.dart';

import 'account_model.dart';

class AccountRepo {
  Future loadAccounts() async{
    final res = await GetRequest('account');
    print(jsonDecode(res.body));
    List<AccountModel> tempAccounts = [];
    for(final acc in jsonDecode(res.body)['data']){
      tempAccounts.add(AccountModel.fromJson(acc));
    }
    return tempAccounts;
  }

  Future loadMyAccounts() async{
    final res = await GetRequest('account/me');
    print(jsonDecode(res.body));
    List<AccountModel> tempAccounts = [];
    for(final acc in jsonDecode(res.body)['data']){
      tempAccounts.add(AccountModel.fromJson(acc));
    }
    return tempAccounts;
  }
}