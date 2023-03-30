import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;

  NewTransaction(this.addNewTransaction);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  void submitData() {
    if(_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addNewTransaction(
        _titleController.text, double.parse(_amountController.text),_selectedDate);

    Navigator.of(context).pop();
  }

  void datePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      print("$pickedDate,selectedDAtee");
      if (pickedDate == null) {
        return;
      }
      setState(() {
        print("setstate");
        _selectedDate = pickedDate;
      });
    });
  }

  // NewTransaction({required this.titleController,required this.amountController});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Container(
        padding: EdgeInsets.all(50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: "Title"),
              controller: _titleController,
              // onChanged: (val) {
              //   print(val);
              //   titleInput = val;
              // },
            ),
            TextField(
              decoration: InputDecoration(labelText: "Amount"),
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData,
              // onChanged: (val) => amountInput = val,
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Text(_selectedDate == null
                          ? "No Date Choosen"
                          : DateFormat.yMd().format(_selectedDate!))),
                  TextButton(
                      onPressed: datePicker,
                      child: Text(
                        'Choose Date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            ),
            TextButton(
              onPressed: submitData,
              child: Text(
                "Add Transaction",
              ),
              // style: ButtonStyle(foregroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor)),
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Theme.of(context).textTheme.headlineLarge?.color),
                  backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
