/// response_code : "1"
/// msg : "wallet transactions success"
/// data : [{"id":"1","user_id":"731","type":"credit","amount":"500","message":"Add Wallet","status":"0","date_created":"2023-09-22 16:13:53","last_updated":"0000-00-00 00:00:00","username":"fgdfgdfg"},{"id":"2","user_id":"731","type":"credit","amount":"500","message":"Add Wallet","status":"0","date_created":"2023-09-22 16:14:13","last_updated":"0000-00-00 00:00:00","username":"fgdfgdfg"},{"id":"3","user_id":"731","type":"credit","amount":"500","message":"Add Wallet","status":"0","date_created":"2023-09-22 16:14:30","last_updated":"0000-00-00 00:00:00","username":"fgdfgdfg"},{"id":"4","user_id":"731","type":"credit","amount":"500","message":"Add Wallet","status":"0","date_created":"2023-09-22 16:15:36","last_updated":"0000-00-00 00:00:00","username":"fgdfgdfg"},{"id":"5","user_id":"731","type":"credit","amount":"100","message":"Add Wallet","status":"0","date_created":"2023-09-22 16:16:55","last_updated":"0000-00-00 00:00:00","username":"fgdfgdfg"},{"id":"6","user_id":"731","type":"credit","amount":"0","message":"Add Wallet","status":"0","date_created":"2023-09-22 16:33:53","last_updated":"0000-00-00 00:00:00","username":"fgdfgdfg"},{"id":"7","user_id":"731","type":"credit","amount":"200","message":"Add Wallet","status":"0","date_created":"2023-09-22 16:36:11","last_updated":"0000-00-00 00:00:00","username":"fgdfgdfg"},{"id":"8","user_id":"731","type":"credit","amount":"100","message":"Add Wallet","status":"0","date_created":"2023-09-22 16:38:42","last_updated":"0000-00-00 00:00:00","username":"fgdfgdfg"},{"id":"9","user_id":"731","type":"credit","amount":"0","message":"Add Wallet","status":"0","date_created":"2023-09-22 16:50:51","last_updated":"0000-00-00 00:00:00","username":"fgdfgdfg"},{"id":"10","user_id":"731","type":"credit","amount":"0","message":"Add Wallet","status":"0","date_created":"2023-09-22 17:05:57","last_updated":"0000-00-00 00:00:00","username":"fgdfgdfg"},{"id":"11","user_id":"731","type":"credit","amount":"0","message":"Add Wallet","status":"0","date_created":"2023-09-22 17:07:04","last_updated":"0000-00-00 00:00:00","username":"fgdfgdfg"},{"id":"12","user_id":"731","type":"credit","amount":"0","message":"Add Wallet","status":"0","date_created":"2023-09-22 17:08:31","last_updated":"0000-00-00 00:00:00","username":"fgdfgdfg"},{"id":"13","user_id":"731","type":"credit","amount":"0","message":"Add Wallet","status":"0","date_created":"2023-09-22 17:09:36","last_updated":"0000-00-00 00:00:00","username":"fgdfgdfg"},{"id":"14","user_id":"731","type":"credit","amount":"0","message":"Add Wallet","status":"0","date_created":"2023-09-22 17:10:12","last_updated":"0000-00-00 00:00:00","username":"fgdfgdfg"},{"id":"15","user_id":"731","type":"credit","amount":"100","message":"Add Wallet","status":"0","date_created":"2023-09-22 17:36:47","last_updated":"0000-00-00 00:00:00","username":"fgdfgdfg"},{"id":"16","user_id":"731","type":"credit","amount":"100","message":"Add Wallet","status":"0","date_created":"2023-09-22 17:38:41","last_updated":"0000-00-00 00:00:00","username":"fgdfgdfg"}]

class TransactionModel {
  TransactionModel({
      String? responseCode, 
      String? msg, 
      List<Data>? data,}){
    _responseCode = responseCode;
    _msg = msg;
    _data = data;
}

  TransactionModel.fromJson(dynamic json) {
    _responseCode = json['response_code'];
    _msg = json['msg'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  String? _responseCode;
  String? _msg;
  List<Data>? _data;
TransactionModel copyWith({  String? responseCode,
  String? msg,
  List<Data>? data,
}) => TransactionModel(  responseCode: responseCode ?? _responseCode,
  msg: msg ?? _msg,
  data: data ?? _data,
);
  String? get responseCode => _responseCode;
  String? get msg => _msg;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['response_code'] = _responseCode;
    map['msg'] = _msg;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "1"
/// user_id : "731"
/// type : "credit"
/// amount : "500"
/// message : "Add Wallet"
/// status : "0"
/// date_created : "2023-09-22 16:13:53"
/// last_updated : "0000-00-00 00:00:00"
/// username : "fgdfgdfg"

class Data {
  Data({
      String? id, 
      String? userId, 
      String? type, 
      String? amount, 
      String? message, 
      String? status, 
      String? dateCreated, 
      String? lastUpdated, 
      String? username,}){
    _id = id;
    _userId = userId;
    _type = type;
    _amount = amount;
    _message = message;
    _status = status;
    _dateCreated = dateCreated;
    _lastUpdated = lastUpdated;
    _username = username;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _type = json['type'];
    _amount = json['amount'];
    _message = json['message'];
    _status = json['status'];
    _dateCreated = json['date_created'];
    _lastUpdated = json['last_updated'];
    _username = json['username'];
  }
  String? _id;
  String? _userId;
  String? _type;
  String? _amount;
  String? _message;
  String? _status;
  String? _dateCreated;
  String? _lastUpdated;
  String? _username;
Data copyWith({  String? id,
  String? userId,
  String? type,
  String? amount,
  String? message,
  String? status,
  String? dateCreated,
  String? lastUpdated,
  String? username,
}) => Data(  id: id ?? _id,
  userId: userId ?? _userId,
  type: type ?? _type,
  amount: amount ?? _amount,
  message: message ?? _message,
  status: status ?? _status,
  dateCreated: dateCreated ?? _dateCreated,
  lastUpdated: lastUpdated ?? _lastUpdated,
  username: username ?? _username,
);
  String? get id => _id;
  String? get userId => _userId;
  String? get type => _type;
  String? get amount => _amount;
  String? get message => _message;
  String? get status => _status;
  String? get dateCreated => _dateCreated;
  String? get lastUpdated => _lastUpdated;
  String? get username => _username;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['type'] = _type;
    map['amount'] = _amount;
    map['message'] = _message;
    map['status'] = _status;
    map['date_created'] = _dateCreated;
    map['last_updated'] = _lastUpdated;
    map['username'] = _username;
    return map;
  }

}