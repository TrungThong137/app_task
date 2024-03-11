// ignore_for_file: deprecated_member_use

import 'package:app_task/src/configs/widget/button/button.dart';
import 'package:app_task/src/page/login/login.dart';
import 'package:app_task/src/resource/firebase/authentication_server.dart';
import 'package:app_task/src/utils/app_valid.dart';
import 'package:flutter/material.dart';

import '../../configs/constants/constants.dart';
import '../../configs/widget/diaglog/dialog.dart';
import '../../configs/widget/form_field/app_form_field.dart';
import '../../configs/widget/loading/loading_diaglog.dart';
import '../../configs/widget/text/paragraph.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController mailController;
  late TextEditingController passController;
  late TextEditingController cnfPassController;
  late TextEditingController fullNameController;

  bool isEnableButton = false;

  String? messagePass;
  String? messageMail;
  String? messageCnfPass;
  String? messageFullName;

  @override
  void initState() {
    super.initState();
    fullNameController = TextEditingController();
    cnfPassController = TextEditingController();
    mailController = TextEditingController();
    passController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showExitPopup(context),
      child: SafeArea(
        top: true,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor:  AppColors.COLOR_PINK_200,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 20, horizontal: SpaceBox.sizeMedium),
                  child: Column(
                    children: [
                      buildRegister(),
                      buildFieldMail(),
                      buildFieldFullName(),
                      buildFieldPass(),
                      buildFieldPassConfirm(),
                      buildRegisterButton(),
                      buildSignUpWidget(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildRegister() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: Paragraph(
        content: 'Sign Up',
        style: STYLE_BIG.copyWith(fontWeight: FontWeight.w600, fontSize: 25),
      ),
    );
  }

  Widget buildFieldMail() {
    return AppFormField(
      labelText: 'Email',
      hintText: 'Enter email',
      textEditingController: mailController,
      onChanged: (value) {
        validMail(value);
        onEnableRegister();
      },
      validator: messageMail ?? '',
    );
  }

  Widget buildFieldFullName() {
    return AppFormField(
      labelText: 'name',
      hintText: 'Enter name',
      textEditingController: fullNameController,
      onChanged: (value) {
        validName(value);
        onEnableRegister();
      },
      validator: messageFullName ?? '',
    );
  }

  Widget buildFieldPass() {
    return AppFormField(
      labelText: 'Password',
      hintText: 'Enter password',
      textEditingController: passController,
      obscureText: true,
      onChanged: (value) {
        validPass(value, cnfPassController.text);
        onEnableRegister();
      },
      validator: messagePass ?? '',
    );
  }

  Widget buildFieldPassConfirm() {
    return AppFormField(
      labelText: 'Confirm password',
      hintText: 'Confirm password',
      textEditingController: cnfPassController,
      obscureText: true,
      onChanged: (value) {
        validConfirmPass(passController.text, value);
        onEnableRegister();
      },
      validator: messageCnfPass ?? '',
    );
  }

  Widget buildRegisterButton() {
    return AppButton(
      content: 'Sign Up',
      enableButton: isEnableButton,
      onTap: () => onRegister(),
    );
  }

  Widget buildSignUpWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Paragraph(
          content: 'Do you already have an account? ',
          style: STYLE_SMALL_BOLD.copyWith(
            color: AppColors.BLACK_500,
          ),
        ),
        TextButton(
          onPressed: () => goToLogin(),
          child: Paragraph(
            content: 'Sign in',
            style: STYLE_SMALL_BOLD.copyWith(
                color:  AppColors.COLOR_PINK_200,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  void goToLogin() async {
    await Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ));
  }

  void onRegister() {
    LoadingDialog.showLoadingDialog(context);
    Authentication().signUp(
        mailController.text.toString().trim(),
        passController.text.toString().trim(),
        fullNameController.text.toString().trim(), () {
      LoadingDialog.hideLoadingDialog(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Registered successfully"),
      ));
      goToLogin();
    }, (msg) {
      LoadingDialog.hideLoadingDialog(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(msg),
      ));
    });
  }

  void validMail(String? value) {
    final result = AppValid.validateEmail(value);
    if (result != null) {
      messageMail = result;
    } else {
      messageMail = null;
    }
    setState(() {});
  }

  void validName(String? value) {
    final result = AppValid.validateName(value);
    if (result != null) {
      messageFullName = result;
    } else {
      messageFullName = null;
    }
    setState(() {});
  }

  void validPass(String? value, String? confirmPass) {
    final result = AppValid.validPassword(value);
    if (result != null) {
      messagePass = result;
    } else {
      messagePass = null;
    }
    if (confirmPass!.isNotEmpty) {
      final result = AppValid.validatePasswordConfirm(value!, confirmPass);
      if (result != null) {
        messageCnfPass = result;
      } else {
        messageCnfPass = null;
      }
    }
    setState(() {});
    ();
  }

  void validConfirmPass(String? confirmPass, String? pass) {
    final result = AppValid.validatePasswordConfirm(pass!, confirmPass);
    if (result != null) {
      messageCnfPass = result;
    } else {
      messageCnfPass = null;
    }
    setState(() {});
    ();
  }

  void onEnableRegister() {
    if (messagePass == null &&
        messageMail == null &&
        messageCnfPass == null &&
        messageFullName == null &&
        fullNameController.text.isNotEmpty &&
        cnfPassController.text.isNotEmpty &&
        mailController.text.isNotEmpty &&
        passController.text.isNotEmpty) {
      isEnableButton = true;
    } else {
      isEnableButton = false;
    }
    setState(() {});
    ();
  }

  @override
  void dispose() {
    mailController.dispose();
    passController.dispose();
    fullNameController.dispose();
    cnfPassController.dispose();
    super.dispose();
  }
}
