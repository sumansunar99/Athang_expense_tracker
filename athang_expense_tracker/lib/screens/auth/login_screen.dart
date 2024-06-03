import 'dart:convert';

import 'package:athang_expense_tracker/domain/auth/auth_model.dart';
import 'package:athang_expense_tracker/domain/auth/auth_repo.dart';
import 'package:athang_expense_tracker/plugins/http.dart';
import 'package:athang_expense_tracker/plugins/local_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../hoc/home_layout.dart';
import '../landing/home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
  FocusNode passwordFocusNode = FocusNode();
  bool loading = false;

  final _formKey = GlobalKey<FormState>();

  Future<void> loginUser() async {
    try {
     if(_formKey.currentState!.validate()){

       setState(() {
         loading = true;
       });
       final res = await AuthRepo().loginWithEmailAndPassword(
           AuthModel(username: _username.text, password: _password.text));

       Navigator.of(context)
           .pushReplacement(MaterialPageRoute(builder: (_) => HomeLayout()));
     }
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
    return Scaffold(
      // the keyboard will overlay on the screen
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formKey,
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        margin: EdgeInsets.only(bottom: 16),
                        child: Image.asset('assets/images/logo.png',
                            height: 100, fit: BoxFit.contain)),
                    TextFormField(
                      autofocus: true,
                      controller: _username,
                      onEditingComplete: () {
                        passwordFocusNode.requestFocus();
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), labelText: 'Email'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: TextFormField(
                        onEditingComplete: loginUser,
                        controller: _password,
                        // association of focus node with password
                        focusNode: passwordFocusNode,
                        autofocus: true,
                        obscureText: true,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Password"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        // null on pressed parameter will disable the button
                        onPressed: loading ? null : loginUser,
                        // onPressed: null,
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: Text('Login'),
                                margin: EdgeInsets.symmetric(horizontal: 12),
                              ),
                              if (loading)
                                Container(
                                  height:24,
                                  width: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 48,
                      margin: EdgeInsets.only(top: 8),
                      child: TextButton(
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            foregroundColor: Colors.redAccent),
                        onPressed: () {},
                        child: Text('Don\'t have an account? Sign up.'),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
