import 'dart:convert';

LoginResponseModel loginResponseJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

class LoginResponseModel {
  LoginResponseModel({
    required this.message,
    required this.data,
  });
  late final String message;
  late final Data data;

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.username,
    required this.cardnumber,
    required this.expiry,
    required this.transactions,
    required this.amount,
  });

  late final String username;
  late final String cardnumber;
  late final String expiry;
  late final String amount;
  late final String transactions;

  Data.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    cardnumber = json['cardnumber'];
    expiry = json['expiry'];
    amount = json['amount'];
    transactions = json['transactions'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['username'] = username;
    _data['cardnumber'] = cardnumber;
    _data['expiry'] = expiry;
    _data['amount'] = amount;
    _data['transactions'] = transactions;
    return _data;
  }
}
