class bisharaModel {
  String? m;
  String? v;
  String? k;
  String? p;
  String? h;
  String? sY;
  String? gR;
  String? hE;
  String? eN;
  String? fR;

  bisharaModel(
      {this.m,
      this.v,
      this.k,
      this.p,
      this.h,
      this.sY,
      this.gR,
      this.hE,
      this.eN,
      this.fR});

  bisharaModel.fromJson(Map<String, dynamic> json) {
    m = json['M'];
    v = json['V'];
    k = json['K'];
    p = json['P'];
    h = json['H'];
    sY = json['SY'];
    gR = json['GR'];
    hE = json['HE'];
    eN = json['EN'];
    fR = json['FR'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['M'] = this.m;
    data['V'] = this.v;
    data['K'] = this.k;
    data['P'] = this.p;
    data['H'] = this.h;
    data['SY'] = this.sY;
    data['GR'] = this.gR;
    data['HE'] = this.hE;
    data['EN'] = this.eN;
    data['FR'] = this.fR;
    return data;
  }
}
