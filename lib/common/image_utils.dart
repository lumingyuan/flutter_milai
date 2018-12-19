import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/transition_to_image.dart';
import 'package:flutter_advanced_networkimage/flutter_advanced_networkimage.dart';

class ImageUtils {

  //显示网络图片
  static Widget imageFromUrl(String url,
      {Image placeholder, BoxFit fit = BoxFit.contain}) {
    if (placeholder == null) {
      return Image(
        image: AdvancedNetworkImage(url, useDiskCache: true),
        fit: fit,
      );
    }
    return TransitionToImage(
      AdvancedNetworkImage(url),
      loadingWidget: placeholder,
      placeholder: placeholder,
    );
  }

  static ImageProvider<AdvancedNetworkImage> imageProviderFromUrl(String url) {
    return AdvancedNetworkImage(url, useDiskCache: true);
  }
}
