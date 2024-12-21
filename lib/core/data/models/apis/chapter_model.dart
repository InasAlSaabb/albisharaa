import 'package:albisharaa/core/data/models/apis/versemodel.dart';

class ChapterModel {
  int? chnr;
  List<VerseModel>? verses;

  ChapterModel({
    this.chnr,
    this.verses,
  });

  factory ChapterModel.fromJson(Map<String, dynamic> json) {
    return ChapterModel(
      chnr: json['chnr'],
      verses: (json['verses'] as List?)
          ?.map((v) => VerseModel.fromJson(v))
          .toList(),
    );
  }
}
