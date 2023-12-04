import 'package:flutter/material.dart';
import 'package:flutter_project/entities/customer.dart';

class CustomerListItem extends StatelessWidget {
  const CustomerListItem({
    super.key,
    required this.customer,
  });

  final Customer customer;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      triggerMode: TooltipTriggerMode.longPress,
      message: 'Hier steht ein toller Tooltip',
      child: ListTile(
        leading: Icon(
          customer.isCompany ? Icons.food_bank_rounded : Icons.person,
        ),
        title: Text('${customer.lastName}, ${customer.firstName}'),
        subtitle: Text('Orders: ${customer.orderIds.length}'),
        onTap: () => debugPrint('navigate to detail'),
        onLongPress: () => debugPrint('show context menu'),
      ),
    );
  }
}
