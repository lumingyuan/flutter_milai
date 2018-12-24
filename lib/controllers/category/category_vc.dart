import 'package:flutter_milai/global.dart';

import './model/class_model.dart';
import './model/category_model.dart';

class CategoryVC extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _CategoryVCState();
  }
}

class _CategoryVCState extends State<CategoryVC> {
  List<ClassModel> _classModels = new List();
  int _currentClassIndex = 1;

  Map<String, CategoryModel> _categoryMap = new Map();

  @override
  void initState() {
    super.initState();

    _requestCategory();
  }

  //获取大分类
  _requestCategory() async {
    ResponseModel model = await HttpService.shareInstance()
        .doPost('MiLaiApi/GetListProductCategory1');
    if (model.isSuccess) {
      _classModels = getClassModelList(model.result);

      _currentClassIndex = 1;
      _requestSubCategory();

      setState(() {});
    }
  }

  //获取子分类
  _requestSubCategory() async {
    int index = _currentClassIndex - 1;
    if (index < 0 || index >= _classModels.length) {
      return;
    }
    String tbid = _classModels[index].iD;
    ResponseModel model = await HttpService.shareInstance().doPost(
        'MiLaiApi/GetListProductCategoryAd23',
        params: {"CategoryTBID": tbid});
    if (model.isSuccess) {
      _categoryMap[tbid] = CategoryModel.fromJson(model.result);

      setState(() {});
    }
  }

  _onClassPress(int index) {
    if (index == 0) {
    } else {
      _currentClassIndex = index;

      ClassModel model = _classModels[index - 1];
      if (!_categoryMap.containsKey(model.iD)) {
        _requestSubCategory();
      }

      setState(() {});
    }
  }

  _buildClassWidget() {
    return ListView.builder(
      itemCount: _classModels.length,
      itemBuilder: (context, index) {
        if (index == 0) {
          return FlatButton(
            onPressed: () {},
            child: Text('全部',
                style: TextStyle(fontSize: 12, color: Color(0xff666666))),
          );
        } else {
          ClassModel model = _classModels[index - 1];
          bool isSelected = _currentClassIndex == index;
          return Container(
              height: 35,
              //margin: EdgeInsets.only(left:2, right:2),
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color:
                          isSelected ? Color(0xFFFC3A43) : Colors.transparent,
                      borderRadius: BorderRadius.circular(35 / 2),
                    ),
                    margin:
                        EdgeInsets.only(left: 2, right: 2, top: 3, bottom: 3),
                  ),
                  FlatButton(
                      onPressed: () => _onClassPress(index),
                      child: Text(
                        '${model.className}',
                        style: TextStyle(
                            fontSize: 12,
                            color:
                                isSelected ? Colors.white : Color(0xff333333)),
                      ))
                ],
              ));
        }
      },
    );
  }

  //创建
  Widget _buildProductCategoryWidgets(Category23 category) {
    if (category.categoryList == null || category.categoryList.length == 0) {
      return Container();
    }
    return Container(
        child: GridView.count(
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      shrinkWrap: true,
      childAspectRatio: 77/92,
      children: category.categoryList.map((CategoryList item) {
        return Container(
          child: Column(
            children: <Widget>[
              ImageUtils.imageFromUrl(item.iconUrl),
              Expanded(
                child: Text('${item.className}', style:TextStyle(fontSize: 12, color: Color(0xff666666))),
              )
            ],
          ),
        );
      }).toList(),
    ));
  }

  _buildCategoryWidget() {
    if (_classModels == null ||
        _classModels.length == 0 ||
        _currentClassIndex - 1 < 0 ||
        _currentClassIndex - 1 > _classModels.length) {
      return Container();
    }
    ClassModel classModel = _classModels.elementAt(_currentClassIndex - 1);
    if (_categoryMap.containsKey(classModel.iD)) {
      CategoryModel model = _categoryMap[classModel.iD];

      List<Widget> childs = new List();
      for (Category23 item23 in model.category23) {
        Widget w = Container(
          margin: EdgeInsets.only(left: 5),
          child: Column(
            children: <Widget>[
              Container(
                height: 44,
                alignment: Alignment.centerLeft,
                child: Text('${item23.className}',
                    style:
                        TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
              ),
              _buildProductCategoryWidgets(item23)
            ],
          ),
        );
        childs.add(w);
      }

      return ListView(children: childs);
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('分类'),
      ),
      body: Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Container(
              width: 80,
              child: _buildClassWidget(),
            ),
            Expanded(
              child: _buildCategoryWidget(),
            )
          ],
        ),
      ),
    );
  }
}
