import 'dart:convert';
import 'dart:ffi';

userModel userModelJson(String str) =>
    userModel.fromJson(json.decode(str));

class userModel {
  userModel({
    required this.status,
    required this.message,
    required this.data,
  });
  late final int status;
  late final String message;
  late final Data data;

  userModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
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
  late final List<dynamic> transactions;

  Data.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    cardnumber = json['number'];
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
