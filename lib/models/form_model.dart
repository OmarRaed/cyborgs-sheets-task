import 'package:flutter/material.dart';

class FormModel {
  final String name;
  final String mobile;
  final int modelNumber;
  final String email;
  final String purchaseDate;

  FormModel({
    @required this.name,
    @required this.mobile,
    @required this.modelNumber,
    @required this.email,
    @required this.purchaseDate,
  });
}
