/// error : false
/// data : [{"id":"133","type":"dashboard_slider","type_id":"0","company_id":"0","image":"https://developmentalphawizz.com/dr_vet_app/uploads/media/2023/medicineshutterstock_14210416881.jpg","video":"","slider":"link","specialization":"100","link":null,"date_added":"2023-08-29 13:27:47","data":[]},{"id":"134","type":"dashboard_slider","type_id":"0","company_id":"0","image":"https://developmentalphawizz.com/dr_vet_app/uploads/media/2023/Mask_Group_393278.png","video":"","slider":"link","specialization":"100","link":null,"date_added":"2023-08-29 13:29:17","data":[]}]

class SliderModel {
  SliderModel({
      bool? error, 
      List<Data>? data,}){
    _error = error;
    _data = data;
}

  SliderModel.fromJson(dynamic json) {
    _error = json['error'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _error;
  List<Data>? _data;
SliderModel copyWith({  bool? error,
  List<Data>? data,
}) => SliderModel(  error: error ?? _error,
  data: data ?? _data,
);
  bool? get error => _error;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "133"
/// type : "dashboard_slider"
/// type_id : "0"
/// company_id : "0"
/// image : "https://developmentalphawizz.com/dr_vet_app/uploads/media/2023/medicineshutterstock_14210416881.jpg"
/// video : ""
/// slider : "link"
/// specialization : "100"
/// link : null
/// date_added : "2023-08-29 13:27:47"
/// data : []

class Data {
  Data({
      String? id, 
      String? type, 
      String? typeId, 
      String? companyId, 
      String? image, 
      String? video, 
      String? slider, 
      String? specialization, 
      dynamic link, 
      String? dateAdded, 
      List<dynamic>? data,}){
    _id = id;
    _type = type;
    _typeId = typeId;
    _companyId = companyId;
    _image = image;
    _video = video;
    _slider = slider;
    _specialization = specialization;
    _link = link;
    _dateAdded = dateAdded;
    _data = data;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _type = json['type'];
    _typeId = json['type_id'];
    _companyId = json['company_id'];
    _image = json['image'];
    _video = json['video'];
    _slider = json['slider'];
    _specialization = json['specialization'];
    _link = json['link'];
    _dateAdded = json['date_added'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(v.fromJson(v));
      });
    }
  }
  String? _id;
  String? _type;
  String? _typeId;
  String? _companyId;
  String? _image;
  String? _video;
  String? _slider;
  String? _specialization;
  dynamic _link;
  String? _dateAdded;
  List<dynamic>? _data;
Data copyWith({  String? id,
  String? type,
  String? typeId,
  String? companyId,
  String? image,
  String? video,
  String? slider,
  String? specialization,
  dynamic link,
  String? dateAdded,
  List<dynamic>? data,
}) => Data(  id: id ?? _id,
  type: type ?? _type,
  typeId: typeId ?? _typeId,
  companyId: companyId ?? _companyId,
  image: image ?? _image,
  video: video ?? _video,
  slider: slider ?? _slider,
  specialization: specialization ?? _specialization,
  link: link ?? _link,
  dateAdded: dateAdded ?? _dateAdded,
  data: data ?? _data,
);
  String? get id => _id;
  String? get type => _type;
  String? get typeId => _typeId;
  String? get companyId => _companyId;
  String? get image => _image;
  String? get video => _video;
  String? get slider => _slider;
  String? get specialization => _specialization;
  dynamic get link => _link;
  String? get dateAdded => _dateAdded;
  List<dynamic>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['type'] = _type;
    map['type_id'] = _typeId;
    map['company_id'] = _companyId;
    map['image'] = _image;
    map['video'] = _video;
    map['slider'] = _slider;
    map['specialization'] = _specialization;
    map['link'] = _link;
    map['date_added'] = _dateAdded;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}