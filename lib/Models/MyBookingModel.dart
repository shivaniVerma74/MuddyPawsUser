/// error : false
/// message : "Booking retrieved successfully"
/// data : [{"id":"119","user_id":"793","doctor_id":"729","pet_id":"29","description":"New ","day":"","date":"2023-10-03","status":"1","created_at":"2023-10-03 19:41:39","updated_at":"2023-10-03 19:03:09","time_slot":"06:00:00","report":"uploads/review_image/image_picker3759751241696653461.jpg","image":"uploads/review_image/image_picker4785268403648370643.jpg","transaction_id":"TXN1235455555","payment_type":"online","prescription":null,"prescription_description":null,"doctor_name":"Sachin patware gurjar","doctor_mobile":"9754101854","pet_type":"Cat","pet_name":"New Cat"}]

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

/// id : "119"
/// user_id : "793"
/// doctor_id : "729"
/// pet_id : "29"
/// description : "New "
/// day : ""
/// date : "2023-10-03"
/// status : "1"
/// created_at : "2023-10-03 19:41:39"
/// updated_at : "2023-10-03 19:03:09"
/// time_slot : "06:00:00"
/// report : "uploads/review_image/image_picker3759751241696653461.jpg"
/// image : "uploads/review_image/image_picker4785268403648370643.jpg"
/// transaction_id : "TXN1235455555"
/// payment_type : "online"
/// prescription : null
/// prescription_description : null
/// doctor_name : "Sachin patware gurjar"
/// doctor_mobile : "9754101854"
/// pet_type : "Cat"
/// pet_name : "New Cat"

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
      dynamic prescription, 
      dynamic prescriptionDescription, 
      String? doctorName, 
      String? doctorMobile, 
      String? petType,
      String? serviceType,
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
    _prescription = prescription;
    _prescriptionDescription = prescriptionDescription;
    _doctorName = doctorName;
    serviceType = serviceType;
    _doctorMobile = doctorMobile;
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
    _prescription = json['prescription'];
    _prescriptionDescription = json['prescription_description'];
    _doctorName = json['doctor_name'];
    _doctorMobile = json['doctor_mobile'];
    serviceType = json['service_type'];
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
  dynamic _prescription;
  dynamic _prescriptionDescription;
  String? _doctorName;
  String? serviceType;
  String? _doctorMobile;
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
  String? serviceType,
  dynamic prescription,
  dynamic prescriptionDescription,
  String? doctorName,
  String? doctorMobile,
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
  prescription: prescription ?? _prescription,
  prescriptionDescription: prescriptionDescription ?? _prescriptionDescription,
  doctorName: doctorName ?? _doctorName,
  doctorMobile: doctorMobile ?? _doctorMobile,
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
  dynamic get prescription => _prescription;
  dynamic get prescriptionDescription => _prescriptionDescription;
  String? get doctorName => _doctorName;
  String? get doctorMobile => _doctorMobile;
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
    map['prescription'] = _prescription;
    map['prescription_description'] = _prescriptionDescription;
    map['doctor_name'] = _doctorName;
    map['doctor_mobile'] = _doctorMobile;
    map['pet_type'] = _petType;
    map['pet_name'] = _petName;
    return map;
  }

}