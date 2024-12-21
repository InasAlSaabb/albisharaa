import 'package:albisharaa/core/data/models/apis/list_asfar_model.dart';
import 'package:albisharaa/ui/shared/utils.dart';
import 'package:albisharaa/ui/views/search_view/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ArabicSearchView extends StatefulWidget {
  final List<asfarListModel> sss;
  const ArabicSearchView({super.key, required this.sss});
  @override
  State<ArabicSearchView> createState() => _ArabicSearchViewState();
}

class _ArabicSearchViewState extends State<ArabicSearchView> {
  SearchControllerr controller = Get.put(SearchControllerr());
  final searchText = ''.obs;
  final selectedSefr = Rxn<asfarListModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFFEEBD1),
        child: Column(
          children: [
            _buildHeader(),
            _buildBookSelection(),
            _buildSearchSection(),
            _buildSearchResults(),
            _buildSearchButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: Color(0xFF8B4513),
      padding: EdgeInsets.symmetric(vertical: 16),
      width: double.infinity,
      child: Text(
        'البحث في الترجمة المشتركة',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.rtl,
      ),
    );
  }

  Widget _buildBookSelection() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: screenHieght(20)),
          Text(
            'اختر سفر:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: screenHieght(30),
              color: Color(0xFF8B4513),
            ),
            textDirection: TextDirection.rtl,
          ),
          Container(
            width: double.infinity,
            child: Obx(() {
              final List<DropdownMenuItem<asfarListModel>> dropdownItems = [
                DropdownMenuItem<asfarListModel>(
                  value: asfarListModel(id: -3, name: "اختر "),
                  child: Text(
                    "اختر ",
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                  ),
                ),
                DropdownMenuItem<asfarListModel>(
                  value: asfarListModel(id: 0, name: "الترجمة كاملة"),
                  child: Text(
                    "الترجمة كاملة",
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                  ),
                ),
                DropdownMenuItem<asfarListModel>(
                  value: asfarListModel(id: -1, name: "العهد القديم"),
                  child: Text(
                    "العهد القديم",
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                  ),
                ),
                DropdownMenuItem<asfarListModel>(
                  value: asfarListModel(id: -2, name: "العهد الجديد"),
                  child: Text(
                    "العهد الجديد",
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                  ),
                ),
                ...widget.sss.map((sefr) {
                  return DropdownMenuItem<asfarListModel>(
                    value: sefr,
                    child: Text(
                      sefr.name ?? "",
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                    ),
                  );
                }).toList(),
              ];

              return DropdownButtonHideUnderline(
                child: DropdownButton<asfarListModel>(
                  value: dropdownItems
                      .firstWhere(
                        (item) => item.value?.id == selectedSefr.value?.id,
                        orElse: () => dropdownItems.first,
                      )
                      .value,
                  isExpanded: true,
                  items: dropdownItems,
                  onChanged: (value) {
                    selectedSefr.value = value;
                    if (searchText.value.isNotEmpty) {
                      if (value?.id == 0) {
                        controller.searchALLVerses(searchText.value);
                      } else if (value?.id == -1) {
                        controller.searchOldTestament(searchText.value);
                      } else if (value?.id == -2) {
                        controller.searchNewTestament(searchText.value);
                      } else {
                        controller.searchVerses(searchText.value, value!.id!);
                      }
                    }
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          labelText: 'الكلمة',
          hintText: 'ابحث عن آية...',
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF8B4513)),
          ),
        ),
        onChanged: (value) {
          searchText.value = value;
          if (searchText.value.isNotEmpty) {
            if (selectedSefr.value?.id == 0) {
              controller.searchALLVerses(searchText.value);
            } else if (selectedSefr.value?.id == -1) {
              controller.searchOldTestament(searchText.value);
            } else if (selectedSefr.value?.id == -2) {
              controller.searchNewTestament(searchText.value);
            } else {
              controller.searchVerses(
                  searchText.value, selectedSefr.value!.id!);
            }
          }
        },
      ),
    );
  }

  Widget _buildSearchResults() {
    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: Obx(() => Text(
                  'عدد النتائج: ${controller.searchResults.length}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF8B4513),
                  ),
                  textDirection: TextDirection.rtl,
                )),
          ),
          Expanded(
            child: Obx(() => ListView.builder(
                  itemCount: controller.searchResults.length,
                  itemBuilder: (context, index) {
                    final verse = controller.searchResults[index];
                    return ListTile(
                      title: Text(
                        verse.textch ?? "",
                        textDirection: TextDirection.rtl,
                      ),
                      subtitle: Text(
                        '${verse.chnr}:${verse.vnumber}',
                        textDirection: TextDirection.rtl,
                      ),
                    );
                  },
                )),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchButton() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: ElevatedButton(
        onPressed: () {
          if (selectedSefr.value != null && searchText.value.isNotEmpty) {
            switch (selectedSefr.value!.id) {
              case 0: // الترجمة كاملة
                controller.searchALLVerses(searchText.value);
                break;
              case -1: // العهد القديم
                controller.searchOldTestament(searchText.value);
                break;
              case -2: // العهد الجديد
                controller.searchNewTestament(searchText.value);
                break;
              default: // سفر محدد
                controller.searchVerses(
                    searchText.value, selectedSefr.value!.id!);
            }
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF8B4513),
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        ),
        child: Text(
          'ابحث',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}
