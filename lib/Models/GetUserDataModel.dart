/// error : false
/// message : "User Data Retrive Success"
/// data : [{"id":"572","ip_address":"122.170.200.23","category_id":null,"company_name":null,"company_division":null,"designation_id":null,"title":null,"gender":null,"username":"dev","password":"$2y$10$p1YPNR2wBU6A0Pgrg.W0.Ot/J2T1yy8kVDIUstICQXDwGJ0XULDRO","email":"dev@gmail.com","mobile":"8349922853","image":"download_(1).png","balance":"0","activation_selector":"f145df975abdfb4e9852","activation_code":"$2y$10$v8.lB71j9cHSpV/IWjtY2.jv8d.Yu88K1NcDZiEBMtXmt/HNUMwH.","forgotten_password_selector":null,"forgotten_password_code":null,"forgotten_password_time":null,"remember_selector":null,"remember_code":null,"created_on":"1695040170","last_login":null,"active":"1","company":null,"address":null,"c_address":null,"doc_digree":null,"bonus_type":"percentage_per_order","bonus":null,"cash_received":"0.00","dob":null,"country_code":"91","otp":null,"roll":null,"city":null,"area":null,"street":null,"pincode":null,"serviceable_zipcodes":null,"apikey":null,"referral_code":null,"friends_code":null,"fcm_id":null,"device_token":null,"latitude":null,"longitude":null,"created_at":"2023-09-18 17:59:30","state_id":null,"city_id":null,"service_type":null,"area_id":null,"experience":null,"consultancy_fees":null,"open_time":null,"close_time":null,"clinic_address":null,"user_id":"733","group_id":"2"}]

