import 'package:flutter/cupertino.dart';

class Wallet {
  final String id;
  final String name;
  final String balance;
  final String accuntnumber; // if is false it is a credit card
  final String cardnumber;
  final String logo;

  const Wallet({
    this.id,
    this.name,
    this.balance,
    this.cardnumber,
    this.accuntnumber,
    this.logo,
  });
}

List<Wallet> wallets_list = [
  Wallet(name: "حساب بانکی انصار", balance: "250,000", logo: bank_list[0].imageLink),
  Wallet(name: "کارت بانک اقتصاد", balance: "3,500,000", logo: bank_list[1].imageLink),
  Wallet(name: "بانک کار افرین", balance: "20,000,000", logo: bank_list[2].imageLink),
  Wallet(name: "حساب بانکی کشاورزی", balance: "1,100", logo: bank_list[3].imageLink),
  Wallet(name: "کارت بانکی مسکن", balance: "123,458,900", logo: bank_list[4].imageLink),
];

class BankList {
  final int id;
  final String name;
  final String imageLink;
  BankList({this.id, this.name, this.imageLink});
}

List<BankList> bank_list = [
  BankList(id: 1, name: "انصار", imageLink: "assets/imgs/Banks/ansar.png"),
  BankList(id: 2, name: "اقتصاد", imageLink: "assets/imgs/Banks/egtesad.png"),
  BankList(
      id: 3, name: "کارآفرین", imageLink: "assets/imgs/Banks/karafarin.png"),
  BankList(
      id: 4, name: "کشاورزی", imageLink: "assets/imgs/Banks/keshavarzi.png"),
  BankList(id: 5, name: "مسکن", imageLink: "assets/imgs/Banks/maskan.png"),
  BankList(id: 6, name: "ملت", imageLink: "assets/imgs/Banks/mellat.png"),
  BankList(id: 7, name: "ملی", imageLink: "assets/imgs/Banks/melli.png"),
  BankList(id: 8, name: "پارسیان", imageLink: "aassets/imgs/Banks/pars.png"),
  BankList(
      id: 9, name: "پاسارگارد", imageLink: "assets/imgs/Banks/parsargard.png"),
  BankList(id: 10, name: "صادرات", imageLink: "assets/imgs/Banks/saderat.png"),
  BankList(id: 11, name: "سامان", imageLink: "assets/imgs/Banks/saman.png"),
  BankList(
      id: 12, name: "صنعت و معدن", imageLink: "assets/imgs/Banks/sanat.png"),
  BankList(
      id: 13, name: "سرمایه", imageLink: "aassets/imgs/Banks/sarmayeh.png"),
  BankList(id: 14, name: "سپه", imageLink: "assets/imgs/Banks/sepah.png"),
  BankList(id: 15, name: "سینا", imageLink: "assets/imgs/Banks/sina.png"),
  BankList(id: 16, name: "تجارت", imageLink: "assets/imgs/Banks/tejarat.png"),
];

class Transaction {
  final String id;
  final String name;
  final DateTime date;
  final double transaction_value;
  final bool
      transaction_type; // //ture for Increase inventory and false for Reduce inventory
  final String transaction_discreption;
  final int wallet_id;

  const Transaction({
    this.id,
    this.name,
    this.transaction_discreption,
    this.transaction_type,
    this.transaction_value,
    this.wallet_id,
    this.date,
  });
}
