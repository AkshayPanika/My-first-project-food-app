import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import '../../reusable_widget/text_styles.dart';

class ReadMoreTextWidget extends StatelessWidget {
  const ReadMoreTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      "Eating a healthy diet that includes lots of fruit, vegetables, whole grains and a moderate amount of unsaturated fats, meat and dairy can help you maintain a steady weight Eating a healthy diet that includes lots of fruit, vegetables, whole grains and a moderate amount of unsaturated fats, meat and dairy can help you maintain a steady weight",
      style:titleText,
      trimLines:4,
      colorClickableText: Colors.black87,
      trimMode: TrimMode.Line,
      trimCollapsedText: 'more',
      trimExpandedText: ' less',
      moreStyle:const TextStyle(fontSize:16,color: Colors.red),
      lessStyle:const TextStyle(fontSize:16,color: Colors.red),
    );
  }
}
