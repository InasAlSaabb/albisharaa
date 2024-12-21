class AyatModel {
  int? id;
  int? sfrnr;
  String? hid;
  int? chnr;
  int? vnumber;
  String? textch;
  String? tid;

  AyatModel(
      {this.id,
      this.sfrnr,
      this.hid,
      this.chnr,
      this.vnumber,
      this.textch,
      this.tid});

  AyatModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sfrnr = json['sfrnr'];
    hid = json['hid'];
    chnr = json['chnr'];
    vnumber = json['vnumber'];
    textch = json['textch'];
    tid = json['tid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sfrnr'] = this.sfrnr;
    data['hid'] = this.hid;
    data['chnr'] = this.chnr;
    data['vnumber'] = this.vnumber;
    data['textch'] = this.textch;
    data['tid'] = this.tid;
    return data;
  }
}
