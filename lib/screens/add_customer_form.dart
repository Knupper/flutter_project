import 'package:flutter/material.dart';
import 'package:flutter_project/entities/customer.dart';

class AddCustomerForm extends StatefulWidget {
  const AddCustomerForm({super.key});

  @override
  State<AddCustomerForm> createState() => _AddCustomerFormState();
}

class _AddCustomerFormState extends State<AddCustomerForm> {
  final _formKey = GlobalKey<FormState>();
  final _controllerName = TextEditingController();
  final _controllerLastName = TextEditingController();
  final _controllerAddress = TextEditingController();

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
                controller: _controllerName,
                decoration: const InputDecoration(
                  label: Text('Vorname'),
                ),
                validator: (value) => value!.isEmpty ? 'REQUIRED' : null,
              ),
              TextFormField(
                controller: _controllerLastName,
                decoration: const InputDecoration(
                  label: Text('Nachname'),
                ),
                validator: (value) => value!.isEmpty ? 'REQUIRED' : null,
              ),
              TextFormField(
                controller: _controllerAddress,
                decoration: const InputDecoration(
                  label: Text('Adresse'),
                ),
              ),
              OutlinedButton(
                onPressed: _validateAndSaveForm,
                child: const Text('save customer'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _validateAndSaveForm() {
    final isFormValid = _formKey.currentState?.validate() == true;

    if (isFormValid) {
      final firstName = _controllerName.text;
      final lastName = _controllerLastName.text;
      final address = _controllerAddress.text;

      final createdCustomer = Customer(
        id: 1,
        firstName: firstName,
        lastName: lastName,
        address: address,
        orderIds: [],
      );

      Navigator.pop<Customer>(context, createdCustomer);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controllerAddress.dispose();
    _controllerLastName.dispose();
    _controllerName.dispose();
    _formKey.currentState?.dispose();
  }
}
