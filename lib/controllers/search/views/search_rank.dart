import 'package:flutter/material.dart';
import 'package:flutter_milai/global.dart';
import '../model/find_rank_model.dart';

class SearchRank extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _SearchBankState();
  }
}

class _SearchBankState extends State<SearchRank>
    with AutomaticKeepAliveClientMixin {
  List<FindRankModel> _rankModels = new List();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    _requestRank();
  }

  _requestRank() async {
    ResponseModel model = await HttpService.shareInstance()
        .doPost('MiLaiApi/GetListFindLeaderboard');
    if (model.isSuccess) {
      _rankModels = getFindRankModelList(model.result);
      setState(() {});
    }
  }

  Widget _buildRankWidget(BuildContext context, int index) {
    FindRankModel model = _rankModels.elementAt(index);

    List<Widget> rowProducts = new List();
    for (int i = 0; i < model.findLeaderboardProduct.length && i < 4; ++i) {
      FindLeaderboardProduct productModel = model.findLeaderboardProduct[i];
      rowProducts.add(
        Expanded(
          child: Container(
            padding: EdgeInsets.only(right: 5, left: 5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: AspectRatio(
                aspectRatio: 1,
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: productModel.imageUrl,
                ),
              ),
            ),
          ),
        ),
      );
    }
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      padding: EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5)
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 5, right: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${model.title}',
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      '${model.subtitle}',
                      style: TextStyle(color: Colors.black54, fontSize: 12),
                    ),
                  ],
                )),
                Row(
                  children: <Widget>[
                    Text(
                      '查看榜单',
                      style: TextStyle(color: Colors.black26, fontSize: 12),
                    ),
                    Icon(
                      Icons.list,
                      size: 14,
                      color: Colors.black26,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                      color: Colors.black26,
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(height: 10,),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: rowProducts,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Color(0xfff0f0f0),
      margin: EdgeInsets.only(top: 20),
      child: ListView.builder(
        itemCount: _rankModels.length,
        itemBuilder: _buildRankWidget,
      ),
    );
  }
}
