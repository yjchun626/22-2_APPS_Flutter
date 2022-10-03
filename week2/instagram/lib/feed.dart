import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Feed extends StatefulWidget {
  const Feed({
    Key? key,
    // required: 필수 전달 매개 변수
    // this.imageUrl: 많은 Feed 인스턴스 중 현재 인스턴스의 imageUrl
    required this.imageUrl,
  }) : super(key: key);

  final String imageUrl; // 이미지를 담을 변수

  @override
  State<Feed> createState() => _FeedState();
}

// 위의 StatelessWidget을 StatefulWidget으로 바꿔줌으로써 FeedState 클래스 추가

class _FeedState extends State<Feed> {
  // 좋아요 여부
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      // column 위젯으로 세로 방향 레이아웃 세팅
      crossAxisAlignment: CrossAxisAlignment.start, // 텍스트 좌측 정렬
      children: [
        // 이미지
        Image.network(
          widget.imageUrl, // 10번째 줄의 imageUrl 가져오기
          height: 400,
          width: double.infinity, // 폭 최대로 채우기
          fit: BoxFit.cover, // 이미지의 비율 유지하면서 고정된 폭, 높이에 맞추어 이미지 크기 잘라짐
        ),

        // 아이콘 목록 - 아이콘 버튼 여러 개 가로로 배치하기 위해 Row 위젯
        Row(
          children: [
            IconButton(
              onPressed: () {
                // 화면 갱신
                setState(() {
                  // 안쪽 코드 실행 후 화면 갱신
                  // setState() 호출시 StatefulWidget의 build()함수를 호출해 화면을 갱신
                  isFavorite = !isFavorite; // 좋아요 토글
                });
              },
              icon: Icon(
                CupertinoIcons.heart,
                color: isFavorite ? Colors.pink : Colors.black,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                CupertinoIcons.chat_bubble,
                color: Colors.black,
              ),
            ),
            Spacer(), // 빈 공간 추가
            IconButton(
              onPressed: () {},
              icon: Icon(
                CupertinoIcons.bookmark,
                color: Colors.black,
              ),
            ),
          ],
        ),

        // 화면과 텍스트 사이 간격 주기 위해 Padding 위젯으로 Text 감싸기
        // 좋아요
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "2 likes",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // 설명
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "My cat is docile even when bathed. I put a duck on his head in the wick and he's staring at me. Isn't it so cute??",
          ),
        ),

        // 날짜
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "FEBURARY 6",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
