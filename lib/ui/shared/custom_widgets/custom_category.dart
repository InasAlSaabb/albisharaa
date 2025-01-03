import 'package:albisharaa/main.dart';
import 'package:albisharaa/ui/shared/colors.dart';
import 'package:albisharaa/ui/shared/custom_widgets/custom_text.dart';
import 'package:albisharaa/ui/shared/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomCategory extends StatelessWidget {
  const CustomCategory({
    super.key,
    required this.imageUrl,
    required this.text,
  });
  final String imageUrl;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: screenWidth(4),
            height: screenWidth(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                placeholder: (context, url) => SizedBox(
                  width: screenWidth(10),
                  height: screenWidth(10),
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ),
          (screenHieght(100)).ph,
          CustomText(
            textAlign: TextAlign.start,
            text: text,
            textColor: AppColors.mainGrey,
          ),
        ],
      ),
    );
  }
}
