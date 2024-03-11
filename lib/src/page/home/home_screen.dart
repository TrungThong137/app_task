import 'package:app_task/src/configs/constants/app_space.dart';
import 'package:app_task/src/configs/constants/constants.dart';
import 'package:app_task/src/configs/widget/button/button.dart';
import 'package:app_task/src/configs/widget/text/paragraph.dart';
import 'package:app_task/src/page/home_add/home_add_screen.dart';
import 'package:app_task/src/utils/date_format_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool isCheckBox=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            buildButtonHeader(),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: SizeToPadding.sizeMedium),
            height: MediaQuery.sizeOf(context).height - 150,
            width: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildTitleToDo(),
                const Divider(color: AppColors.BLACK_200,),
                buildItemToDo(),
                const Expanded(child: SizedBox()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildButtonHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeToPadding.sizeMedium),
      child: InkWell(
        onTap: () {
          onAddToDo();
        },
        child: const Icon(
          Icons.add, 
          size: 30,
          color: AppColors.COLOR_PINK,
        ),
      )
    );
  }

  Widget buildTitleToDo(){
    return Paragraph(
      content: 'To Do List',
      style: STYLE_VERY_BIG.copyWith(
        fontWeight: FontWeight.w700
      ),
    );
  }

  Widget buildItemToDo(){
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.only(),
          title: Paragraph(
            content: 'Home',
            style: STYLE_MEDIUM.copyWith(fontWeight: FontWeight.w600),
          ),
          subtitle: Paragraph(
            content: AppDateUtils.formatDaTime(''),
            style: STYLE_SMALL.copyWith(fontWeight: FontWeight.w500,
              color: AppColors.BLACK_400
            ),
          ),
          trailing: Checkbox(
            checkColor: AppColors.COLOR_PINK,
            activeColor: AppColors.COLOR_WHITE,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            side: MaterialStateBorderSide.resolveWith(
              (states) => const BorderSide(
                width: 1.0,
                color: AppColors.COLOR_PINK
              ),
            ),
            value: isCheckBox, 
            onChanged: (value) {
              isCheckBox=value!;
              setState(() {});
            },
          ),
        ),
        const Divider(color: AppColors.BLACK_200,),
      ],
    );
  }

  void onAddToDo() {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => const HomeAddScreen(),));
    setState(() {});
  }
}
