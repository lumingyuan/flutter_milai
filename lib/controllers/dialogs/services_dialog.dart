import 'package:flutter_milai/global.dart';

import './services_model.dart';

class ServicesDialog extends StatefulWidget {
  static void show(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ServicesDialog();
        });
  }

  @override
  State<StatefulWidget> createState() {
    return new _ServicesDialogState();
  }
}

class _ServicesDialogState extends State<ServicesDialog>
    with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _controller;

  ServicesModel _servicesModel;

  @override
  void initState() {
    super.initState();

    _controller = new AnimationController(
        duration: Duration(milliseconds: 300), vsync: this);
    _animation = new Tween(begin: -300.0, end: 50.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    _controller.forward();

    requestServices();
  }

  requestServices() async {
    ResponseModel model = await HttpService.shareInstance()
        .doPost('MiLaiApi/GetListCustomService');
    if (model.isSuccess) {
      _servicesModel = ServicesModel.fromJson(model.result);
      setState(() {});
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = kScreenWidth - 100 * Global.kScale;
    double height = width * 424 / 272;
    double left = 100 * Global.kScale / 2;

    String serviceTime = "";
    if (_servicesModel != null) {
      serviceTime = _servicesModel.systemSetting.value;
    }

    List<CustomServiceList> list = new List();
    if (_servicesModel != null && _servicesModel.customServiceList != null && _servicesModel.customServiceList.length > 0) {
      list.addAll(_servicesModel.customServiceList);
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
          child: InkWell(
        child: Stack(
          children: <Widget>[
            Positioned(
                top: _animation.value,
                left: left,
                child: Container(
                    width: width,
                    height: height,
                    padding: EdgeInsets.only(bottom: 25),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('images/service_dialog_bg.png'))),
                    child: Column(
                      children: <Widget>[
                        Container(height: 190 * height / 424),
                        Image.asset('images/service_dialog_title.png'),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 9),
                          child: Text('$serviceTime', style: TextStyle(color: Color(0xfffc3a43), fontSize: 11),),
                        ),
                        Expanded(
                          child: ListView(
                          children: list.map((CustomServiceList item) {
                            return Container(
                              height: 30,
                              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                              child: OutlineButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                onPressed: () {},
                                borderSide: BorderSide(
                                  color: Color(0xff454545),
                                ),
                                child: Text('${item.displayName}', style:TextStyle(color: Color(0xff454545), fontSize: 13)),
                              ),
                            );
                          }).toList()
                        ),
                        )
                      ],
                    )))
          ],
        ),
        onTap: () {
          Navigator.pop(context);
        },
      )),
    );
  }
}
