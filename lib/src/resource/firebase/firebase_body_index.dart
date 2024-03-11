
import 'package:app_task/src/resource/model/body_index_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class FireStoreBodyIndex {
  static Future<void> createBodyIndex(BodyIndex bodyIndex) async {
    final doc = FirebaseFirestore.instance.collection('bodyIndex').doc(bodyIndex.idUser);
    await doc.set({
      'idUser': bodyIndex.idUser,
      'height': bodyIndex.height,
      'weight': bodyIndex.weight,
    });
  }

  static Future<void> removeBodyIndex(String id) async{
    final bodyIndex= FirebaseFirestore.instance.collection('bodyIndex');
    await bodyIndex.doc(id).delete();
  }

  static Future<void> updateBodyIndex(BodyIndex bodyIndex)async{
     await FirebaseFirestore.instance.collection('bodyIndex')
        .doc(bodyIndex.idUser)
        .update(
          bodyIndex.toJson()
        );
  }
}
