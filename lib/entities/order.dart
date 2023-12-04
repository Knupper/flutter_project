class Order {
  final int id;
  final DateTime orderDate;
  final List<int> items;

  Order({
    required this.id,
    required this.orderDate,
    required this.items,
  });
}
