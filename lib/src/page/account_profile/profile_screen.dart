import 'package:app_task/src/configs/widget/diaglog/dialog.dart';
import 'package:app_task/src/page/login/login.dart';
import 'package:app_task/src/resource/firebase/authentication_server.dart';
import 'package:app_task/src/utils/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../configs/constants/constants.dart';
import '../../configs/widget/text/paragraph.dart';
import '../../resource/model/model.dart';
import '../bottom_navigator/bottom_navigator_screen.dart';

class ProfileAccountScreen extends StatefulWidget {
  const ProfileAccountScreen({super.key});

  @override
  State<ProfileAccountScreen> createState() => _ProfileAccountScreenState();
}

class _ProfileAccountScreenState extends State<ProfileAccountScreen> {

  Users? users;

  @override
  void initState() {
    super.initState();
    inforUser();
  }

  Future<void> inforUser() async {
    final docRef = FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.uid);
    final userSnap = await docRef.get();
    final pref = await SharedPreferences.getInstance();
    if (userSnap.exists && userSnap.data() != null) {
      final data = userSnap.data();
      await pref.setString('idUser', data!['idUser']);
      await pref.setString('fullName', data['fullName']);
      await pref.setString('emailAddress', data['emailAddress']);
    }
    users = Users(
      emailAddress: pref.getString('emailAddress'),
      fullName: pref.getString('fullName'),
      idUser: pref.getString('idUser')
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          headerProfileAccount(),
          buildBodyProfileAccount(),
        ],
      ),
    );
  }

  Widget headerProfileAccount(){
    return Container(
      // color: AppColors.COLOR_GREEN,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: SizeToPadding.sizeBig),
      child: Paragraph(
        content: 'My Account',
        style: STYLE_MEDIUM.copyWith(
          color: AppColors.BLACK_500,
          fontWeight: FontWeight.bold,
          fontSize: 20
        )
      ),
    );
  }

  Widget informationUser(){
    return Column(
      children: [
        Center(
          child: Paragraph(content: users?.fullName??'',
            style: STYLE_BIG.copyWith(
              fontWeight: FontWeight.w600
            ),
          ),
        ),
        Paragraph(content: users?.emailAddress??'',
          style: STYLE_BIG.copyWith(
            fontWeight: FontWeight.w600
          ),
        )
      ],
    );
  }

  Widget buildBodyProfileAccount() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: SpaceBox.sizeMedium, vertical: SpaceBox.sizeLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          informationUser(),
          SizedBox(height: SpaceBox.sizeBig,),
          // labelListItem(),
          // buildChangePassword(),
          buildHistoryDone(),
          buildDeletedAccount(),
          buildLogout()
        ],
      ),
    );
  }

  Widget labelListItem() {
    return const Paragraph(
      content: 'Bảng điều khiển',
      style: STYLE_SMALL_BOLD,
    );
  }

  Widget buildChangePassword() {
    return itemDashBoard(
      content: 'Đổi mật khẩu',
      icon: Icons.edit,
      ontap: () {
        // _viewModel!.onChangePassword(context, _viewModel!.users);
      },
    );
  }

  Widget buildHistoryDone() {
    return itemDashBoard(
      content: 'History',
      icon: Icons.history,
      ontap: () {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => const BottomNavigationBarScreen(page: 1,),));
          },
    );
  }

  Widget labelMyAccount() {
    return const Paragraph(
      content: 'Tài khoản của tôi',
      style: STYLE_SMALL_BOLD,
    );
  }

  Widget buildDeletedAccount() {
    return itemDashBoard(
      content: 'Delete account',
      icon: Icons.delete,
      isShowArrowForward: false,
      ontap: () async{
        await onDeleteAccount();
      }
    );
  }

  Widget buildLogout() {
    return itemDashBoard(
      content: 'Logout',
      icon: Icons.logout,
      isShowArrowForward: false,
      ontap: () async{
        await onLogout();
      }
    );
  }

  Widget itemDashBoard({String? content, IconData? icon, Function? ontap, 
    bool isShowArrowForward=true}){
    return Container(
      margin: EdgeInsets.only(top: BorderRadiusSize.sizeSmall),
      decoration: BoxDecoration(
        color: AppColors.BLACK_100,
        borderRadius: BorderRadius.circular(BorderRadiusSize.sizeBig),
      ),
      child: ListTile(
        onTap: (){
          if(ontap!=null){
            ontap();
          }
        },
        leading: Icon(icon),
        title: Paragraph(
          content: content,
          style: STYLE_MEDIUM_BOLD,
        ),
        trailing: Visibility(
          visible: isShowArrowForward,
          child: const Icon(Icons.arrow_forward_ios_rounded)),
      ),
    );
  }

  void goToLogin(){
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) => const LoginScreen(),));
  }

  Future<void> onDeleteAccount() async{
    showDialog(
      context: context, 
      barrierDismissible: false,
      builder: (context) => WarningDialog(
        title: 'Delete account',
        content: 'Do you want to delete your account?',
        leftButtonName: 'Cancel',
        rightButtonName: 'Confirm',
        onTapLeft: () => Navigator.pop(context),
        onTapRight: () {
          Navigator.of(context).pop();
          deletedLocal();
          goToLogin();
        },
      )
    );
  }

  Future<void> onLogout() async{
    showDialog(
      context: context, 
      barrierDismissible: false,
      builder: (context) => WarningDialog(
        title: 'Logout',
        content: 'Do you want to logout?',
        leftButtonName: 'Cancel',
        rightButtonName: 'Confirm',
        onTapLeft: () => Navigator.pop(context),
        onTapRight: () {
          Navigator.of(context).pop();
          logout();
          deleteToken();
          goToLogin();
        },
      )
    );
  }

  Future<void> deletedLocal() async {
    await Authentication().deleteAccountUSer();
    final pref = await SharedPreferences.getInstance();
    await pref.clear();
    setState(() {});
  }

  Future<void> deleteToken() async {
    AppPref.deleteToken();
    setState(() {});
  }

  Future<void> logout() async {
    await Authentication().signOut();
  }
}
