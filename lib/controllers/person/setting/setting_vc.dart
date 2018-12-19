import 'package:flutter/material.dart';
import 'package:flutter_milai/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:io';

import './views/setting_action_sheet_dialog.dart';

class SettingVC extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _SettingVCState();
  }
}

enum ItemType {
  ItemType_None,
  ItemType_Head,
  ItemType_Nickname,
  ItemType_Sex,
  ItemType_Birthday,
  ItemType_Password,
  ItemType_Mobile,
  ItemType_Wechat,
  ItemType_AboutUs,
  ItemType_CleanCache
}

class _SettingVCState extends State<SettingVC> {
  BuildContext _innerContext;

  //更改性别
  _requestSex(String sex) async {
    ResponseModel model = await HttpService.shareInstance().doPost(
        'MiLaiApi/UpdateUserSex',
        params: {'Sex': sex, 'ID': UserManager.shareInstance().userModel.iD});
    if (model.isSuccess) {
      UserManager.shareInstance().userModel.sex = sex;
      if (sex == '1001') {
        UserManager.shareInstance().userModel.sexName = '男';
      } else if (sex == '1002') {
        UserManager.shareInstance().userModel.sexName = '女';
      }
      UserManager.shareInstance().update();
      setState(() {});
    }
    ToastUtils.shortToast(model.message);
  }

  ///
  ///对图片进行裁剪 >> base64加密 >> 上传服务器 >> 更新用户头像
  ///
  _onHeadImagePicked(File srcImage) async {
    if (srcImage == null) {
      return;
    }
    File croppedImage = await ImageCropper.cropImage(
        sourcePath: srcImage.path,
        ratioX: 1,
        ratioY: 1,
        maxWidth: 512,
        maxHeight: 512);
    List<int> data = await croppedImage.readAsBytes();
    ResponseModel model = await HttpService.shareInstance()
        .doPost('MiLaiApi/UpdateHeaderImg', params: {
      "ID": UserManager.shareInstance().userModel.iD,
      "SuffixName": "jpeg",
      "ActionType": "1001",
      "HeadImageUrl": base64Encode(data)
    });
    if (model.isSuccess) {
      //修改个人资料
      print('${model.result['HeadImageUrl']}');
    } else {
      ToastUtils.shortToast(model.message);
    }
  }

  _onItemTap(ItemType type) async {
    print('$type');
    switch (type) {
      case ItemType.ItemType_Birthday:
        {
          // showCupertinoDialog(
          //     context: context,
          //     builder: (BuildContext context) {
          //       return CupertinoActionSheet(
          //         actions: <Widget>[
          //           Text('男'),
          //           Text('女'),
          //         ],
          //         message: Text('选择性别'),
          //       );
          //     });
        }
        break;
      case ItemType.ItemType_Head:
        {
          int op = await showActionSheetDialog(_innerContext, null, [
            {'title': '拍照', 'value': 1},
            {'title': '相册', 'value': 2}
          ]);
          if (op != null) {
            if (op == 1) {
              //拍照
            } else if (op == 2) {
              //相册
              File image =
                  await ImagePicker.pickImage(source: ImageSource.gallery);
              _onHeadImagePicked(image);
            }
          }
          break;
        }
      case ItemType.ItemType_Sex:
        {
          String sex = await showActionSheetDialog(_innerContext, '选择性别', [
            {'title': '男', 'value': '1001'},
            {'title': '女', 'value': '1002'}
          ]);
          if (sex != null) {
            _requestSex(sex);
          }
          break;
        }
      default:
        break;
    }
  }

  Widget _buildItem(String title, Widget right,
      {bool hasMore = true,
      bool separatorEnable = true,
      double height = 44,
      double marginTop = 0,
      ItemType type = ItemType.ItemType_None}) {
    return new Container(
        margin: EdgeInsets.only(top: marginTop),
        height: height,
        child: new Material(
            color: Colors.white,
            child: InkWell(
              child: Container(
                  padding: EdgeInsets.only(left: 15, right: 10),
                  height: height,
                  child: Column(children: <Widget>[
                    Expanded(
                        child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(title, style: TextStyle(color: Colors.black87)),
                        Expanded(child: Container()),
                        right,
                        Container(width: 5),
                        hasMore
                            ? Icon(Icons.arrow_forward_ios,
                                color: Colors.grey, size: 14)
                            : Container(),
                      ],
                    )),
                    Divider(
                      height: 0.5,
                    ),
                  ])),
              onTap: () => _onItemTap(type),
            )));
  }

  @override
  Widget build(BuildContext context) {
    UserModel user = UserManager.shareInstance().userModel;
    Widget headWidget = new Container(
      padding: EdgeInsets.only(top: 5, bottom: 5),
      child: new ClipOval(
        child: CachedNetworkImage(
          imageUrl: user.headImageUrl,
          placeholder: Image.asset(
            'images/person_head_ico.png',
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('设置'),
      ),
      body: Builder(builder: (BuildContext context) {
        _innerContext = context;
        return new Container(
          color: Color(0xffeef0f0),
          child: ListView(
            children: <Widget>[
              _buildItem('头像', headWidget,
                  marginTop: 10, height: 60, type: ItemType.ItemType_Head),
              _buildItem('昵称', Text('${user.nickName}'),
                  type: ItemType.ItemType_Nickname),
              _buildItem('性别', Text('${user.sexName}'),
                  type: ItemType.ItemType_Sex),
              _buildItem('生日', Text('${user.birthday}'),
                  separatorEnable: false, type: ItemType.ItemType_Birthday),
              _buildItem('修改密码', Container(),
                  marginTop: 10, type: ItemType.ItemType_Password),
              _buildItem('绑定手机', Text('${user.mobile}'),
                  type: ItemType.ItemType_Mobile),
              _buildItem('绑定微信号', Container(),
                  separatorEnable: false, type: ItemType.ItemType_Wechat),
              _buildItem('关于我们', Container(),
                  marginTop: 10, type: ItemType.ItemType_AboutUs),
              _buildItem('清除缓存', Container(),
                  type: ItemType.ItemType_CleanCache),
              _buildItem('版本', Text('V2.9.2'),
                  separatorEnable: false, hasMore: false),
              Container(
                  height: 44,
                  color: Colors.white,
                  margin: EdgeInsets.only(top: 40),
                  child: FlatButton(
                      child: Text('退出登录',
                          style: TextStyle(color: Global.kTintColor)),
                      onPressed: () {
                        UserManager.shareInstance().logout();
                        Navigator.pop(context);
                        NavigatorUtil.goLogin(context);
                      })),
            ],
          ),
        );
      }),
    );
  }
}
