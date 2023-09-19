/// message : "Category retrieved successfully"
/// error : false
/// total : 2
/// data : [{"id":"1","name":"online consultation","parent_id":"0","slug":"online-consultation","image":"https://developmentalphawizz.com/dr_vet_app/uploads/media/2023/thumb-sm/muddy-paws-logo001.png","banner":"https://developmentalphawizz.com/dr_vet_app/","row_order":"0","status":"1","cat_type":"1","clicks":"0","children":[],"text":"online consultation","icon":"jstree-folder","level":0,"total":2},{"id":"2","name":"in clinic","parent_id":"0","slug":"in-clinic","image":"https://developmentalphawizz.com/dr_vet_app/uploads/media/2023/thumb-sm/muddy-paws-logo001.png","banner":"https://developmentalphawizz.com/dr_vet_app/","row_order":"0","status":"1","cat_type":"3","clicks":"0","children":[],"text":"in clinic","icon":"jstree-folder","level":0}]
/// popular_categories : []

class GetCategoryModel {
  GetCategoryModel({
      String? message, 
      bool? error, 
      num? total, 
      List<Data>? data, 
      List<dynamic>? popularCategories,}){
    _message = message;
    _error = error;
    _total = total;
    _data = data;
    _popularCategories = popularCategories;
}

  GetCategoryModel.fromJson(dynamic json) {
    _message = json['message'];
    _error = json['error'];
    _total = json['total'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    if (json['popular_categories'] != null) {
      _popularCategories = [];
      json['popular_categories'].forEach((v) {
        _popularCategories?.add(v.fromJson(v));
      });
    }
  }
  String? _message;
  bool? _error;
  num? _total;
  List<Data>? _data;
  List<dynamic>? _popularCategories;
GetCategoryModel copyWith({  String? message,
  bool? error,
  num? total,
  List<Data>? data,
  List<dynamic>? popularCategories,
}) => GetCategoryModel(  message: message ?? _message,
  error: error ?? _error,
  total: total ?? _total,
  data: data ?? _data,
  popularCategories: popularCategories ?? _popularCategories,
);
  String? get message => _message;
  bool? get error => _error;
  num? get total => _total;
  List<Data>? get data => _data;
  List<dynamic>? get popularCategories => _popularCategories;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    map['error'] = _error;
    map['total'] = _total;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    if (_popularCategories != null) {
      map['popular_categories'] = _popularCategories?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "1"
/// name : "online consultation"
/// parent_id : "0"
/// slug : "online-consultation"
/// image : "https://developmentalphawizz.com/dr_vet_app/uploads/media/2023/thumb-sm/muddy-paws-logo001.png"
/// banner : "https://developmentalphawizz.com/dr_vet_app/"
/// row_order : "0"
/// status : "1"
/// cat_type : "1"
/// clicks : "0"
/// children : []
/// text : "online consultation"
/// icon : "jstree-folder"
/// level : 0
/// total : 2

class Data {
  Data({
      String? id, 
      String? name, 
      String? parentId, 
      String? slug, 
      String? image, 
      String? banner, 
      String? rowOrder, 
      String? status, 
      String? catType, 
      String? clicks, 
      List<dynamic>? children, 
      String? text, 
      String? icon, 
      num? level, 
      num? total,}){
    _id = id;
    _name = name;
    _parentId = parentId;
    _slug = slug;
    _image = image;
    _banner = banner;
    _rowOrder = rowOrder;
    _status = status;
    _catType = catType;
    _clicks = clicks;
    _children = children;
    _text = text;
    _icon = icon;
    _level = level;
    _total = total;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _parentId = json['parent_id'];
    _slug = json['slug'];
    _image = json['image'];
    _banner = json['banner'];
    _rowOrder = json['row_order'];
    _status = json['status'];
    _catType = json['cat_type'];
    _clicks = json['clicks'];
    if (json['children'] != null) {
      _children = [];
      json['children'].forEach((v) {
        _children?.add(v.fromJson(v));
      });
    }
    _text = json['text'];
    _icon = json['icon'];
    _level = json['level'];
    _total = json['total'];
  }
  String? _id;
  String? _name;
  String? _parentId;
  String? _slug;
  String? _image;
  String? _banner;
  String? _rowOrder;
  String? _status;
  String? _catType;
  String? _clicks;
  List<dynamic>? _children;
  String? _text;
  String? _icon;
  num? _level;
  num? _total;
Data copyWith({  String? id,
  String? name,
  String? parentId,
  String? slug,
  String? image,
  String? banner,
  String? rowOrder,
  String? status,
  String? catType,
  String? clicks,
  List<dynamic>? children,
  String? text,
  String? icon,
  num? level,
  num? total,
}) => Data(  id: id ?? _id,
  name: name ?? _name,
  parentId: parentId ?? _parentId,
  slug: slug ?? _slug,
  image: image ?? _image,
  banner: banner ?? _banner,
  rowOrder: rowOrder ?? _rowOrder,
  status: status ?? _status,
  catType: catType ?? _catType,
  clicks: clicks ?? _clicks,
  children: children ?? _children,
  text: text ?? _text,
  icon: icon ?? _icon,
  level: level ?? _level,
  total: total ?? _total,
);
  String? get id => _id;
  String? get name => _name;
  String? get parentId => _parentId;
  String? get slug => _slug;
  String? get image => _image;
  String? get banner => _banner;
  String? get rowOrder => _rowOrder;
  String? get status => _status;
  String? get catType => _catType;
  String? get clicks => _clicks;
  List<dynamic>? get children => _children;
  String? get text => _text;
  String? get icon => _icon;
  num? get level => _level;
  num? get total => _total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['parent_id'] = _parentId;
    map['slug'] = _slug;
    map['image'] = _image;
    map['banner'] = _banner;
    map['row_order'] = _rowOrder;
    map['status'] = _status;
    map['cat_type'] = _catType;
    map['clicks'] = _clicks;
    if (_children != null) {
      map['children'] = _children?.map((v) => v.toJson()).toList();
    }
    map['text'] = _text;
    map['icon'] = _icon;
    map['level'] = _level;
    map['total'] = _total;
    return map;
  }

}