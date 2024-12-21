class asfarListModel {
  int? id;
  String? name;
  int? tp;
  String? basl;
  int? chrcnt;
  int? kaComp;

  asfarListModel(
      {this.id, this.name, this.tp, this.basl, this.chrcnt, this.kaComp});

  asfarListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    tp = json['tp'];
    basl = json['basl'];
    chrcnt = json['chrcnt'];
    kaComp = json['ka_comp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['tp'] = this.tp;
    data['basl'] = this.basl;
    data['chrcnt'] = this.chrcnt;
    data['ka_comp'] = this.kaComp;
    return data;
  }
}
