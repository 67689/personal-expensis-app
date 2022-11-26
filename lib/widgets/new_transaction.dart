import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// ignore: implementation_imports, unused_import
import 'package:flutter/src/foundation/key.dart';
// ignore: implementation_imports, unnecessary_import
import 'package:flutter/src/widgets/framework.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enterAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enterAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTx(
      enteredTitle,
      enterAmount,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
    // ignore: avoid_print
    print('...');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                // ignore: prefer_const_constructors
                decoration: InputDecoration(labelText: 'Title'),
                controller: _titleController,
                onSubmitted: (_) => _submitData(),
                // onChanged: (val) {
                //   titleInput = val;
                // },
              ),
              TextField(
                // ignore: prefer_const_constructors
                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
                // onChanged: (val) => amountInput = val,
              ),
              // ignore: sized_box_for_whitespace
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'No Date Chosen'
                            : 'Picked Date: ${DateFormat.yMd().format(_selectedDate as DateTime)}',
                      ),
                    ),
                    TextButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                      ),
                      onPressed: _presentDatePicker,
                      // ignore: prefer_const_constructors
                      child: Text('Chosen Date'),
                    ),

                    // FlatButton(
                    //   textColor: Theme.of(context).primaryColor,
                    //   onPressed: _presentDatePicker,
                    //   child: Text(
                    //     'Chosen Date',
                    //     style: TextStyle(
                    //       fontWeight: FontWeight.bold,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
              ElevatedButton(
                // ignore: prefer_const_constructors, sort_child_properties_last
                child: Text('Add Transaction'),
                style: ElevatedButton.styleFrom(
                  // ignore: deprecated_member_use
                  primary: Colors.green,
                ),
                onPressed: _submitData,
              ),
              // RaisedButton(
              //   child: Text('Add Transaction'),
              //   color: Theme.of(context).primaryColor,
              //   textColor: Colors.white,
              //   onPressed: _submitData,
              // )
            ],
          ),
        ),
      ),
    );
  }
}
