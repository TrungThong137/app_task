import 'dart:async';

import 'package:app_task/src/configs/constants/constants.dart';
import 'package:app_task/src/configs/widget/text/paragraph.dart';
import 'package:app_task/src/page/home_add/home_add_screen.dart';
import 'package:app_task/src/resource/firebase/firebase_todo.dart';
import 'package:app_task/src/resource/model/todo_model.dart';
import 'package:app_task/src/utils/date_format_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isCheckBox = false;

  List<ToDoModel> listTodo = [];

  Timer? timer;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      readDataTodoFirebase();
      timer = Timer.periodic(
          const Duration(seconds: 2), (Timer t) => setState(() {}));
    }
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  Future<void> readDataTodoFirebase() async {
    final idUser = FirebaseAuth.instance.currentUser?.uid;
    final data = await FirebaseFirestore.instance
        .collection('infoTodo_AppTask')
        .where('idUser', isEqualTo: idUser)
        .get();
    if (data.docs.isEmpty) {
      return;
    } else {
      FirebaseFirestore.instance
          .collection('infoTodo_AppTask')
          .where(
            'idUser',
            isEqualTo: idUser,
          )
          .where('isCheckBox', isEqualTo: false)
          .orderBy('dateTime', descending: false)
          .snapshots()
          .map((snapshots) => snapshots.docs.map((doc) {
                final data = doc.data();
                return ToDoModel.fromJson(data);
              }).toList())
          .listen((data) {
        listTodo = data;
        setState(() {});
      });
    }
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
                const Divider(
                  color: AppColors.BLACK_200,
                ),
                Visibility(
                  visible: listTodo.isNotEmpty ? true : false,
                  child: Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: listTodo.length,
                      itemBuilder: (context, index) => buildItemToDo(index),
                    ),
                  ),
                ),
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
          onTap: () async {
            await showModalBottomSheet(
                enableDrag: true,
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: (2 / 3) * MediaQuery.of(context).size.height,
                    ),
                    child: HomeAddScreen(),
                  );
                });
            await readDataTodoFirebase();
            setState(() {});
          },
          child: const Icon(
            Icons.add,
            size: 30,
            color: AppColors.COLOR_PINK,
          ),
        ));
  }

  Widget buildTitleToDo() {
    return Paragraph(
      content: 'Task',
      style: STYLE_VERY_BIG.copyWith(fontWeight: FontWeight.w700),
    );
  }

  void doNothing(BuildContext context, String id) async {
    await FireStoreTodo.removeTodoFirebase(id);
    setState(() {});
  }

  Widget buildItemToDo(int index) {
    return Slidable(
      key: const ValueKey(0),
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            // An action can be bigger than the others.
            flex: 2,
            onPressed: (_) {
              doNothing(context, listTodo[index].idTodo!);
            },
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          )
        ],
      ),
      child: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.only(),
            title: Paragraph(
              content: listTodo[index].title,
              style: STYLE_MEDIUM.copyWith(fontWeight: FontWeight.w600),
            ),
            subtitle: Paragraph(
              content: AppDateUtils.formatDaTime(listTodo[index].dateTime),
              style: STYLE_SMALL.copyWith(
                  fontWeight: FontWeight.w500, color: AppColors.BLACK_400),
            ),
            trailing: Checkbox(
              checkColor: AppColors.COLOR_PINK,
              activeColor: AppColors.COLOR_WHITE,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              side: MaterialStateBorderSide.resolveWith(
                (states) =>
                    const BorderSide(width: 1.0, color: AppColors.COLOR_PINK),
              ),
              value: listTodo[index].isCheckBox,
              onChanged: (value) async {
                FireStoreTodo.updateTodoFirebase(ToDoModel(
                  isCheckBox: value!,
                  idTodo: listTodo[index].idTodo,
                ));
                await readDataTodoFirebase();
              },
            ),
          ),
          const Divider(
            color: AppColors.BLACK_200,
          ),
        ],
      ),
    );
  }

  void onAddToDo() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeAddScreen(),
        ));
    setState(() {});
  }

  // @override
  // void dispose() {
  //   timer?.cancel();
  //   super.dispose();
  // }
}
