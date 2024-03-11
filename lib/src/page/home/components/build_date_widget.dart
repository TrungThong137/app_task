import 'package:flutter/material.dart';

import '../../../configs/constants/constants.dart';
import '../../../configs/widget/text/paragraph.dart';

class BuildDateWidget extends StatefulWidget {
  const BuildDateWidget({
    super.key,
    this.month,
    this.subMonth,
    this.addMonth,
  });

  final String? month;
  final Function()? subMonth;
  final Function()? addMonth;

  @override
  State<BuildDateWidget> createState() => _BuildDateWidgetState();
}

class _BuildDateWidgetState extends State<BuildDateWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: SizeToPadding.sizeMedium,
        horizontal: SizeToPadding.sizeSmall,
      ),
      height: 100,
      width: double.maxFinite,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.COLOR_WHITE,
        borderRadius: BorderRadius.all(
          Radius.circular(BorderRadiusSize.sizeMedium),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: SpaceBox.sizeMedium,
            color: AppColors.BLACK_300,
          ),
        ],
      ),
      child: Center(
        child: Row(
          children: [
            IconButton(
              onPressed: () => widget.subMonth!(),
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.COLOR_PINK_200,
                size: 40,
              ),
            ),
            buildMonth(context),
            IconButton(
              onPressed: () => widget.addMonth!(),
              alignment: Alignment.topLeft,
              icon: const Icon(
                Icons.arrow_forward_ios_sharp,
                color: AppColors.COLOR_PINK_200,
                size: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMonth(BuildContext context) {
    final monthOfYear =
        int.parse(widget.month?.split('/')[0] ?? '${DateTime.now().month}');
    final year =
        int.parse(widget.month?.split('/')[1] ?? '${DateTime.now().year}');
    final lastDay = DateTime(year, monthOfYear + 1, 0).day;
    return Container(
      margin: EdgeInsets.only(
        top: SizeToPadding.sizeVerySmall,
        bottom: SizeToPadding.sizeVerySmall,
      ),
      alignment: Alignment.center,
      height: MediaQuery.sizeOf(context).height,
      width: MediaQuery.sizeOf(context).width - 150,
      decoration: BoxDecoration(
        color: AppColors.COLOR_PINK_200,
        borderRadius: BorderRadius.all(
          Radius.circular(BorderRadiusSize.sizeMedium),
        ),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Paragraph(
              content: widget.month ?? '',
              style: STYLE_LARGE.copyWith(
                  fontWeight: FontWeight.w700, color: AppColors.COLOR_WHITE),
            ),
            Paragraph(
              content: '(01/$monthOfYear - $lastDay/$monthOfYear)',
              style: STYLE_SMALL.copyWith(
                  fontWeight: FontWeight.w500, color: AppColors.COLOR_WHITE),
            ),
          ],
        ),
      ),
    );
  }
}
