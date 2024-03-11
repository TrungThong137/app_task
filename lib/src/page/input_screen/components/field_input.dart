import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../configs/constants/constants.dart';
import '../../../configs/widget/text/paragraph.dart';

class FieldInputWidget extends StatelessWidget {
  const FieldInputWidget({super.key, 
    required this.title, 
    this.suffixField, 
    this.controller,
    this.widget,
    this.widthField,
    this.maxLines,
    this.keyboardTypeIsText=false,
    this.onChanged,
  });

  final String title;
  final String? suffixField;
  final TextEditingController? controller;
  final Widget? widget;
  final double? widthField;
  final int? maxLines;
  final bool keyboardTypeIsText; 
  final Function(String value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: SizeToPadding.sizeMedium,
        left: SizeToPadding.sizeMedium,
        bottom: SizeToPadding.sizeMedium),
      decoration: const BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(color: AppColors.BLACK_200)
        )
      ),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Paragraph(
              content: '$title: ',
              style: STYLE_MEDIUM.copyWith(
                fontWeight: FontWeight.w600
              ),
            ),
          ),
          widget ?? Container(
            width: widthField?? 200,
            alignment: Alignment.center,
            child: TextFormField(
              maxLines: maxLines?? 1,
              controller: controller,
              keyboardType: keyboardTypeIsText? TextInputType.text: TextInputType.number,
              onChanged: (value) => onChanged!(value),
              decoration:  InputDecoration(
                hintText: 'Enter value',
                contentPadding: EdgeInsets.symmetric(
                  vertical: SizeToPadding.sizeVeryVerySmall,
                  horizontal: SizeToPadding.sizeMedium,
                ),
                border: const OutlineInputBorder(),
              ),
            ),
          ),
          Visibility(
            visible: suffixField!=null?true:false,
            child: Paragraph(
              content: '  $suffixField',
              style: STYLE_MEDIUM.copyWith(
                fontWeight: FontWeight.w600
              ),
            ),
          ),
        ],
      ),
    );
  }
}