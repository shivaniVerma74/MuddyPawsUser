/// error : false
/// message : "Doctor Time Slot"
/// data : [{"time":"10:00 AM","status":false},{"time":"10:30 AM","status":false},{"time":"11:00 AM","status":false},{"time":"11:30 AM","status":false},{"time":"12:00 PM","status":false},{"time":"12:30 PM","status":false}]

class GetTimeSlot {
  GetTimeSlot({
      bool? error, 
      String? message, 
      List<Data>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  GetTimeSlot.fromJson(dynamic json) {
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
GetTimeSlot copyWith({  bool? error,
  String? message,
  List<Data>? data,
}) => GetTimeSlot(  error: error ?? _error,
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

/// time : "10:00 AM"
/// status : false

class Data {
  Data({
      String? time, 
      bool? status,}){
    _time = time;
    _status = status;
}

  Data.fromJson(dynamic json) {
    _time = json['time'];
    _status = json['status'];
  }
  String? _time;
  bool? _status;
Data copyWith({  String? time,
  bool? status,
}) => Data(  time: time ?? _time,
  status: status ?? _status,
);
  String? get time => _time;
  bool? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['time'] = _time;
    map['status'] = _status;
    return map;
  }
}