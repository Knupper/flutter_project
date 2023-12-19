import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project/entities/rma.dart';
import 'package:flutter_project/util/translation_keys.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AddRmaForm extends StatefulWidget {
  const AddRmaForm({super.key});

  @override
  State<AddRmaForm> createState() => _AddRmaFormState();
}

class _AddRmaFormState extends State<AddRmaForm> {
  bool _checkBoxChecked = false;
  int _selectedDropdownItem = 2;

  final _formKey = GlobalKey<FormState>();
  final _controllerOrderId = TextEditingController();
  final _controllerCustomerId = TextEditingController();
  final _controllerDescription = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Customer'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Theme(
                data: ThemeData(
                  textTheme: TextTheme(
                    bodyLarge: TextStyle(fontSize: 10),
                  ),
                ),
                child: TextFormField(
                  controller: _controllerOrderId,
                  decoration: InputDecoration(
                    label: Text('lable_order'.tr()),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                  validator: _idValidator,
                ),
              ),
              TextFormField(
                controller: _controllerCustomerId,
                decoration: InputDecoration(
                  label: Text(TranslationKeys().lableCustomer),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                validator: _idValidator,
              ),
              TextFormField(
                controller: _controllerDescription,
                decoration: const InputDecoration(
                  label: Text('Description/Reason'),
                ),
              ),
              OutlinedButton(
                onPressed: _validateAndSaveForm,
                child: const Text('create rma'),
              ),
              Checkbox(
                value: _checkBoxChecked,
                onChanged: (value) => setState(() {
                  _checkBoxChecked = !_checkBoxChecked;
                }),
              ),
              DropdownButton(
                value: _selectedDropdownItem,
                items: List.generate(
                  10,
                  (index) => DropdownMenuItem(
                    value: index,
                    child: Text(
                      index.toString(),
                    ),
                  ),
                ),
                onChanged: (value) => setState(() {
                  _selectedDropdownItem = value ?? _selectedDropdownItem;
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? _idValidator(String? value) {
    if (value?.isEmpty ?? true) {
      return TranslationKeys.requiredError();
    }
    return null;
  }

  Future<void> _validateAndSaveForm() async {
    final isFormValid = _formKey.currentState?.validate() == true;

    if (isFormValid) {
      final orderId = _controllerOrderId.text;
      final customerId = _controllerCustomerId.text;
      final description = _controllerDescription.text;

      int parsedOrderId = orderId.parseToInt();
      int parsedCustomerId = customerId.parseToInt();

      final createdRma = Rma(
        id: 1,
        customerId: parsedCustomerId,
        orderId: parsedOrderId,
        description: description,
        createdAt: DateTime.now().toUtc(),
        status: RmaStatus.created,
      );

      const secureStorage = FlutterSecureStorage();

      // move to a bloc/cubit
      await secureStorage.write(
        key: parsedCustomerId.toString(),
        value: description,
      );

      if (context.mounted) {
        Navigator.pop<Rma>(context, createdRma);
      }

      secureStorage.readAll().then((elements) {
        debugPrint(jsonEncode(elements));

        Navigator.pop<Rma>(context, createdRma);
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controllerDescription.dispose();
    _controllerCustomerId.dispose();
    _controllerOrderId.dispose();
    _formKey.currentState?.dispose();
  }
}

extension TextThemeBold on TextTheme {
  TextStyle? get bodyLargeBold => bodyLarge?.copyWith(fontWeight: FontWeight.bold);
}

extension NumberParsing on String? {
  bool isParsable() {
    return int.tryParse(this ?? '') != null;
  }

  int parseToInt() {
    if (!isParsable()) {
      throw Exception('CAN NOT BE PARSED');
    }

    return int.parse(this!);
  }
}
