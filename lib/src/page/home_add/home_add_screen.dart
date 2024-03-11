import 'package:app_task/src/configs/constants/constants.dart';
import 'package:flutter/material.dart';

import '../../configs/widget/button/button.dart';
import '../../configs/widget/text/paragraph.dart';

class HomeAddScreen extends StatefulWidget {
  const HomeAddScreen({super.key});

  @override
  State<HomeAddScreen> createState() => _HomeAddScreenState();
}

class _HomeAddScreenState extends State<HomeAddScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.BLACK_200,
        body: Column(
          children: [
            buildHeader(),
            buildCalendar(),
          ],
        ),
      ),
    );
  }

  Widget buildHeader(){
    return Container(
      height: 100,
      color: AppColors.COLOR_WHITE,
      alignment: Alignment.bottomCenter,
      padding: EdgeInsets.symmetric(vertical: SizeToPadding.sizeMedium),
      child: Paragraph(
        content: 'New Item',
        style: STYLE_LARGE_BIG.copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget buildTitleCalendar(){
    return Paragraph(
      content: 'Title',
      style: STYLE_SMALL.copyWith(color: AppColors.BLACK_300),
    );
  }

  Widget buildBodyCalendar(){
    return Column(
      children: [
        
      ],
    );
  }

  Widget buildButtonCalendar(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeToPadding.sizeMedium),
      child: AppButton(
        enableButton: true,
        content: 'Save',
        onTap: (){},
      ),
    );
  }

  Widget buildCalendar(){
    return Container(
      margin: EdgeInsets.only(
        left: SizeToPadding.sizeSmall,
        right: SizeToPadding.sizeSmall,
        top: SizeToPadding.sizeMedium,
      ),
      padding: EdgeInsets.only(left: SizeToPadding.sizeMedium,
        bottom: SizeToPadding.sizeVeryBig,
        top: SizeToPadding.sizeMedium,),
      decoration: BoxDecoration(
        color: AppColors.COLOR_WHITE,
        borderRadius: BorderRadius.all(Radius.circular(BorderRadiusSize.sizeMedium)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildTitleCalendar(),
          const Divider(color: AppColors.BLACK_200,),
          buildBodyCalendar(),
          buildButtonCalendar(),
        ],
      ),
    );
  }
}