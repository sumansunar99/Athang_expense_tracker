import 'package:flutter/material.dart';

import '../../domain/account/account_model.dart';
import '../../domain/account/account_repo.dart';
import '../../widgets/common/DataLoading.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  List<AccountModel> accounts = [];
  bool loading = false;

  @override
  void initState() {
    loadAccounts();
  }

  Future<void> loadAccounts() async {
    try {
      setState(() {
        loading = true;
      });
      final res = await AccountRepo().loadAccounts();
      setState(() {
        accounts = res;
      });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: loading ? Dataloading() : ListView.builder(
          shrinkWrap: true,
          itemCount: accounts.length,
          itemBuilder: (context, int index) {
            return ListTile(
              contentPadding: EdgeInsets.all(4),
              titleTextStyle:
                  TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              subtitleTextStyle: TextStyle(fontSize: 20),
              leading: Container(
                height: 90,
                width: 90,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(accounts[index].img),
                  radius: 100,
                ),
              ),
              title: Text(accounts[index].title),
              subtitle: Text(accounts[index].openingBalance.toString()),
            );
          }),
    );
  }
}
