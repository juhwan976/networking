import 'package:flutter/material.dart';

/// 당겨서 데이터 더 가져오기 기능 구현해야함.

class CommunityPage extends StatefulWidget {
  const CommunityPage({
    Key key,
  }) : super(key: key);

  @override
  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  List<Post> _postList = new List<Post>();

  /// DateTime을 받아서 필요한 형식의 문자열을 반환하는 메서드
  String _returnDateTimeString(DateTime _dateTime) {
    return '${_dateTime.year}/${_dateTime.month}/${_dateTime.day}';
  }

  /// 페이지 내용 빌드 메서드
  Widget _buildPage(double _deviceHeight, double _deviceWidth) {
    return Scrollbar(
      child: Container(
        padding: EdgeInsets.fromLTRB(
          _deviceWidth * 0.055,
          _deviceHeight * 0.03,
          _deviceWidth * 0.055,
          0,
        ),
        child: ListView.builder(
          controller: PrimaryScrollController.of(context),
          itemCount: _postList.length + 1,
          itemBuilder: (BuildContext context, int index) {
            if (index <= _postList.length - 1) {
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: _deviceHeight * 0.04,
                      //width: _deviceWidth * 0.891,
                      child: Row(
                        children: <Widget>[
                          Container(
                            /// 프로필 사진
                            width: _deviceWidth * 0.113,
                            child: _postList.elementAt(index).profilePhoto,
                          ),
                          Expanded(
                            child: Container(
                              /// 작성자 닉네임
                              //width: _deviceWidth * 0.782,
                              child: Text(
                                '${_postList.elementAt(index).nickName}',
                              ),
                            ),
                          ),
                          Container(
                            /// 댓글 수 및 좋아요 수
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.fromLTRB(
                                0, 0, _deviceWidth * 0.02, 0),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  child: Icon(Icons.comment, size: _deviceHeight * 0.016),
                                ),
                                Container(
                                  child: Text(
                                      ' ${_postList.elementAt(index).commentNum}'),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(
                                      _deviceWidth * 0.01, 0, 0, 0),
                                  child: Icon(Icons.favorite, size: _deviceHeight * 0.016),
                                ),
                                Container(
                                  child: Text(
                                      ' ${_postList.elementAt(index).likeNum}'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: _deviceHeight * 0.192,
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              /// 게시글 내용
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.fromLTRB(
                                _deviceWidth * 0.033,
                                _deviceHeight * 0.014,
                                _deviceWidth * 0.033,
                                0,
                              ),
                              child: Text(
                                _postList.elementAt(index).content,
                              ),
                            ),
                          ),
                          Container(
                            /// 게시글 작성일
                            alignment: Alignment.bottomRight,
                            margin: EdgeInsets.fromLTRB(
                              0,
                              0,
                              _deviceWidth * 0.033,
                              _deviceHeight * 0.007,
                            ),
                            child: Text(_returnDateTimeString(
                                _postList.elementAt(index).postDate)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Container(
                height: 30,
                width: 30,
                color: Colors.green,
              );
            }
          },
        ),
      ),
    );
  }

  /// 앱바 빌드 메서드
  Widget _buildTitle(double _deviceHeight, double _deviceWidth) {
    return Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(_deviceWidth * 0.105, 0, 0, 0),
          height: _deviceHeight * 0.041,
          width: _deviceWidth * 0.101,
          color: Colors.blue,
        ),
        Expanded(
          child: Container(
            alignment: Alignment.center,
            child: Text(
              '커뮤니티',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(
              _deviceWidth * 0.02, 0, _deviceWidth * 0.111, 0),
          height: _deviceHeight * 0.041,
          width: _deviceWidth * 0.075,
          color: Colors.blue,
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < 20; i++) {
      _postList.add(
        Post(
          profilePhoto: Image.asset('images/community_img_profile.png'),
          nickName: 'test',
          commentNum: 999,
          likeNum: 999,
          content: '이것은 테스트용 입니다. ${2000 - i} 번째 글',
          postDate: DateTime(2021, 02, 17, 03, 20),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final _deviceHeight = MediaQuery.of(context).size.height;
    final _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        elevation: 0.0,
        leading: null,
        automaticallyImplyLeading: false,
        toolbarHeight: _deviceHeight * 0.073,
        centerTitle: true,
        titleSpacing: 0,
        title: _buildTitle(_deviceHeight, _deviceWidth),
      ),
      body: _buildPage(_deviceHeight, _deviceWidth),
    );
  }
}

/// 게시글에 대한 클래스
class Post {
  /// 프로필 사진
  Image profilePhoto;

  /// 사용자 닉네임
  String nickName;

  /// 댓글 수
  int commentNum;

  /// 좋아요 수
  int likeNum;

  /// 게시글 내용
  String content;

  /// 게시글 작성일
  DateTime postDate;

  Post(
      {@required this.profilePhoto,
      @required this.nickName,
      @required this.commentNum,
      @required this.likeNum,
      @required this.content,
      @required this.postDate});
}