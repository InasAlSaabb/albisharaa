class VerseModel {
  int? id;
  int? sfrnr;
  String? hid;
  int? chnr;
  int? vnumber;
  String? textch;
  String? tid;

  VerseModel({
    this.id,
    this.sfrnr,
    this.hid,
    this.chnr,
    this.vnumber,
    this.textch,
    this.tid,
  });

  factory VerseModel.fromJson(Map<String, dynamic> json) {
    return VerseModel(
      id: json['id'],
      sfrnr: json['sfrnr'],
      hid: json['hid'],
      chnr: json['chnr'],
      vnumber: json['vnumber'],
      textch: json['textch'],
      tid: json['tid'],
    );
  }
}
