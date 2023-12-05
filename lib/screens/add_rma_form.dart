import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project/entities/rma.dart';
import 'package:flutter_project/util/translation_keys.dart';

class AddRmaForm extends StatefulWidget {
  const AddRmaForm({super.key});

  @override
  State<AddRmaForm> createState() => _AddRmaFormState();
}

class _AddRmaFormState extends State<AddRmaForm> {
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
              TextFormField(
                controller: _controllerOrderId,
                decoration: InputDecoration(
                  label: Text('lable_order'.tr()),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                validator: _idValidator,
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

    if (int.tryParse(value ?? '') == null) {
      return 'Please enter a valid number here 0-9!';
    }
    return null;
  }

  void _validateAndSaveForm() {
    final isFormValid = _formKey.currentState?.validate() == true;

    if (isFormValid) {
      final orderId = _controllerOrderId.text;
      final customerId = _controllerCustomerId.text;
      final description = _controllerDescription.text;

      int parsedOrderId = int.parse(orderId);
      int parsedCustomerId = int.parse(customerId);

      final createdRma = Rma(
        id: 1,
        customerId: parsedCustomerId,
        orderId: parsedOrderId,
        description: description,
        createdAt: DateTime.now().toUtc(),
        status: RmaStatus.created,
      );

      Navigator.pop<Rma>(context, createdRma);
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
