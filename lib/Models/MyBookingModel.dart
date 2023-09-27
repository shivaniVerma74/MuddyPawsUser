/// error : false
/// message : "Booking retrieved successfully"
/// data : [{"id":"108","user_id":"731","doctor_id":"729","pet_id":"8","description":"This is a test description","day":"","date":"2023-09-21","status":"0","created_at":"2023-09-22 13:00:12","updated_at":"2023-09-22 13:00:12","time_slot":"10:00:00","report":"","image":"","transaction_id":"TXN1235455555","payment_type":"online","doctor_name":"Dikshaya Pandey","pet_type":"Dog","pet_name":"Kitty"},{"id":"107","user_id":"731","doctor_id":"729","pet_id":"8","description":"This is a test description","day":"","date":"2023-09-21","status":"0","created_at":"2023-09-22 12:51:19","updated_at":"2023-09-22 12:51:19","time_slot":"10:00:00","report":"","image":"","transaction_id":"TXN1235455555","payment_type":"online","doctor_name":"Dikshaya Pandey","pet_type":"Dog","pet_name":"Kitty"}]

class MyBookingModel {
  MyBookingModel({
      bool? error, 
      String? message, 
      List<Data>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  MyBookingModel.fromJson(dynamic json) {
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
MyBookingModel copyWith({  bool? error,
  String? message,
  List<Data>? data,
}) => MyBookingModel(  error: error ?? _error,
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

/// id : "108"
/// user_id : "731"
/// doctor_id : "729"
/// pet_id : "8"
/// description : "This is a test description"
/// day : ""
/// date : "2023-09-21"
/// status : "0"
/// created_at : "2023-09-22 13:00:12"
/// updated_at : "2023-09-22 13:00:12"
/// time_slot : "10:00:00"
/// report : ""
/// image : ""
/// transaction_id : "TXN1235455555"
/// payment_type : "online"
/// doctor_name : "Dikshaya Pandey"
/// pet_type : "Dog"
/// pet_name : "Kitty"

class Data {
  Data({
      String? id, 
      String? userId, 
      String? doctorId, 
      String? petId, 
      String? description, 
      String? day, 
      String? date, 
      String? status, 
      String? createdAt, 
      String? updatedAt, 
      String? timeSlot, 
      String? report, 
      String? image, 
      String? transactionId, 
      String? paymentType, 
      String? doctorName, 
      String? petType, 
      String? petName,}){
    _id = id;
    _userId = userId;
    _doctorId = doctorId;
    _petId = petId;
    _description = description;
    _day = day;
    _date = date;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _timeSlot = timeSlot;
    _report = report;
    _image = image;
    _transactionId = transactionId;
    _paymentType = paymentType;
    _doctorName = doctorName;
    _petType = petType;
    _petName = petName;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _doctorId = json['doctor_id'];
    _petId = json['pet_id'];
    _description = json['description'];
    _day = json['day'];
    _date = json['date'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _timeSlot = json['time_slot'];
    _report = json['report'];
    _image = json['image'];
    _transactionId = json['transaction_id'];
    _paymentType = json['payment_type'];
    _doctorName = json['doctor_name'];
    _petType = json['pet_type'];
    _petName = json['pet_name'];
  }
  String? _id;
  String? _userId;
  String? _doctorId;
  String? _petId;
  String? _description;
  String? _day;
  String? _date;
  String? _status;
  String? _createdAt;
  String? _updatedAt;
  String? _timeSlot;
  String? _report;
  String? _image;
  String? _transactionId;
  String? _paymentType;
  String? _doctorName;
  String? _petType;
  String? _petName;
Data copyWith({  String? id,
  String? userId,
  String? doctorId,
  String? petId,
  String? description,
  String? day,
  String? date,
  String? status,
  String? createdAt,
  String? updatedAt,
  String? timeSlot,
  String? report,
  String? image,
  String? transactionId,
  String? paymentType,
  String? doctorName,
  String? petType,
  String? petName,
}) => Data(  id: id ?? _id,
  userId: userId ?? _userId,
  doctorId: doctorId ?? _doctorId,
  petId: petId ?? _petId,
  description: description ?? _description,
  day: day ?? _day,
  date: date ?? _date,
  status: status ?? _status,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  timeSlot: timeSlot ?? _timeSlot,
  report: report ?? _report,
  image: image ?? _image,
  transactionId: transactionId ?? _transactionId,
  paymentType: paymentType ?? _paymentType,
  doctorName: doctorName ?? _doctorName,
  petType: petType ?? _petType,
  petName: petName ?? _petName,
);
  String? get id => _id;
  String? get userId => _userId;
  String? get doctorId => _doctorId;
  String? get petId => _petId;
  String? get description => _description;
  String? get day => _day;
  String? get date => _date;
  String? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get timeSlot => _timeSlot;
  String? get report => _report;
  String? get image => _image;
  String? get transactionId => _transactionId;
  String? get paymentType => _paymentType;
  String? get doctorName => _doctorName;
  String? get petType => _petType;
  String? get petName => _petName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['doctor_id'] = _doctorId;
    map['pet_id'] = _petId;
    map['description'] = _description;
    map['day'] = _day;
    map['date'] = _date;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['time_slot'] = _timeSlot;
    map['report'] = _report;
    map['image'] = _image;
    map['transaction_id'] = _transactionId;
    map['payment_type'] = _paymentType;
    map['doctor_name'] = _doctorName;
    map['pet_type'] = _petType;
    map['pet_name'] = _petName;
    return map;
  }

}