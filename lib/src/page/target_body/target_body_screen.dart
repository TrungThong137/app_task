// ignore_for_file: deprecated_member_use

import 'package:app_task/src/configs/constants/constants.dart';
import 'package:app_task/src/configs/widget/button/button.dart';
import 'package:app_task/src/configs/widget/diaglog/dialog.dart';
import 'package:app_task/src/configs/widget/loading/loading_diaglog.dart';
import 'package:app_task/src/configs/widget/text/paragraph.dart';
import 'package:app_task/src/page/bottom_navigator/bottom_navigator_screen.dart';
import 'package:app_task/src/resource/firebase/firebase_body_index.dart';
import 'package:app_task/src/resource/model/model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/shared_preferences.dart';

class TargetBodyScreen extends StatefulWidget {
  const TargetBodyScreen({super.key});

  @override
  State<TargetBodyScreen> createState() => _TargetBodyScreenState();
}

class _TargetBodyScreenState extends State<TargetBodyScreen> {

  List<String>? listSelectItem;

  int selectItem=0;

  late TextEditingController heightController;
  late TextEditingController weightController;

  bool isEnableButton=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listSelectItem = ['Cm','Kg',];
    heightController=TextEditingController();
    weightController=TextEditingController();
    moveCursorToMiddle(heightController);
    moveCursorToMiddle(weightController);
  }

  void moveCursorToMiddle(TextEditingController _controller) {
    heightController.selection = TextSelection.fromPosition(
      TextPosition(offset: _controller.text.length ~/ 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showExitPopup(context),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Paragraph(
            content: 'Hãy nhập chỉ số cơ thể của bạn',
            style: STYLE_BIG.copyWith(
              fontWeight: FontWeight.w600
            ),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 200),
            child: Column(
              children: [
                buildFieldHeight(),
                buildFieldWeight(),
                buildButtonToggle(),
                buildButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildFieldHeight(){
    return Visibility(
      visible: selectItem==0?true:false,
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width/2,
        child: TextFormField(
          style: const TextStyle(fontSize: 30),
          keyboardType: TextInputType.number,
          controller: heightController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
          onChanged: (value) => enableButton(),
        ),
      ),
    );
  }

  Widget buildFieldWeight(){
    return Visibility(
      visible: selectItem==1?true:false,
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width/2,
        child: TextFormField(
          controller: weightController,
          style: const TextStyle(fontSize: 30),
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
          onChanged: (value) => enableButton(),
        ),
      ),
    );
  }

  Widget buildButtonToggle(){
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: CupertinoSlidingSegmentedControl(
        groupValue: selectItem,
        onValueChanged: (value) {
          selectItem= value??0;
          setState(() {});
        },
        thumbColor: AppColors.COLOR_GREY_BLUE.withOpacity(0.7),
        children: {
          for (int i = 0; i < (listSelectItem?.length??0); i++)
            i: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30, vertical: 10),
              child: Paragraph(
                content: listSelectItem?[i]??'',
                style: STYLE_MEDIUM.copyWith(
                  fontWeight: FontWeight.w600,
                  color: selectItem == i
                      ? AppColors.COLOR_WHITE
                      : AppColors.BLACK_500,
                ),
              ),
            ),
        }, 
      ),
    );
  }

  Widget buildButton(){
    return Padding(
      padding: EdgeInsets.all(SizeToPadding.sizeVeryBig),
      child: AppButton(
        enableButton: isEnableButton,
        content: 'Tiếp',
        onTap: ()async{
          final id = await AppPref.getDataUSer('id');
          await onButton();
          await AppPref.setPage('$id', false);
          await goToHome();
        },
      ),
    );
  }

  Future<void> onButton() async{
    LoadingDialog.showLoadingDialog(context);
    await FireStoreBodyIndex.createBodyIndex(
      BodyIndex(
        idUser: FirebaseAuth.instance.currentUser?.uid,
        height: double.parse(heightController.text.trim()),
        weight: double.parse( weightController.text.trim()),
      )
    ).then((value) => LoadingDialog.hideLoadingDialog(context));
  }

  Future<void> goToHome() async{
    await Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) => const BottomNavigationBarScreen(),));
  }

  void enableButton(){
    if(heightController.text.isNotEmpty && weightController.text.isNotEmpty){
      isEnableButton=true;
    }else{
      isEnableButton=false;
    }
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    heightController.dispose();
    weightController.dispose();
    super.dispose();
  }
}