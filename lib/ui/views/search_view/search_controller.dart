import 'package:albisharaa/core/data/models/apis/versemodel.dart';
import 'package:albisharaa/core/services/base_controller.dart';
import 'package:albisharaa/core/services/sql_services.dart';
import 'package:get/get.dart';

class SearchControllerr extends BaseController {
  RxList<VerseModel> searchResults = <VerseModel>[].obs;

  Future<void> searchVerses(String searchTerm, int sefrId) async {
    searchResults.value = await SqlDb().searchVerses(searchTerm, sefrId);
  }

  Future<void> searchALLVerses(String searchTerm) async {
    searchResults.value = await SqlDb().searchALLVerses(searchTerm);
  }

  // Future<void> searchAllBooks(String searchTerm) async {
  //   searchResults.value = await DatabaseService().searchAllBooks(searchTerm);
  // }

  Future<void> searchOldTestament(String searchTerm) async {
    searchResults.value = await SqlDb().searchOldTestament(searchTerm);
  }

  Future<void> searchNewTestament(String searchTerm) async {
    searchResults.value = await SqlDb().searchNewTestament(searchTerm);
  }
}
