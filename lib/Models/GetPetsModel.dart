/// error : false
/// message : "Pets Profiles"
/// data : [{"id":"4","user_id":"730","pet_type":"Cat","username":"Kitty","image":null,"age":"3","description":null,"created_at":"2023-08-29 13:01:11","updated_at":"2023-08-29 13:01:11"},{"id":"6","user_id":"730","pet_type":"Cat","username":"Kitty","image":"","age":"3","description":null,"created_at":"2023-09-20 19:00:19","updated_at":"2023-09-20 19:00:19"},{"id":"7","user_id":"730","pet_type":"Tiger","username":"Kitty","image":"","age":"3","description":null,"created_at":"2023-09-20 19:56:51","updated_at":"2023-09-20 19:56:51"},{"id":"8","user_id":"730","pet_type":"Dog","username":"Kitty","image":"uploads/review_image/favicon-managemnt-track1.png","age":"3","description":null,"created_at":"2023-09-20 19:01:02","updated_at":"2023-09-20 19:01:02"},{"id":"9","user_id":"730","pet_type":"Dog","username":"Kitty","image":"uploads/review_image/favicon-managemnt-track2.png","age":"3","description":null,"created_at":"2023-09-20 19:01:34","updated_at":"2023-09-20 19:01:34"}]

class GetPetsModel {
  GetPetsModel({
      bool? error, 
      String? message, 
      List<PetsData>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  GetPetsModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(PetsData.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  List<PetsData>? _data;
GetPetsModel copyWith({  bool? error,
  String? message,
  List<PetsData>? data,
}) => GetPetsModel(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  List<PetsData>? get data => _data;

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

/// id : "4"
/// user_id : "730"
/// pet_type : "Cat"
/// username : "Kitty"
/// image : null
/// age : "3"
/// description : null
/// created_at : "2023-08-29 13:01:11"
/// updated_at : "2023-08-29 13:01:11"

class PetsData {
  PetsData({
      String? id, 
      String? userId, 
      String? petType, 
      String? username, 
      dynamic image, 
      String? age, 
      dynamic description, 
      String? createdAt,
      bool? isSelected,
      String? updatedAt,}){
    _id = id;
    _userId = userId;
    _petType = petType;
    _username = username;
    isSelected = isSelected;
    _image = image;
    _age = age;
    _description = description;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  PetsData.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _petType = json['pet_type'];
    _username = json['username'];
    _image = json['image'];
    isSelected = false;
    _age = json['age'];
    _description = json['description'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  String? _id;
  String? _userId;
  String? _petType;
  String? _username;
  dynamic _image;
  String? _age;
  dynamic _description;
  String? _createdAt;
  bool? isSelected;
  String? _updatedAt;
  PetsData copyWith({  String? id,
  String? userId,
  String? petType,
  String? username,
  dynamic image,
  String? age,
  dynamic description,
  String? createdAt,
  String? updatedAt,
}) => PetsData(  id: id ?? _id,
  userId: userId ?? _userId,
  petType: petType ?? _petType,
  username: username ?? _username,
  image: image ?? _image,
  age: age ?? _age,
  description: description ?? _description,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  String? get id => _id;
  String? get userId => _userId;
  String? get petType => _petType;
  String? get username => _username;
  dynamic get image => _image;
  String? get age => _age;
  dynamic get description => _description;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['pet_type'] = _petType;
    map['username'] = _username;
    map['image'] = _image;
    map['age'] = _age;
    map['description'] = _description;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}