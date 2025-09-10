class Transaction {
  final String date;
  final String description;
  final String amount;
  final String type;

  Transaction({
    required this.date,
    required this.description,
    required this.amount,
    required this.type,
  });

  bool get isCredit => type == 'credit';
}
