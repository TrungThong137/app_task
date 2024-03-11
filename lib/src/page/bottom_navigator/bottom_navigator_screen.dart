// ignore_for_file: deprecated_member_use

import 'package:app_task/src/configs/constants/app_colors.dart';
import 'package:app_task/src/page/account_profile/profile_screen.dart';
import 'package:flutter/material.dart';

import '../../configs/widget/diaglog/dialog.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({super.key, this.page});

  final int? page;

  @override
  State<BottomNavigationBarScreen> createState() => _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {

  int selectedIndex=0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedIndex= widget.page??0;
  }


  @override
  Widget build(BuildContext context) {

    return buildScreen();
  }

  Widget buildScreen(){
    return WillPopScope(
      onWillPop: () => showExitPopup(context),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: getBody(),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          currentIndex: selectedIndex,
          selectedItemColor: AppColors.BLACK_500,
          selectedLabelStyle: const TextStyle(
            color: AppColors.BLACK_500,
            fontWeight: FontWeight.w600,
          ),
          selectedIconTheme: const IconThemeData(
            color: AppColors.BLACK_500,
            size: 25
          ),
          unselectedIconTheme: IconThemeData(
            color: Colors.grey.withOpacity(0.8),
            size: 20
          ),
          onTap: (index)=> changePage(index),
          items: const[
            BottomNavigationBarItem(
              icon: Icon(Icons.edit),
              label:"Input",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: "History",
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.notifications),
            //   label: "notification",
            // ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label:"Profile",
            ),
          ],
        ),
      ),
    );
  }

  Widget getBody()  {
    if(selectedIndex == 0) {
      return  Container();
    } else if(selectedIndex==1) {
      return Container();
    }else{
      return const ProfileAccountScreen();
    }
  }

  void changePage(int page){
    selectedIndex=page;
    setState(() {});();
  }
}