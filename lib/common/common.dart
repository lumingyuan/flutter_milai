import 'package:quiver/strings.dart';

export './ui/loading_dialog.dart';
export './navigator_utils.dart';
export './toast_utils.dart';
export './native_utils.dart';
export './image_utils.dart';

export 'package:common_utils/common_utils.dart';
export 'package:shared_preferences/shared_preferences.dart';
export 'package:crypto/crypto.dart';

//字符串转int
int intValueOf(String s) {
  return int.tryParse(s)??0;
}

//字符串转bool
bool boolValueOf(String s) {
  if (s == null || isEmpty(s) || s == 'False' || s == '0' || s == 'false') {
    return false;
  }
  return true;
}