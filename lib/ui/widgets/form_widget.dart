import 'package:ctborgs_sheets_task/models/form_model.dart';
import 'package:flutter/material.dart';

class FormWidget extends StatelessWidget {
  final FormModel _formModel;
  final Function clearForm;
  FormWidget(this._formModel, this.clearForm);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_formModel.name, style: TextStyle(fontSize: 22)),
                Text('Mobile : ${_formModel.mobile}'),
                Text('Model Number : ${_formModel.modelNumber}'),
                Text('Email : ${_formModel.email}'),
                Text('Purchase Date : ${_formModel.purchaseDate}'),
              ],
            ),
            IconButton(icon: Icon(Icons.delete), onPressed: () => clearForm()),
          ],
        ),
      ),
    );
  }
}
