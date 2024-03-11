import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../configs/constants/constants.dart';
import '../../../configs/widget/button/button.dart';
import '../../../configs/widget/text/paragraph.dart';
import 'build_date_widget.dart';

class BuildMonth extends StatelessWidget {
  const BuildMonth({
    super.key, 
    required this.month, 
    required this.year, 
    required this.dateTime, 
    required this.context,
    this.addMonth, 
    this.subMonth, 
    this.updateDateTime, 
  });

  final int month;
  final int year;
  final BuildContext context;
  final DateTime dateTime;
  final Function()? addMonth;
  final Function()? subMonth;
  final Function(DateTime value)? updateDateTime;

   @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: showSelectTime,
      child: BuildDateWidget(
        
        month: '${dateTime.day}/$month/$year',
        addMonth: () => addMonth!(),
        subMonth: () => subMonth!(),
      ),
    );
  }

  Widget buildTitleSelectTime() {
    return Padding(
      padding: EdgeInsets.all(SizeToPadding.sizeMedium),
      child: Paragraph(
        content: 'Chọn tháng',
        style: STYLE_MEDIUM.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget buildTimeSelect() {
    return SizedBox(
      height: 180,
      child: CupertinoDatePicker(
        initialDateTime: dateTime,
        mode: CupertinoDatePickerMode.date,
        onDateTimeChanged: (value) {
          updateDateTime!(value);
        },
      ),
    );
  }

  Widget buildButtonSelectTime() {
    return Padding(
      padding: EdgeInsets.all(SizeToPadding.sizeMedium),
      child: AppButton(
        content: 'Xong',
        enableButton: true,
        onTap: () async {
          Navigator.pop(context);
        },
      ),
    );
  }

  dynamic showSelectTime() {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      builder: (context) => SizedBox(
        height: MediaQuery.of(context).size.height / 2.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildTitleSelectTime(),
            buildTimeSelect(),
            buildButtonSelectTime(),
          ],
        ),
      ),
    );
  }
}