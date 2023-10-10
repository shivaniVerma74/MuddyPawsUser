/// error : false
/// message : "Community Get Successfully"
/// data : {"id":"26","variable":"community","value":"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged."}

class GetCommunity {
  GetCommunity({
      bool? error, 
      String? message, 
      Data? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  GetCommunity.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _error;
  String? _message;
  Data? _data;
GetCommunity copyWith({  bool? error,
  String? message,
  Data? data,
}) => GetCommunity(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// id : "26"
/// variable : "community"
/// value : "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged."

class Data {
  Data({
      String? id, 
      String? variable, 
      String? value,}){
    _id = id;
    _variable = variable;
    _value = value;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _variable = json['variable'];
    _value = json['value'];
  }
  String? _id;
  String? _variable;
  String? _value;
Data copyWith({  String? id,
  String? variable,
  String? value,
}) => Data(  id: id ?? _id,
  variable: variable ?? _variable,
  value: value ?? _value,
);
  String? get id => _id;
  String? get variable => _variable;
  String? get value => _value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['variable'] = _variable;
    map['value'] = _value;
    return map;
  }

}