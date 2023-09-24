enum TransactionType { send, receive }

class TransactionModel {
  final String details;
  final TransactionType transactionType;
  final int amount;

  TransactionModel({required this.transactionType, required this.details, required this.amount});
}
