/// error : false
/// message : "FAQ(s) Retrieved Successfully"
/// total : "1"
/// data : [{"id":"1","question":"How to user Doctor Plus App for booking?","answer":"Download and Install","status":"1"}]

class FaqModel {
  FaqModel({
      bool? error, 
      String? message, 
      String? total, 
      List<Data>? data,}){
    _error = error;
    _message = message;
    _total = total;
    _data = data;
}

  FaqModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    _total = json['total'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  String? _total;
  List<Data>? _data;
FaqModel copyWith({  bool? error,
  String? message,
  String? total,
  List<Data>? data,
}) => FaqModel(  error: error ?? _error,
  message: message ?? _message,
  total: total ?? _total,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  String? get total => _total;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['message'] = _message;
    map['total'] = _total;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "1"
/// question : "How to user Doctor Plus App for booking?"
/// answer : "Download and Install"
/// status : "1"

class Data {
  Data({
      String? id, 
      String? question, 
      String? answer, 
      String? status,}){
    _id = id;
    _question = question;
    _answer = answer;
    _status = status;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _question = json['question'];
    _answer = json['answer'];
    _status = json['status'];
  }
  String? _id;
  String? _question;
  String? _answer;
  String? _status;
Data copyWith({  String? id,
  String? question,
  String? answer,
  String? status,
}) => Data(  id: id ?? _id,
  question: question ?? _question,
  answer: answer ?? _answer,
  status: status ?? _status,
);
  String? get id => _id;
  String? get question => _question;
  String? get answer => _answer;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['question'] = _question;
    map['answer'] = _answer;
    map['status'] = _status;
    return map;
  }

}