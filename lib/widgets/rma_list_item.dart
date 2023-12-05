import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/entities/rma.dart';
import 'package:intl/intl.dart';

class RmaListItem extends StatelessWidget {
  const RmaListItem({
    super.key,
    required this.rma,
  });

  final Rma rma;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      triggerMode: TooltipTriggerMode.longPress,
      message: 'A fantastic tooltip',
      waitDuration: const Duration(seconds: 1),
      child: ListTile(
        leading: Icon(
          rma.status.icon,
          color: rma.status.color,
        ),
        title: Text('${rma.customerId}, ${rma.orderId}'),
        subtitle: Text(rma.description),
        trailing: Text(DateFormat.yMMMMd(context.locale.languageCode).format(rma.createdAt)),
        onTap: () => debugPrint('navigate to detail'),
      ),
    );
  }
}
