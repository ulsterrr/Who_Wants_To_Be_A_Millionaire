import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:who_wants_to_be_a_millionaire/Object/catebyuser_obj.dart';
import 'package:who_wants_to_be_a_millionaire/Object/category_obj.dart';
import 'package:who_wants_to_be_a_millionaire/Object/quiz_obj.dart';
import 'package:who_wants_to_be_a_millionaire/Object/quizbyuser_obj.dart';
import 'package:who_wants_to_be_a_millionaire/Object/rank_obj.dart';
import 'package:who_wants_to_be_a_millionaire/Object/usercredit_obj.dart';
import 'package:who_wants_to_be_a_millionaire/Provider/authentication.dart';

class FireStoreProvider {
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
    int endIndex = 6;
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
    //sắp ngẫu nhiên câu hỏi
    quiz.shuffle();

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

  // Cập nhật thông tin trả lời của người chơi
  static Future<void> updateUserQuiz(
      QuizObject quiz, bool? isPass, int coutdown) {
    FirebaseFirestore _db = FirebaseFirestore.instance;
    var user = FirebaseAuthService().user!;
    var ref = _db.collection('QuizbyUser');

    var temp = {
      'id': FieldValue.increment(1),
      'userId': user.uid,
      'quizId': quiz.id,
      'quizChoice': quiz.answer,
      'countFailed': isPass == false ? 1 : 0,
      'countSuccess': isPass == true ? 1 : 0,
      'atTime': coutdown.toString(),
    };

    return ref.add(temp);
  }

  // Cập nhật thông tin xếp hạng của người chơi khi đã xong game
  static Future<void> gameToRank(int score, DateTime time) {
    FirebaseFirestore _db = FirebaseFirestore.instance;
    var user = FirebaseAuthService().user!;
    var ref = _db.collection('rank');

    var temp = {
      'id': FieldValue.increment(1),
      'userId': user.uid,
      'fullName': user.displayName,
      'score': score,
      'atTime': time.toString().substring(0, 19),
    };

    return ref.add(temp);
  }

  // Lấy thông tin trả lời của người chơi
  static Future<List<CatebyUserObject>> getUserbyQuiz() async {
    var user = FirebaseAuthService().user!;
    FirebaseFirestore _db = FirebaseFirestore.instance;
    List<CatebyUserObject> qbu = [];
    var ref = _db.collection('QuizbyUser');
    var snapshot = await ref.get();
    var data = snapshot.docs.map((s) => s.data());

    qbu = data.map((d) => CatebyUserObject.fromJson(d)).toList();
    qbu = qbu.where((element) => element.catetoryId == user.uid).toList();

    return qbu;
  }

  // Cập nhật thông tin lĩnh vực đã hoàn thành của người chơi
  static Future<void> updateUserCategory(CatebyUserObject cate, bool? isPass) {
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    var user = FirebaseAuthService().user!;
    var ref = _db.collection('CatebyUser');

    var data = {
      'id': FieldValue.increment(1),
      'userId': user.uid,
      'catetoryId': cate.catetoryId,
      'isPass': isPass ?? false,
      'passCount':
          isPass == true ? FieldValue.increment(1) : FieldValue.increment(0),
    };

    return ref.add(data);
  }
  //lấy 10 rank cao điểm nhất
  static Future<List<UserRankObject>> getUserRank() async {
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    List<UserRankObject> rank = [];

    var ref = _db.collection('rank').orderBy('score', descending: true);
    var snapshot = await ref.get();
    var data = snapshot.docs.map((s) => s.data());

    rank = data.map((d) => UserRankObject.fromJson(d)).toList();

    List<UserRankObject> subList = [];
    int startIndex = 0;
    int endIndex = 10;
    subList = rank.sublist(startIndex, endIndex);

    return subList;
  }

  //mua credit cho user
  static Future<void> buyCreditUser(int creditsId, int qty) {
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    var user = FirebaseAuthService().user!;
    var ref = _db.collection('UserCredit');
    DateTime today = DateTime.now();

    var data = {
      'id': 1,
      'userId': user.uid,
      'creditsId': creditsId,
      'quantity': qty,
      'buyTime': today.toString().substring(0, 19),
    };

    return ref.add(data);
  }

  //lấy số tiền của user đã mua
  static Future<int> getUserCredit() async {
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    List<UserCreditObject> credit = [];

    var ref = _db.collection('UserCredit');
    var snapshot = await ref.get();
    var data = snapshot.docs.map((s) => s.data());

    credit = data.map((d) => UserCreditObject.fromJson(d)).toList();

    int total_credit = 0;
    credit.forEach((element) { 
      total_credit += element.quantity;
    });

    return total_credit;
  }
}
