import 'package:albisharaa/core/data/models/apis/chapter_model.dart';

class SefrModel {
  int? id;
  String? name;
  int? tp;
  String? basl;
  int? chrcnt;
  List<ChapterModel>? chapters;

  SefrModel({
    this.id,
    this.name,
    this.tp,
    this.basl,
    this.chrcnt,
    this.chapters,
  });

  factory SefrModel.fromJson(Map<String, dynamic> json) {
    return SefrModel(
      id: json['id'],
      name: json['name'],
      tp: json['tp'],
      basl: json['basl'],
      chrcnt: json['chrcnt'],
      chapters: (json['chapters'] as List?)
          ?.map((c) => ChapterModel.fromJson(c))
          .toList(),
    );
  }
}
