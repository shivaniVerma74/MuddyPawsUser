/// error : false
/// message : "Plans"
/// data : [{"id":"1","name":"14 Visits Subscription","description":"14 Visits Subscription","amount":"1000.00","time":"14","type":"1","plan_type":"1","is_plan":"2","created_at":"2023-08-31 10:27:52","update_at":"2023-05-19 13:02:41"}]

class GetPlansModel {
  GetPlansModel({
      bool? error, 
      String? message, 
      List<Data>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  GetPlansModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  List<Data>? _data;
GetPlansModel copyWith({  bool? error,
  String? message,
  List<Data>? data,
}) => GetPlansModel(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "1"
/// name : "14 Visits Subscription"
/// description : "14 Visits Subscription"
/// amount : "1000.00"
/// time : "14"
/// type : "1"
/// plan_type : "1"
/// is_plan : "2"
/// created_at : "2023-08-31 10:27:52"
/// update_at : "2023-05-19 13:02:41"

class Data {
  Data({
      String? id, 
      String? name, 
      String? description, 
      String? amount, 
      String? time, 
      String? type, 
      String? planType, 
      String? isPlan, 
      String? createdAt, 
      String? updateAt,}){
    _id = id;
    _name = name;
    _description = description;
    _amount = amount;
    _time = time;
    _type = type;
    _planType = planType;
    _isPlan = isPlan;
    _createdAt = createdAt;
    _updateAt = updateAt;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _description = json['description'];
    _amount = json['amount'];
    _time = json['time'];
    _type = json['type'];
    _planType = json['plan_type'];
    _isPlan = json['is_plan'];
    _createdAt = json['created_at'];
    _updateAt = json['update_at'];
  }
  String? _id;
  String? _name;
  String? _description;
  String? _amount;
  String? _time;
  String? _type;
  String? _planType;
  String? _isPlan;
  String? _createdAt;
  String? _updateAt;
Data copyWith({  String? id,
  String? name,
  String? description,
  String? amount,
  String? time,
  String? type,
  String? planType,
  String? isPlan,
  String? createdAt,
  String? updateAt,
}) => Data(  id: id ?? _id,
  name: name ?? _name,
  description: description ?? _description,
  amount: amount ?? _amount,
  time: time ?? _time,
  type: type ?? _type,
  planType: planType ?? _planType,
  isPlan: isPlan ?? _isPlan,
  createdAt: createdAt ?? _createdAt,
  updateAt: updateAt ?? _updateAt,
);
  String? get id => _id;
  String? get name => _name;
  String? get description => _description;
  String? get amount => _amount;
  String? get time => _time;
  String? get type => _type;
  String? get planType => _planType;
  String? get isPlan => _isPlan;
  String? get createdAt => _createdAt;
  String? get updateAt => _updateAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['description'] = _description;
    map['amount'] = _amount;
    map['time'] = _time;
    map['type'] = _type;
    map['plan_type'] = _planType;
    map['is_plan'] = _isPlan;
    map['created_at'] = _createdAt;
    map['update_at'] = _updateAt;
    return map;
  }

}