class Cartoon {
  String gender = '';
  String img = '';
  String sId = '';
  String name = '';
  List<PsiPowers> psiPowers = [];
  int iV = 0;

  Cartoon(
      {required this.gender,
      required this.img,
      required this.sId,
      required this.name,
      required this.psiPowers,
      required this.iV});

  Cartoon.fromJson(Map<String, dynamic> json) {
    gender = json['gender'];
    img = json['img'];
    sId = json['_id'];
    name = json['name'];
    if (json['psiPowers'] != null) {
      psiPowers = <PsiPowers>[];
      json['psiPowers'].forEach((v) {
        psiPowers.add(new PsiPowers.fromJson(v));
      });
    }
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gender'] = this.gender;
    data['img'] = this.img;
    data['_id'] = this.sId;
    data['name'] = this.name;
    if (this.psiPowers != null) {
      data['psiPowers'] = this.psiPowers.map((v) => v.toJson()).toList();
    }
    data['__v'] = this.iV;
    return data;
  }
}

class PsiPowers {
  String description = '';
  String img = '';
  String sId = '';
  String name = '';

  PsiPowers(
      {required this.description,
      required this.img,
      required this.sId,
      required this.name});

  PsiPowers.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    img = json['img'];
    sId = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['img'] = this.img;
    data['_id'] = this.sId;
    data['name'] = this.name;
    return data;
  }
}
