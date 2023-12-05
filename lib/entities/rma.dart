import 'package:flutter/material.dart';

class Rma {
  final int id;
  final int orderId;
  final int customerId;
  final String description;
  final RmaStatus status;
  final DateTime createdAt;

  Rma({
    required this.id,
    required this.orderId,
    required this.customerId,
    required this.description,
    required this.status,
    required this.createdAt,
  });
}

enum RmaStatus {
  created,
  inProcress,
  payed;

  IconData get icon => switch (this) {
        RmaStatus.created => Icons.sd_card_alert_rounded,
        RmaStatus.inProcress => Icons.work_rounded,
        RmaStatus.payed => Icons.payment,
      };

  Color get color => switch (this) {
        RmaStatus.created => Colors.blueGrey,
        RmaStatus.inProcress => Colors.yellowAccent,
        RmaStatus.payed => Colors.lightGreen,
      };
}
