import 'package:flutter/material.dart';

import 'main.dart';

/// Bucket 담당 - 버켓 관련 모든 데이터는 여기서 담당함
// BucketService의 bucketList가 변경되는 경우 해당 값을 보여주는 화면들을 갱신 - ChangeNotifier 클래스 상속
// ChangeNotifier 상속 받은 경우 notifylisteners(); 호출하여 위젯들 갱신하는 기능 사용 가능
class BucketService extends ChangeNotifier {
  List<Bucket> bucketList = [
    Bucket('잠자기', false), // 더미(dummy) 데이터
  ];

  /// bucket 추가
  void createBucket(String job) {
    bucketList.add(Bucket(job, false));
    notifyListeners(); // 갱신 = Consumer<BucketService>의 builder 부분만 새로고침
  }

  /// bucket 수정
  void updateBucket(Bucket bucket, int index) {
    bucketList[index] = bucket;
    notifyListeners();
  }

  /// bucket 삭제
  void deleteBucket(int index) {
    bucketList.removeAt(index);
    notifyListeners();
  }
}
