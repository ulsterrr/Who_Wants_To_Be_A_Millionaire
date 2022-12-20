import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:who_wants_to_be_a_millionaire/Object/catebyuser_obj.dart';
import 'package:who_wants_to_be_a_millionaire/Object/category_obj.dart';
import 'package:who_wants_to_be_a_millionaire/Object/quiz_obj.dart';
import 'package:who_wants_to_be_a_millionaire/Object/quizbyuser_obj.dart';
import 'package:who_wants_to_be_a_millionaire/Provider/authentication.dart';

class FireStoreProvider {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Lấy danh sách lĩnh vực (thể loại)
  static Future<List<CategoryObject>> getLinhVuc() async {
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    List<CategoryObject> cate = [];

    var ref = _db.collection('Category');
    var snapshot = await ref.get();
    var data = snapshot.docs.map((s) => s.data());
    
    cate = data.map((d) => CategoryObject.fromJson(d)).toList();
    cate.shuffle();

    List<CategoryObject> subList = [];
    int startIndex = 0;
    int endIndex = 4;
    subList = cate.sublist(startIndex, endIndex);

    return subList;
  }

  // Lấy danh câu hỏi
  static Future<List<QuizObject>> getAllCauHoi() async {
    FirebaseFirestore _db = FirebaseFirestore.instance;
    List<QuizObject> quiz = [];
    var ref = _db.collection('Quiz');
    var snapshot = await ref.get();
    var data = snapshot.docs.map((s) => s.data());

    quiz = data.map((d) => QuizObject.fromJson(d)).toList();
    return quiz;
  }

  // Lấy danh câu hỏi theo lĩnh vực
  static Future<List<QuizObject>> getCauHoiLV(int categoryId) async {
    FirebaseFirestore _db = FirebaseFirestore.instance;
    List<QuizObject> quiz = [];
    var ref = _db.collection('Quiz');
    //var ref = _db.collection('Quiz').where('categoryId', isEqualTo: categoryId.toString()).orderBy('level', descending: false);
    var snapshot = await ref.get();
    var data = snapshot.docs.map((s) => s.data());

    quiz = data.map((d) => QuizObject.fromJson(d)).toList();
    quiz = quiz.where((element) => element.catetoryId == categoryId).toList();
    return quiz;
  }

  // Lấy 1 câu hỏi
  static Future<QuizObject> get1CauHoi(int quizId) async {
    FirebaseFirestore _db = FirebaseFirestore.instance;
    QuizObject quiz;
    
    var ref = _db.collection('Quiz').where('quizId', isEqualTo: quizId);
    var snapshot = await ref.get();
    var data = snapshot.docs.map((s) => s.data());

    quiz = data.map((d) => QuizObject.fromJson(d)).first;
    return quiz;
  }

  // Lấy thông tin trả lời của người chơi
  Stream<QuizbyUserObject> getUserQuiz() {
    return FirebaseAuthService().userStream.switchMap((user) {
      if (user != null) {
        var ref = _db.collection('QuizbyUser').doc(user.uid);
        return ref.snapshots().map((doc) => QuizbyUserObject.fromJson(doc.data()!));
      } else {
        return Stream.fromIterable([QuizbyUserObject()]);
      }
    });
  }

  // Cập nhật thông tin trả lời của người chơi
  Future<void> updateUserQuiz(QuizObject quiz, bool? isPass) {
    var user = FirebaseAuthService().user!;
    var ref = _db.collection('QuizbyUser').doc(user.uid);

    var data = {
      'id': FieldValue.increment(1),
      'userId': user.uid,
      'quizId': FieldValue.arrayUnion([quiz.id]),
      'quizChoice': FieldValue.arrayUnion([quiz.answer]),
      'countFailed': isPass == false ? FieldValue.increment(1) :  FieldValue.increment(0),
      'countSuccess': isPass == true ? FieldValue.increment(1) :  FieldValue.increment(0),
      'atTime': '60',
    };

    return ref.set(data, SetOptions(merge: true));
  }

  // Lấy thông tin trả lời của người chơi
  Stream<CatebyUserObject> getUserCategory() {
    return FirebaseAuthService().userStream.switchMap((user) {
      if (user != null) {
        var ref = _db.collection('CatebyUser').doc(user.uid);
        return ref.snapshots().map((doc) => CatebyUserObject.fromJson(doc.data()!));
      } else {
        return Stream.fromIterable([CatebyUserObject(0,0,0,false,0)]);
      }
    });
  }
  // Cập nhật thông tin lĩnh vực đã hoàn thành của người chơi
  Future<void> updateUserCategory(CatebyUserObject cate, bool? isPass) {
    var user = FirebaseAuthService().user!;
    var ref = _db.collection('CatebyUser').doc(user.uid);

    var data = {
      'id': FieldValue.increment(1),
      'userId': user.uid,
      'catetoryId': FieldValue.arrayUnion([cate.catetoryId]),
      'isPass': isPass ?? false,
      'passCount': isPass == true ? FieldValue.increment(1) : FieldValue.increment(0),
    };

    return ref.set(data, SetOptions(merge: true));
  }
}
