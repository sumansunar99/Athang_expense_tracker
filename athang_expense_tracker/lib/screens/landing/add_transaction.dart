import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: AddTransaction(),
    );
  }
}

class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    print('Building AddTransaction widget');
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Transaction'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Statement',
                hintText: 'Bike EMI Payment',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            GestureDetector(
              onTap: () async {
                print('Date picker tapped');
                FocusScope.of(context).requestFocus(FocusNode());
                final DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null && pickedDate != _selectedDate) {
                  setState(() {
                    print('Date selected: $pickedDate');
                    _selectedDate = pickedDate;
                  });
                }
              },
              child: AbsorbPointer(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Date',
                    hintText: _selectedDate != null
                        ? '${_selectedDate!.toLocal()}'.split(' ')[0]
                        : 'Select Date',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Account',
                border: OutlineInputBorder(),
              ),
              items: <String>['Account 1', 'Account 2', 'Account 3']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                print('Account selected: $newValue');
              },
            ),
            SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Expense',
                border: OutlineInputBorder(),
              ),
              items: <String>['Expense 1', 'Expense 2', 'Expense 3']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                print('Expense selected: $newValue');
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Amount in Rs.',
                hintText: '5,600',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Add image functionality
                print('Add Image button pressed');
              },
              child: Text('Add Image for the bill'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: const Color.fromARGB(255, 210, 206, 206),
              ),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                // Confirm button functionality
                print('Confirm button pressed');
              },
              child: Text('Confirm'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Color.fromARGB(255, 219, 215, 215),
                backgroundColor: Colors.orange,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
