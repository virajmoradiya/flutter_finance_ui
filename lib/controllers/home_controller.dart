import 'package:flutter/material.dart';
import 'package:flutter_finance_ui/models/debit_card.dart';
import 'package:flutter_finance_ui/models/transaction_model.dart';
import 'package:get/get.dart';

enum SelectedTab { send, receive, all }

class HomeController extends GetxController {
  SelectedTab selectedTab = SelectedTab.all;
  List<CreditCard> cards = [
    CreditCard(
        cardHolderName: "Viraj Moradiya",
        cardNumber: "**** **** **** 2111",
        cardType: CardType.masterCard,
        themeColor: const Color(0xFFE6F3E9),
        expireDate: "12/35"),
    CreditCard(
        cardHolderName: "Mihir Patel",
        cardNumber: "**** **** **** 8415",
        themeColor: const Color(0xFFFCDDCC),
        cardType: CardType.rupay,
        expireDate: "01/31"),
    CreditCard(
        cardHolderName: "Mayur Godhani",
        cardNumber: "**** **** **** 8520",
        themeColor: const Color(0xFFE6E5FF),
        cardType: CardType.visa,
        expireDate: "12/35"),
    CreditCard(
        cardHolderName: "Andrew Mike",
        cardNumber: "**** **** **** 7410",
        themeColor: Color(0xFFE6EAF3),
        cardType: CardType.masterCard,
        expireDate: "12/35")
  ];

  List<TransactionModel> transactions = [
    TransactionModel(transactionType: TransactionType.send, details: "Paid to Uber", amount: 199),
    TransactionModel(transactionType: TransactionType.receive, details: "Paid to Uber", amount: 199),
    TransactionModel(transactionType: TransactionType.send, details: "Paid to Uber", amount: 199),
    TransactionModel(transactionType: TransactionType.send, details: "Paid to Uber", amount: 199),
    TransactionModel(transactionType: TransactionType.receive, details: "Paid to Uber", amount: 199),
    TransactionModel(transactionType: TransactionType.send, details: "Paid to Uber", amount: 999),
    TransactionModel(transactionType: TransactionType.receive, details: "Paid to Uber", amount: 1000),
    TransactionModel(transactionType: TransactionType.receive, details: "Paid to Uber", amount: 199),
    TransactionModel(transactionType: TransactionType.send, details: "Paid to Uber", amount: 54),
    TransactionModel(transactionType: TransactionType.receive, details: "Paid to Uber", amount: 199),
    TransactionModel(transactionType: TransactionType.send, details: "Paid to Uber", amount: 154),
    TransactionModel(transactionType: TransactionType.send, details: "Paid to Uber", amount: 524),
    TransactionModel(transactionType: TransactionType.receive, details: "Paid to Uber", amount: 154),
  ];

  void changeTab(SelectedTab tabType) {
    selectedTab = tabType;
    update();
  }
}
