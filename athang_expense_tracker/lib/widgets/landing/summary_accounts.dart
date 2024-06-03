import 'package:athang_expense_tracker/base/style/text_styles.dart';
import 'package:athang_expense_tracker/domain/account/account_repo.dart';
import 'package:flutter/material.dart';

import '../../domain/account/account_model.dart';
import '../../screens/common/account_card.dart';

class SummaryAccounts extends StatefulWidget {
  const SummaryAccounts({super.key});

  @override
  State<SummaryAccounts> createState() => _SummaryAccountsState();
}

class _SummaryAccountsState extends State<SummaryAccounts> {
  List<AccountModel> accounts = [];

  @override
  void initState(){
      loadData();
  }

  Future loadData() async {
    final res = await AccountRepo().loadMyAccounts();
    setState(() {
      accounts = res;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      margin: EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Current balances',
              style: TypoStyles().kSectionHeader,
            ),
          ),
          Container(
            height: 200,
            margin: EdgeInsets.only(bottom: 8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: accounts.map((val)=> AccountCard(val),
                 ).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
