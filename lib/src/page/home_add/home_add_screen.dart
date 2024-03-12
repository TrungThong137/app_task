import 'package:app_task/src/configs/constants/constants.dart';
import 'package:app_task/src/configs/widget/loading/loading_diaglog.dart';
import 'package:app_task/src/resource/firebase/firebase_todo.dart';
import 'package:app_task/src/resource/model/todo_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../configs/widget/button/button.dart';
import '../../configs/widget/calendar/build_calendar.dart';
import '../../configs/widget/text/paragraph.dart';

class HomeAddScreen extends StatefulWidget {
  const HomeAddScreen({super.key});

  @override
  State<HomeAddScreen> createState() => _HomeAddScreenState();
}

class _HomeAddScreenState extends State<HomeAddScreen> {
  late TextEditingController titleController;
  late DateTime dateTime;

  bool isEnableButton = false;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    dateTime = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.BLACK_200.withOpacity(0.8),
        body: SingleChildScrollView(
          child: Column(
            children: [
              buildHeader(),
              buildCardCalendar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHeader() {
    return Container(
      height: 70,
      color: AppColors.COLOR_WHITE,
      alignment: Alignment.bottomCenter,
      padding: EdgeInsets.symmetric(vertical: SizeToPadding.sizeMedium),
      child: Paragraph(
        content: 'New Item',
        style: STYLE_LARGE_BIG.copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget buildFieldTitleCard() {
    return TextFormField(
      controller: titleController,
      decoration: const InputDecoration(
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.BLACK_200)),
        hintText: 'Title',
      ),
      onChanged: (value) => onEnableButton(value),
    );
  }

  Widget buildCalendar() {
    return BuildCalendar(
      dateTime: dateTime,
      onSelectDate: (date) => setState(() {
        dateTime = date;
      }),
    );
  }

  Widget buildButtonCard() {
    return Padding(
      padding: EdgeInsets.only(right: SizeToPadding.sizeMedium),
      child: AppButton(
        enableButton: isEnableButton,
        content: 'Save',
        onTap: () => onSave(),
      ),
    );
  }

  Widget buildCardCalendar() {
    return Container(
      margin: EdgeInsets.only(
        left: SizeToPadding.sizeSmall,
        right: SizeToPadding.sizeSmall,
        top: SizeToPadding.sizeMedium,
      ),
      padding: EdgeInsets.only(
        left: SizeToPadding.sizeMedium,
        bottom: SizeToPadding.sizeVeryBig,
      ),
      decoration: BoxDecoration(
        color: AppColors.COLOR_WHITE,
        borderRadius:
            BorderRadius.all(Radius.circular(BorderRadiusSize.sizeMedium)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildFieldTitleCard(),
          buildCalendar(),
          buildButtonCard(),
        ],
      ),
    );
  }

  void onSave() {
    LoadingDialog.showLoadingDialog(context);
    FireStoreTodo.createTodoFirebase(ToDoModel(
      dateTime: dateTime.toString(),
      idUser: FirebaseAuth.instance.currentUser?.uid,
      title: titleController.text.trim(),
    )).then((value) {
      LoadingDialog.hideLoadingDialog(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Paragraph(
        content: 'Add Success',
      )));
      Navigator.pop(context);
    }).catchError((onError) {
      LoadingDialog.hideLoadingDialog(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Paragraph(
        content: '$onError',
      )));
    });
  }

  void onEnableButton(String value) {
    if (value.isEmpty || value == '') {
      isEnableButton = false;
    } else {
      isEnableButton = true;
    }
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    // timer?.cancel();
    titleController.dispose();
  }
}