class GetUserDataModel {
  GetUserDataModel({
      bool? error, 
      String? message, 
      List<Data>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  GetUserDataModel.fromJson(dynamic json) {
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
GetUserDataModel copyWith({  bool? error,
  String? message,
  List<Data>? data,
}) => GetUserDataModel(  error: error ?? _error,
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

/// id : "572"
/// ip_address : "122.170.200.23"
/// category_id : null
/// company_name : null
/// company_division : null
/// designation_id : null
/// title : null
/// gender : null
/// username : "dev"
/// password : "$2y$10$p1YPNR2wBU6A0Pgrg.W0.Ot/J2T1yy8kVDIUstICQXDwGJ0XULDRO"
/// email : "dev@gmail.com"
/// mobile : "8349922853"
/// image : "download_(1).png"
/// balance : "0"
/// activation_selector : "f145df975abdfb4e9852"
/// activation_code : "$2y$10$v8.lB71j9cHSpV/IWjtY2.jv8d.Yu88K1NcDZiEBMtXmt/HNUMwH."
/// forgotten_password_selector : null
/// forgotten_password_code : null
/// forgotten_password_time : null
/// remember_selector : null
/// remember_code : null
/// created_on : "1695040170"
/// last_login : null
/// active : "1"
/// company : null
/// address : null
/// c_address : null
/// doc_digree : null
/// bonus_type : "percentage_per_order"
/// bonus : null
/// cash_received : "0.00"
/// dob : null
/// country_code : "91"
/// otp : null
/// roll : null
/// city : null
/// area : null
/// street : null
/// pincode : null
/// serviceable_zipcodes : null
/// apikey : null
/// referral_code : null
/// friends_code : null
/// fcm_id : null
/// device_token : null
/// latitude : null
/// longitude : null
/// created_at : "2023-09-18 17:59:30"
/// state_id : null
/// city_id : null
/// service_type : null
/// area_id : null
/// experience : null
/// consultancy_fees : null
/// open_time : null
/// close_time : null
/// clinic_address : null
/// user_id : "733"
/// group_id : "2"

class Data {
  Data({
      String? id, 
      String? ipAddress, 
      dynamic categoryId, 
      dynamic companyName, 
      dynamic companyDivision, 
      dynamic designationId, 
      dynamic title, 
      dynamic gender, 
      String? username, 
      String? password, 
      String? email, 
      String? mobile, 
      String? image, 
      String? balance, 
      String? activationSelector, 
      String? activationCode, 
      dynamic forgottenPasswordSelector, 
      dynamic forgottenPasswordCode, 
      dynamic forgottenPasswordTime, 
      dynamic rememberSelector, 
      dynamic rememberCode, 
      String? createdOn, 
      dynamic lastLogin, 
      String? active, 
      dynamic company, 
      dynamic address, 
      dynamic cAddress, 
      dynamic docDigree, 
      String? bonusType, 
      dynamic bonus, 
      String? cashReceived, 
      dynamic dob, 
      String? countryCode, 
      dynamic otp, 
      dynamic roll, 
      dynamic city, 
      dynamic area, 
      dynamic street, 
      dynamic pincode, 
      dynamic serviceableZipcodes, 
      dynamic apikey, 
      dynamic referralCode, 
      dynamic friendsCode, 
      dynamic fcmId, 
      dynamic deviceToken, 
      dynamic latitude, 
      dynamic longitude, 
      String? createdAt, 
      dynamic stateId, 
      dynamic cityId, 
      dynamic serviceType, 
      dynamic areaId, 
      dynamic experience, 
      dynamic consultancyFees, 
      dynamic openTime, 
      dynamic closeTime, 
      dynamic clinicAddress, 
      String? userId, 
      String? groupId,}){
    _id = id;
    _ipAddress = ipAddress;
    _categoryId = categoryId;
    _companyName = companyName;
    _companyDivision = companyDivision;
    _designationId = designationId;
    _title = title;
    _gender = gender;
    _username = username;
    _password = password;
    _email = email;
    _mobile = mobile;
    _image = image;
    _balance = balance;
    _activationSelector = activationSelector;
    _activationCode = activationCode;
    _forgottenPasswordSelector = forgottenPasswordSelector;
    _forgottenPasswordCode = forgottenPasswordCode;
    _forgottenPasswordTime = forgottenPasswordTime;
    _rememberSelector = rememberSelector;
    _rememberCode = rememberCode;
    _createdOn = createdOn;
    _lastLogin = lastLogin;
    _active = active;
    _company = company;
    _address = address;
    _cAddress = cAddress;
    _docDigree = docDigree;
    _bonusType = bonusType;
    _bonus = bonus;
    _cashReceived = cashReceived;
    _dob = dob;
    _countryCode = countryCode;
    _otp = otp;
    _roll = roll;
    _city = city;
    _area = area;
    _street = street;
    _pincode = pincode;
    _serviceableZipcodes = serviceableZipcodes;
    _apikey = apikey;
    _referralCode = referralCode;
    _friendsCode = friendsCode;
    _fcmId = fcmId;
    _deviceToken = deviceToken;
    _latitude = latitude;
    _longitude = longitude;
    _createdAt = createdAt;
    _stateId = stateId;
    _cityId = cityId;
    _serviceType = serviceType;
    _areaId = areaId;
    _experience = experience;
    _consultancyFees = consultancyFees;
    _openTime = openTime;
    _closeTime = closeTime;
    _clinicAddress = clinicAddress;
    _userId = userId;
    _groupId = groupId;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _ipAddress = json['ip_address'];
    _categoryId = json['category_id'];
    _companyName = json['company_name'];
    _companyDivision = json['company_division'];
    _designationId = json['designation_id'];
    _title = json['title'];
    _gender = json['gender'];
    _username = json['username'];
    _password = json['password'];
    _email = json['email'];
    _mobile = json['mobile'];
    _image = json['image'];
    _balance = json['balance'];
    _activationSelector = json['activation_selector'];
    _activationCode = json['activation_code'];
    _forgottenPasswordSelector = json['forgotten_password_selector'];
    _forgottenPasswordCode = json['forgotten_password_code'];
    _forgottenPasswordTime = json['forgotten_password_time'];
    _rememberSelector = json['remember_selector'];
    _rememberCode = json['remember_code'];
    _createdOn = json['created_on'];
    _lastLogin = json['last_login'];
    _active = json['active'];
    _company = json['company'];
    _address = json['address'];
    _cAddress = json['c_address'];
    _docDigree = json['doc_digree'];
    _bonusType = json['bonus_type'];
    _bonus = json['bonus'];
    _cashReceived = json['cash_received'];
    _dob = json['dob'];
    _countryCode = json['country_code'];
    _otp = json['otp'];
    _roll = json['roll'];
    _city = json['city'];
    _area = json['area'];
    _street = json['street'];
    _pincode = json['pincode'];
    _serviceableZipcodes = json['serviceable_zipcodes'];
    _apikey = json['apikey'];
    _referralCode = json['referral_code'];
    _friendsCode = json['friends_code'];
    _fcmId = json['fcm_id'];
    _deviceToken = json['device_token'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _createdAt = json['created_at'];
    _stateId = json['state_id'];
    _cityId = json['city_id'];
    _serviceType = json['service_type'];
    _areaId = json['area_id'];
    _experience = json['experience'];
    _consultancyFees = json['consultancy_fees'];
    _openTime = json['open_time'];
    _closeTime = json['close_time'];
    _clinicAddress = json['clinic_address'];
    _userId = json['user_id'];
    _groupId = json['group_id'];
  }
  String? _id;
  String? _ipAddress;
  dynamic _categoryId;
  dynamic _companyName;
  dynamic _companyDivision;
  dynamic _designationId;
  dynamic _title;
  dynamic _gender;
  String? _username;
  String? _password;
  String? _email;
  String? _mobile;
  String? _image;
  String? _balance;
  String? _activationSelector;
  String? _activationCode;
  dynamic _forgottenPasswordSelector;
  dynamic _forgottenPasswordCode;
  dynamic _forgottenPasswordTime;
  dynamic _rememberSelector;
  dynamic _rememberCode;
  String? _createdOn;
  dynamic _lastLogin;
  String? _active;
  dynamic _company;
  dynamic _address;
  dynamic _cAddress;
  dynamic _docDigree;
  String? _bonusType;
  dynamic _bonus;
  String? _cashReceived;
  dynamic _dob;
  String? _countryCode;
  dynamic _otp;
  dynamic _roll;
  dynamic _city;
  dynamic _area;
  dynamic _street;
  dynamic _pincode;
  dynamic _serviceableZipcodes;
  dynamic _apikey;
  dynamic _referralCode;
  dynamic _friendsCode;
  dynamic _fcmId;
  dynamic _deviceToken;
  dynamic _latitude;
  dynamic _longitude;
  String? _createdAt;
  dynamic _stateId;
  dynamic _cityId;
  dynamic _serviceType;
  dynamic _areaId;
  dynamic _experience;
  dynamic _consultancyFees;
  dynamic _openTime;
  dynamic _closeTime;
  dynamic _clinicAddress;
  String? _userId;
  String? _groupId;
Data copyWith({  String? id,
  String? ipAddress,
  dynamic categoryId,
  dynamic companyName,
  dynamic companyDivision,
  dynamic designationId,
  dynamic title,
  dynamic gender,
  String? username,
  String? password,
  String? email,
  String? mobile,
  String? image,
  String? balance,
  String? activationSelector,
  String? activationCode,
  dynamic forgottenPasswordSelector,
  dynamic forgottenPasswordCode,
  dynamic forgottenPasswordTime,
  dynamic rememberSelector,
  dynamic rememberCode,
  String? createdOn,
  dynamic lastLogin,
  String? active,
  dynamic company,
  dynamic address,
  dynamic cAddress,
  dynamic docDigree,
  String? bonusType,
  dynamic bonus,
  String? cashReceived,
  dynamic dob,
  String? countryCode,
  dynamic otp,
  dynamic roll,
  dynamic city,
  dynamic area,
  dynamic street,
  dynamic pincode,
  dynamic serviceableZipcodes,
  dynamic apikey,
  dynamic referralCode,
  dynamic friendsCode,
  dynamic fcmId,
  dynamic deviceToken,
  dynamic latitude,
  dynamic longitude,
  String? createdAt,
  dynamic stateId,
  dynamic cityId,
  dynamic serviceType,
  dynamic areaId,
  dynamic experience,
  dynamic consultancyFees,
  dynamic openTime,
  dynamic closeTime,
  dynamic clinicAddress,
  String? userId,
  String? groupId,
}) => Data(  id: id ?? _id,
  ipAddress: ipAddress ?? _ipAddress,
  categoryId: categoryId ?? _categoryId,
  companyName: companyName ?? _companyName,
  companyDivision: companyDivision ?? _companyDivision,
  designationId: designationId ?? _designationId,
  title: title ?? _title,
  gender: gender ?? _gender,
  username: username ?? _username,
  password: password ?? _password,
  email: email ?? _email,
  mobile: mobile ?? _mobile,
  image: image ?? _image,
  balance: balance ?? _balance,
  activationSelector: activationSelector ?? _activationSelector,
  activationCode: activationCode ?? _activationCode,
  forgottenPasswordSelector: forgottenPasswordSelector ?? _forgottenPasswordSelector,
  forgottenPasswordCode: forgottenPasswordCode ?? _forgottenPasswordCode,
  forgottenPasswordTime: forgottenPasswordTime ?? _forgottenPasswordTime,
  rememberSelector: rememberSelector ?? _rememberSelector,
  rememberCode: rememberCode ?? _rememberCode,
  createdOn: createdOn ?? _createdOn,
  lastLogin: lastLogin ?? _lastLogin,
  active: active ?? _active,
  company: company ?? _company,
  address: address ?? _address,
  cAddress: cAddress ?? _cAddress,
  docDigree: docDigree ?? _docDigree,
  bonusType: bonusType ?? _bonusType,
  bonus: bonus ?? _bonus,
  cashReceived: cashReceived ?? _cashReceived,
  dob: dob ?? _dob,
  countryCode: countryCode ?? _countryCode,
  otp: otp ?? _otp,
  roll: roll ?? _roll,
  city: city ?? _city,
  area: area ?? _area,
  street: street ?? _street,
  pincode: pincode ?? _pincode,
  serviceableZipcodes: serviceableZipcodes ?? _serviceableZipcodes,
  apikey: apikey ?? _apikey,
  referralCode: referralCode ?? _referralCode,
  friendsCode: friendsCode ?? _friendsCode,
  fcmId: fcmId ?? _fcmId,
  deviceToken: deviceToken ?? _deviceToken,
  latitude: latitude ?? _latitude,
  longitude: longitude ?? _longitude,
  createdAt: createdAt ?? _createdAt,
  stateId: stateId ?? _stateId,
  cityId: cityId ?? _cityId,
  serviceType: serviceType ?? _serviceType,
  areaId: areaId ?? _areaId,
  experience: experience ?? _experience,
  consultancyFees: consultancyFees ?? _consultancyFees,
  openTime: openTime ?? _openTime,
  closeTime: closeTime ?? _closeTime,
  clinicAddress: clinicAddress ?? _clinicAddress,
  userId: userId ?? _userId,
  groupId: groupId ?? _groupId,
);
  String? get id => _id;
  String? get ipAddress => _ipAddress;
  dynamic get categoryId => _categoryId;
  dynamic get companyName => _companyName;
  dynamic get companyDivision => _companyDivision;
  dynamic get designationId => _designationId;
  dynamic get title => _title;
  dynamic get gender => _gender;
  String? get username => _username;
  String? get password => _password;
  String? get email => _email;
  String? get mobile => _mobile;
  String? get image => _image;
  String? get balance => _balance;
  String? get activationSelector => _activationSelector;
  String? get activationCode => _activationCode;
  dynamic get forgottenPasswordSelector => _forgottenPasswordSelector;
  dynamic get forgottenPasswordCode => _forgottenPasswordCode;
  dynamic get forgottenPasswordTime => _forgottenPasswordTime;
  dynamic get rememberSelector => _rememberSelector;
  dynamic get rememberCode => _rememberCode;
  String? get createdOn => _createdOn;
  dynamic get lastLogin => _lastLogin;
  String? get active => _active;
  dynamic get company => _company;
  dynamic get address => _address;
  dynamic get cAddress => _cAddress;
  dynamic get docDigree => _docDigree;
  String? get bonusType => _bonusType;
  dynamic get bonus => _bonus;
  String? get cashReceived => _cashReceived;
  dynamic get dob => _dob;
  String? get countryCode => _countryCode;
  dynamic get otp => _otp;
  dynamic get roll => _roll;
  dynamic get city => _city;
  dynamic get area => _area;
  dynamic get street => _street;
  dynamic get pincode => _pincode;
  dynamic get serviceableZipcodes => _serviceableZipcodes;
  dynamic get apikey => _apikey;
  dynamic get referralCode => _referralCode;
  dynamic get friendsCode => _friendsCode;
  dynamic get fcmId => _fcmId;
  dynamic get deviceToken => _deviceToken;
  dynamic get latitude => _latitude;
  dynamic get longitude => _longitude;
  String? get createdAt => _createdAt;
  dynamic get stateId => _stateId;
  dynamic get cityId => _cityId;
  dynamic get serviceType => _serviceType;
  dynamic get areaId => _areaId;
  dynamic get experience => _experience;
  dynamic get consultancyFees => _consultancyFees;
  dynamic get openTime => _openTime;
  dynamic get closeTime => _closeTime;
  dynamic get clinicAddress => _clinicAddress;
  String? get userId => _userId;
  String? get groupId => _groupId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['ip_address'] = _ipAddress;
    map['category_id'] = _categoryId;
    map['company_name'] = _companyName;
    map['company_division'] = _companyDivision;
    map['designation_id'] = _designationId;
    map['title'] = _title;
    map['gender'] = _gender;
    map['username'] = _username;
    map['password'] = _password;
    map['email'] = _email;
    map['mobile'] = _mobile;
    map['image'] = _image;
    map['balance'] = _balance;
    map['activation_selector'] = _activationSelector;
    map['activation_code'] = _activationCode;
    map['forgotten_password_selector'] = _forgottenPasswordSelector;
    map['forgotten_password_code'] = _forgottenPasswordCode;
    map['forgotten_password_time'] = _forgottenPasswordTime;
    map['remember_selector'] = _rememberSelector;
    map['remember_code'] = _rememberCode;
    map['created_on'] = _createdOn;
    map['last_login'] = _lastLogin;
    map['active'] = _active;
    map['company'] = _company;
    map['address'] = _address;
    map['c_address'] = _cAddress;
    map['doc_digree'] = _docDigree;
    map['bonus_type'] = _bonusType;
    map['bonus'] = _bonus;
    map['cash_received'] = _cashReceived;
    map['dob'] = _dob;
    map['country_code'] = _countryCode;
    map['otp'] = _otp;
    map['roll'] = _roll;
    map['city'] = _city;
    map['area'] = _area;
    map['street'] = _street;
    map['pincode'] = _pincode;
    map['serviceable_zipcodes'] = _serviceableZipcodes;
    map['apikey'] = _apikey;
    map['referral_code'] = _referralCode;
    map['friends_code'] = _friendsCode;
    map['fcm_id'] = _fcmId;
    map['device_token'] = _deviceToken;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['created_at'] = _createdAt;
    map['state_id'] = _stateId;
    map['city_id'] = _cityId;
    map['service_type'] = _serviceType;
    map['area_id'] = _areaId;
    map['experience'] = _experience;
    map['consultancy_fees'] = _consultancyFees;
    map['open_time'] = _openTime;
    map['close_time'] = _closeTime;
    map['clinic_address'] = _clinicAddress;
    map['user_id'] = _userId;
    map['group_id'] = _groupId;
    return map;
  }

}