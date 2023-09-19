/// error : false
/// message : "Doctor Retrive Success"
/// data : [{"id":"107","ip_address":"49.43.2.82","category_id":null,"company_name":null,"company_division":null,"designation_id":null,"title":"Dr.","gender":"Female","username":"Shivani Pandey","password":"$2y$10$.OYZZsBaSv/HfBLy49tAJews68ACPeq4BTmp3zS1fkDktKLsrfEZq","email":"shivani.alphawizz@mailinator.com","mobile":"8899665588","image":null,"balance":"0","activation_selector":"774d17adb10c7a8d140f","activation_code":"$2y$10$OUszjYapdeGEdoLc6HPBnuMoq1M7oxW0BBNvRBdTGj1GQTChwlzV.","forgotten_password_selector":null,"forgotten_password_code":null,"forgotten_password_time":null,"remember_selector":null,"remember_code":null,"created_on":"1693292911","last_login":"1693465044","active":"1","company":null,"address":null,"c_address":null,"doc_digree":"Bachelor of Veterinary Science (BVSc)","bonus_type":"percentage_per_order","bonus":null,"cash_received":"0.00","dob":null,"country_code":null,"otp":null,"roll":"1","city":null,"area":null,"street":null,"pincode":null,"serviceable_zipcodes":null,"apikey":null,"referral_code":null,"friends_code":null,"fcm_id":null,"device_token":null,"latitude":"24.530727","longitude":"81.299110","created_at":"2023-08-29 12:38:31","state_id":"9","city_id":"220","service_type":"1","area_id":null,"experience":"5 Year","user_id":"734","slug":null,"category_ids":"167","cat_type":null,"store_name":null,"store_description":null,"logo":"","store_url":null,"no_of_ratings":"0","rating":"0.00","bank_name":null,"open_time":null,"close_time":null,"bank_code":null,"account_name":null,"account_number":null,"national_identity_card":null,"address_proof":"","pan_number":null,"tax_name":null,"tax_number":null,"permissions":null,"commission":"0.00","status":"0","date_added":"2023-08-29 12:38:31","seller_id":"734","kilometers":"0"}]

