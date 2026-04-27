import 'dart:io';

import 'package:flutter/material.dart';

class BusinessClass {
  TextEditingController priceController =TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController titleController =TextEditingController();
  TextEditingController descController = TextEditingController();
  File? image;

BusinessClass({
  required this.priceController,
  required this.quantityController,
  required this.titleController,
  required this.descController,
  this.image,
});

}
