// import 'dart:async';

// import 'package:app_task/src/configs/constants/constants.dart';
// import 'package:app_task/src/configs/widget/button/button.dart';
// import 'package:app_task/src/configs/widget/loading/loading_diaglog.dart';
// import 'package:app_task/src/configs/widget/text/paragraph.dart';
// import 'package:app_task/src/page/input_screen/components/build_month.dart';
// import 'package:app_task/src/page/input_screen/components/field_input.dart';
// import 'package:app_task/src/resource/firebase/firebase_input_screen.dart';
// import 'package:app_task/src/resource/model/input_screen_model.dart';
// import 'package:app_task/src/resource/model/stamp_icon_model.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class InputScreen extends StatefulWidget {
//   const InputScreen({super.key});

//   @override
//   State<InputScreen> createState() => _InputScreenState();
// }

// class _InputScreenState extends State<InputScreen> {
//   int month = DateTime.now().month;
//   int year = DateTime.now().year;
//   DateTime dateTime = DateTime.now();
//   int idIconStamp = 0;

//   late TextEditingController weightController;
//   late TextEditingController bodyFatController;
//   late TextEditingController noteController;

//   bool isEnableButton = false;

//   Timer? timer;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     bodyFatController = TextEditingController();
//     noteController = TextEditingController();
//     weightController = TextEditingController();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           toolbarHeight: 50,
//           // actions: [
//           //   buildButtonHeader(),
//           // ],
//           centerTitle: true,
//           title: Paragraph(
//             content: 'Input',
//             style: STYLE_LARGE_BIG.copyWith(fontWeight: FontWeight.w600),
//           ),
//         ),
//         body: SingleChildScrollView(
//           child: SizedBox(
//             height: MediaQuery.sizeOf(context).height - 150,
//             width: double.maxFinite,
//             child: Column(
//               children: [
//                 const Divider(
//                   color: AppColors.BLACK_200,
//                 ),
//                 buildDate(),
//                 buildFieldWeight(),
//                 buildFieldBodyFat(),
//                 buildStamp(),
//                 buildFieldNote(),
//                 const Expanded(child: SizedBox()),
//                 buildButton(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildButtonHeader() {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: SizeToPadding.sizeMedium),
//       child: Container(
//         height: 25,
//         width: 25,
//         decoration: BoxDecoration(
//             border: Border.all(color: AppColors.BLACK_400),
//             borderRadius: BorderRadius.circular(BorderRadiusSize.sizeBig)),
//         child: const CircleAvatar(
//           backgroundColor: AppColors.COLOR_WHITE,
//           radius: 15,
//           child: Icon(
//             Icons.more_horiz,
//             size: 20,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildDate() {
//     return BuildMonth(
//       context: context,
//       month: month,
//       year: year,
//       dateTime: dateTime,
//       addMonth: () => addMonth(),
//       subMonth: () => subMonth(),
//       updateDateTime: (value) => updateDateTime(value),
//     );
//   }

//   Widget buildFieldWeight() {
//     return FieldInputWidget(
//       title: 'Weight',
//       suffixField: 'Kg',
//       controller: weightController,
//       onChanged: (value) => onEnableButton(),
//     );
//   }

//   Widget buildFieldBodyFat() {
//     return FieldInputWidget(
//       title: 'Body Fat',
//       suffixField: '%',
//       controller: bodyFatController,
//       onChanged: (value) => onEnableButton(),
//     );
//   }

//   Widget buildStamp() {
//     return FieldInputWidget(
//       title: 'Stamp',
//       widget: Row(
//         children: List.generate(
//           listStampIcon.length,
//           (index) => Padding(
//             padding: EdgeInsets.only(right: SizeToPadding.sizeSmall),
//             child: InkWell(
//               onTap: () {
//                 idIconStamp = listStampIcon[index].id ?? 0;
//                 setState(() {});
//               },
//               child: SvgPicture.asset(
//                 listStampIcon[index].src ?? '',
//                 color: idIconStamp == listStampIcon[index].id
//                     ? AppColors.COLOR_PINK
//                     : null,
//                 height: 25,
//               ),
//             ),
//           )
//         ),
//       ),
//     );
//   }

//   Widget buildFieldNote() {
//     return FieldInputWidget(
//       title: 'Note',
//       controller: noteController,
//       widthField: MediaQuery.sizeOf(context).width - 140,
//       keyboardTypeIsText: true,
//       maxLines: 3,
//       onChanged: (value) => onEnableButton(),
//     );
//   }

//   Widget buildButton() {
//     return Padding(
//       padding: EdgeInsets.all(SizeToPadding.sizeLarge),
//       child: AppButton(
//         enableButton: isEnableButton,
//         onTap: () {
//           onButton();
//         },
//         content: 'Confirm',
//       ),
//     );
//   }

//   Future<void> subMonth() async {
//     if (timer?.isActive ?? false) {
//       timer?.cancel();
//     }
//     timer = Timer(const Duration(milliseconds: 500), () async {
//       if (month > 1) {
//         month--;
//       } else {
//         month = 12;
//         year--;
//       }
//       dateTime = DateTime(year, month, 1);
//     });
//     setState(() {});
//   }

//   Future<void> addMonth() async {
//     if (timer?.isActive ?? false) {
//       timer?.cancel();
//     }
//     timer = Timer(const Duration(milliseconds: 500), () async {
//       if (month < 12) {
//         month++;
//       } else {
//         month = 1;
//         year++;
//       }
//       dateTime = DateTime(year, month, 1);
//     });
//     setState(() {});
//   }

//   Future<void> updateDateTime(DateTime date) async {
//     dateTime = date;
//     month = date.month;
//     year = date.year;
//     setState(() {});
//     ();
//   }

//   void onEnableButton() {
//     if (weightController.text.trim().isNotEmpty &&
//         bodyFatController.text.trim().isNotEmpty) {
//       isEnableButton = true;
//     } else {
//       isEnableButton = false;
//     }
//     setState(() {});
//   }

//   void onButton() {
//     LoadingDialog.showLoadingDialog(context);
//     FireStoreInputScreen.createInputScreenFirebase(InputScreenModel(
//             idUser: FirebaseAuth.instance.currentUser?.uid,
//             bodyFat: double.parse(bodyFatController.text.trim()),
//             note: noteController.text.trim(),
//             weight: double.parse(weightController.text.trim()),
//             idIconStamp: idIconStamp,
//             dateTime: '$dateTime'))
//         .then((value) {
//       LoadingDialog.hideLoadingDialog(context);
//       clearData();
//     }).catchError((onError) {
//       LoadingDialog.hideLoadingDialog(context);
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//         content: Text("Create failure"),
//       ));
//     });
//   }

//   void clearData() {
//     dateTime = DateTime.now();
//     weightController.text = '';
//     bodyFatController.text = '';
//     noteController.text = '';
//     idIconStamp = 0;
//     onEnableButton();
//     setState(() {});
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     noteController.dispose();
//     weightController.dispose();
//     bodyFatController.dispose();
//     super.dispose();
//   }
// }
