import 'package:flutter/material.dart';

enum CardType { masterCard, visa, rupay }

class CreditCard {
  final String cardNumber;
  final String cardHolderName;
  final String expireDate;
  final CardType cardType;
  final Color themeColor;
  CreditCard(
      {required this.cardHolderName,
      required this.cardNumber,
      required this.cardType,
      required this.expireDate,
      required this.themeColor});
}
