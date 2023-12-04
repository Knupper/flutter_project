class Customer {
  final int id;
  final bool isCompany;
  final String firstName;
  final String lastName;
  final String address;
  final List<int> orderIds;
  // TO be continued

  Customer({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.orderIds,
    this.isCompany = false,
  });
}
