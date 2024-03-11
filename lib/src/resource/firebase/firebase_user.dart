
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/user_model.dart';

class FireStoreUser {
  static Future<bool> createUser(Users user) async {
    if(user.emailAddress!.isEmpty || user.fullName!.isEmpty){
        return false;
    }else {
      final doc = FirebaseFirestore.instance.collection('user_appTask').doc(user.idUser);
      await doc.set({
        'idUser': user.idUser,
        'fullName': user.fullName,
        'emailAddress': user.emailAddress,
      });
      return true;
    } 
  }

  static Future<void> removeUser(String id) async{
    final user= FirebaseFirestore.instance.collection('user_appTask');
    await user.doc(id).delete();
  }

  static Future<void> updateUser(Users user)async{
     await FirebaseFirestore.instance.collection('user_appTask')
        .doc(user.idUser)
        .update(
          user.toJson()
        );
  }
}