class GetDoctorModel {
  GetDoctorModel({
      bool? error, 
      String? message, 
      List<Data>? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  GetDoctorModel.fromJson(dynamic json) {
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
GetDoctorModel copyWith({  bool? error,
  String? message,
  List<Data>? data,
}) => GetDoctorModel(  error: error ?? _error,
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

/// id : "107"
/// ip_address : "49.43.2.82"
/// category_id : null
/// company_name : null
/// company_division : null
/// designation_id : null
/// title : "Dr."
/// gender : "Female"
/// username : "Shivani Pandey"
/// password : "$2y$10$.OYZZsBaSv/HfBLy49tAJews68ACPeq4BTmp3zS1fkDktKLsrfEZq"
/// email : "shivani.alphawizz@mailinator.com"
/// mobile : "8899665588"
/// image : null
/// balance : "0"
/// activation_selector : "774d17adb10c7a8d140f"
/// activation_code : "$2y$10$OUszjYapdeGEdoLc6HPBnuMoq1M7oxW0BBNvRBdTGj1GQTChwlzV."
/// forgotten_password_selector : null
/// forgotten_password_code : null
/// forgotten_password_time : null
/// remember_selector : null
/// remember_code : null
/// created_on : "1693292911"
/// last_login : "1693465044"
/// active : "1"
/// company : null
/// address : null
/// c_address : null
/// doc_digree : "Bachelor of Veterinary Science (BVSc)"
/// bonus_type : "percentage_per_order"
/// bonus : null
/// cash_received : "0.00"
/// dob : null
/// country_code : null
/// otp : null
/// roll : "1"
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
/// latitude : "24.530727"
/// longitude : "81.299110"
/// created_at : "2023-08-29 12:38:31"
/// state_id : "9"
/// city_id : "220"
/// service_type : "1"
/// area_id : null
/// experience : "5 Year"
/// user_id : "734"
/// slug : null
/// category_ids : "167"
/// cat_type : null
/// store_name : null
/// store_description : null
/// logo : ""
/// store_url : null
/// no_of_ratings : "0"
/// rating : "0.00"
/// bank_name : null
/// open_time : null
/// close_time : null
/// bank_code : null
/// account_name : null
/// account_number : null
/// national_identity_card : null
/// address_proof : ""
/// pan_number : null
/// tax_name : null
/// tax_number : null
/// permissions : null
/// commission : "0.00"
/// status : "0"
/// date_added : "2023-08-29 12:38:31"
/// seller_id : "734"
/// kilometers : "0"

class Data {
  Data({
      String? id, 
      String? ipAddress, 
      dynamic categoryId, 
      dynamic companyName, 
      dynamic companyDivision, 
      dynamic designationId, 
      String? title, 
      String? gender, 
      String? username, 
      String? password, 
      String? email, 
      String? mobile, 
      dynamic image, 
      String? balance, 
      String? activationSelector, 
      String? activationCode, 
      dynamic forgottenPasswordSelector, 
      dynamic forgottenPasswordCode, 
      dynamic forgottenPasswordTime, 
      dynamic rememberSelector, 
      dynamic rememberCode, 
      String? createdOn, 
      String? lastLogin, 
      String? active, 
      dynamic company, 
      dynamic address, 
      dynamic cAddress, 
      String? docDigree, 
      String? bonusType, 
      dynamic bonus, 
      String? cashReceived, 
      dynamic dob, 
      dynamic countryCode, 
      dynamic otp, 
      String? roll, 
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
      String? latitude, 
      String? longitude, 
      String? createdAt, 
      String? stateId, 
      String? cityId, 
      String? serviceType, 
      dynamic areaId, 
      String? experience, 
      String? userId, 
      dynamic slug, 
      String? categoryIds, 
      dynamic catType, 
      dynamic storeName, 
      dynamic storeDescription, 
      String? logo, 
      dynamic storeUrl, 
      String? noOfRatings, 
      String? rating, 
      dynamic bankName, 
      dynamic openTime, 
      dynamic closeTime, 
      dynamic bankCode, 
      dynamic accountName, 
      dynamic accountNumber, 
      dynamic nationalIdentityCard, 
      String? addressProof, 
      dynamic panNumber, 
      dynamic taxName, 
      dynamic taxNumber, 
      dynamic permissions, 
      String? commission, 
      String? status, 
      String? dateAdded, 
      String? sellerId, 
      String? kilometers,}){
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
    _userId = userId;
    _slug = slug;
    _categoryIds = categoryIds;
    _catType = catType;
    _storeName = storeName;
    _storeDescription = storeDescription;
    _logo = logo;
    _storeUrl = storeUrl;
    _noOfRatings = noOfRatings;
    _rating = rating;
    _bankName = bankName;
    _openTime = openTime;
    _closeTime = closeTime;
    _bankCode = bankCode;
    _accountName = accountName;
    _accountNumber = accountNumber;
    _nationalIdentityCard = nationalIdentityCard;
    _addressProof = addressProof;
    _panNumber = panNumber;
    _taxName = taxName;
    _taxNumber = taxNumber;
    _permissions = permissions;
    _commission = commission;
    _status = status;
    _dateAdded = dateAdded;
    _sellerId = sellerId;
    _kilometers = kilometers;
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
    _userId = json['user_id'];
    _slug = json['slug'];
    _categoryIds = json['category_ids'];
    _catType = json['cat_type'];
    _storeName = json['store_name'];
    _storeDescription = json['store_description'];
    _logo = json['logo'];
    _storeUrl = json['store_url'];
    _noOfRatings = json['no_of_ratings'];
    _rating = json['rating'];
    _bankName = json['bank_name'];
    _openTime = json['open_time'];
    _closeTime = json['close_time'];
    _bankCode = json['bank_code'];
    _accountName = json['account_name'];
    _accountNumber = json['account_number'];
    _nationalIdentityCard = json['national_identity_card'];
    _addressProof = json['address_proof'];
    _panNumber = json['pan_number'];
    _taxName = json['tax_name'];
    _taxNumber = json['tax_number'];
    _permissions = json['permissions'];
    _commission = json['commission'];
    _status = json['status'];
    _dateAdded = json['date_added'];
    _sellerId = json['seller_id'];
    _kilometers = json['kilometers'];
  }
  String? _id;
  String? _ipAddress;
  dynamic _categoryId;
  dynamic _companyName;
  dynamic _companyDivision;
  dynamic _designationId;
  String? _title;
  String? _gender;
  String? _username;
  String? _password;
  String? _email;
  String? _mobile;
  dynamic _image;
  String? _balance;
  String? _activationSelector;
  String? _activationCode;
  dynamic _forgottenPasswordSelector;
  dynamic _forgottenPasswordCode;
  dynamic _forgottenPasswordTime;
  dynamic _rememberSelector;
  dynamic _rememberCode;
  String? _createdOn;
  String? _lastLogin;
  String? _active;
  dynamic _company;
  dynamic _address;
  dynamic _cAddress;
  String? _docDigree;
  String? _bonusType;
  dynamic _bonus;
  String? _cashReceived;
  dynamic _dob;
  dynamic _countryCode;
  dynamic _otp;
  String? _roll;
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
  String? _latitude;
  String? _longitude;
  String? _createdAt;
  String? _stateId;
  String? _cityId;
  String? _serviceType;
  dynamic _areaId;
  String? _experience;
  String? _userId;
  dynamic _slug;
  String? _categoryIds;
  dynamic _catType;
  dynamic _storeName;
  dynamic _storeDescription;
  String? _logo;
  dynamic _storeUrl;
  String? _noOfRatings;
  String? _rating;
  dynamic _bankName;
  dynamic _openTime;
  dynamic _closeTime;
  dynamic _bankCode;
  dynamic _accountName;
  dynamic _accountNumber;
  dynamic _nationalIdentityCard;
  String? _addressProof;
  dynamic _panNumber;
  dynamic _taxName;
  dynamic _taxNumber;
  dynamic _permissions;
  String? _commission;
  String? _status;
  String? _dateAdded;
  String? _sellerId;
  String? _kilometers;
Data copyWith({  String? id,
  String? ipAddress,
  dynamic categoryId,
  dynamic companyName,
  dynamic companyDivision,
  dynamic designationId,
  String? title,
  String? gender,
  String? username,
  String? password,
  String? email,
  String? mobile,
  dynamic image,
  String? balance,
  String? activationSelector,
  String? activationCode,
  dynamic forgottenPasswordSelector,
  dynamic forgottenPasswordCode,
  dynamic forgottenPasswordTime,
  dynamic rememberSelector,
  dynamic rememberCode,
  String? createdOn,
  String? lastLogin,
  String? active,
  dynamic company,
  dynamic address,
  dynamic cAddress,
  String? docDigree,
  String? bonusType,
  dynamic bonus,
  String? cashReceived,
  dynamic dob,
  dynamic countryCode,
  dynamic otp,
  String? roll,
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
  String? latitude,
  String? longitude,
  String? createdAt,
  String? stateId,
  String? cityId,
  String? serviceType,
  dynamic areaId,
  String? experience,
  String? userId,
  dynamic slug,
  String? categoryIds,
  dynamic catType,
  dynamic storeName,
  dynamic storeDescription,
  String? logo,
  dynamic storeUrl,
  String? noOfRatings,
  String? rating,
  dynamic bankName,
  dynamic openTime,
  dynamic closeTime,
  dynamic bankCode,
  dynamic accountName,
  dynamic accountNumber,
  dynamic nationalIdentityCard,
  String? addressProof,
  dynamic panNumber,
  dynamic taxName,
  dynamic taxNumber,
  dynamic permissions,
  String? commission,
  String? status,
  String? dateAdded,
  String? sellerId,
  String? kilometers,
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
  userId: userId ?? _userId,
  slug: slug ?? _slug,
  categoryIds: categoryIds ?? _categoryIds,
  catType: catType ?? _catType,
  storeName: storeName ?? _storeName,
  storeDescription: storeDescription ?? _storeDescription,
  logo: logo ?? _logo,
  storeUrl: storeUrl ?? _storeUrl,
  noOfRatings: noOfRatings ?? _noOfRatings,
  rating: rating ?? _rating,
  bankName: bankName ?? _bankName,
  openTime: openTime ?? _openTime,
  closeTime: closeTime ?? _closeTime,
  bankCode: bankCode ?? _bankCode,
  accountName: accountName ?? _accountName,
  accountNumber: accountNumber ?? _accountNumber,
  nationalIdentityCard: nationalIdentityCard ?? _nationalIdentityCard,
  addressProof: addressProof ?? _addressProof,
  panNumber: panNumber ?? _panNumber,
  taxName: taxName ?? _taxName,
  taxNumber: taxNumber ?? _taxNumber,
  permissions: permissions ?? _permissions,
  commission: commission ?? _commission,
  status: status ?? _status,
  dateAdded: dateAdded ?? _dateAdded,
  sellerId: sellerId ?? _sellerId,
  kilometers: kilometers ?? _kilometers,
);
  String? get id => _id;
  String? get ipAddress => _ipAddress;
  dynamic get categoryId => _categoryId;
  dynamic get companyName => _companyName;
  dynamic get companyDivision => _companyDivision;
  dynamic get designationId => _designationId;
  String? get title => _title;
  String? get gender => _gender;
  String? get username => _username;
  String? get password => _password;
  String? get email => _email;
  String? get mobile => _mobile;
  dynamic get image => _image;
  String? get balance => _balance;
  String? get activationSelector => _activationSelector;
  String? get activationCode => _activationCode;
  dynamic get forgottenPasswordSelector => _forgottenPasswordSelector;
  dynamic get forgottenPasswordCode => _forgottenPasswordCode;
  dynamic get forgottenPasswordTime => _forgottenPasswordTime;
  dynamic get rememberSelector => _rememberSelector;
  dynamic get rememberCode => _rememberCode;
  String? get createdOn => _createdOn;
  String? get lastLogin => _lastLogin;
  String? get active => _active;
  dynamic get company => _company;
  dynamic get address => _address;
  dynamic get cAddress => _cAddress;
  String? get docDigree => _docDigree;
  String? get bonusType => _bonusType;
  dynamic get bonus => _bonus;
  String? get cashReceived => _cashReceived;
  dynamic get dob => _dob;
  dynamic get countryCode => _countryCode;
  dynamic get otp => _otp;
  String? get roll => _roll;
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
  String? get latitude => _latitude;
  String? get longitude => _longitude;
  String? get createdAt => _createdAt;
  String? get stateId => _stateId;
  String? get cityId => _cityId;
  String? get serviceType => _serviceType;
  dynamic get areaId => _areaId;
  String? get experience => _experience;
  String? get userId => _userId;
  dynamic get slug => _slug;
  String? get categoryIds => _categoryIds;
  dynamic get catType => _catType;
  dynamic get storeName => _storeName;
  dynamic get storeDescription => _storeDescription;
  String? get logo => _logo;
  dynamic get storeUrl => _storeUrl;
  String? get noOfRatings => _noOfRatings;
  String? get rating => _rating;
  dynamic get bankName => _bankName;
  dynamic get openTime => _openTime;
  dynamic get closeTime => _closeTime;
  dynamic get bankCode => _bankCode;
  dynamic get accountName => _accountName;
  dynamic get accountNumber => _accountNumber;
  dynamic get nationalIdentityCard => _nationalIdentityCard;
  String? get addressProof => _addressProof;
  dynamic get panNumber => _panNumber;
  dynamic get taxName => _taxName;
  dynamic get taxNumber => _taxNumber;
  dynamic get permissions => _permissions;
  String? get commission => _commission;
  String? get status => _status;
  String? get dateAdded => _dateAdded;
  String? get sellerId => _sellerId;
  String? get kilometers => _kilometers;

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
    map['user_id'] = _userId;
    map['slug'] = _slug;
    map['category_ids'] = _categoryIds;
    map['cat_type'] = _catType;
    map['store_name'] = _storeName;
    map['store_description'] = _storeDescription;
    map['logo'] = _logo;
    map['store_url'] = _storeUrl;
    map['no_of_ratings'] = _noOfRatings;
    map['rating'] = _rating;
    map['bank_name'] = _bankName;
    map['open_time'] = _openTime;
    map['close_time'] = _closeTime;
    map['bank_code'] = _bankCode;
    map['account_name'] = _accountName;
    map['account_number'] = _accountNumber;
    map['national_identity_card'] = _nationalIdentityCard;
    map['address_proof'] = _addressProof;
    map['pan_number'] = _panNumber;
    map['tax_name'] = _taxName;
    map['tax_number'] = _taxNumber;
    map['permissions'] = _permissions;
    map['commission'] = _commission;
    map['status'] = _status;
    map['date_added'] = _dateAdded;
    map['seller_id'] = _sellerId;
    map['kilometers'] = _kilometers;
    return map;
  }

}