// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' as _svg;
import 'package:vector_graphics/vector_graphics.dart' as _vg;

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// Directory path: assets/icons/auth
  $AssetsIconsAuthGen get auth => const $AssetsIconsAuthGen();

  /// Directory path: assets/icons/navigation
  $AssetsIconsNavigationGen get navigation => const $AssetsIconsNavigationGen();

  /// Directory path: assets/icons/ui
  $AssetsIconsUiGen get ui => const $AssetsIconsUiGen();
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/auth-background.webp
  AssetGenImage get authBackground =>
      const AssetGenImage('assets/images/auth-background.webp');

  /// List of all assets
  List<AssetGenImage> get values => [authBackground];
}

class $AssetsTranslationsGen {
  const $AssetsTranslationsGen();

  /// File path: assets/translations/ar.json
  String get ar => 'assets/translations/ar.json';

  /// File path: assets/translations/en.json
  String get en => 'assets/translations/en.json';

  /// List of all assets
  List<String> get values => [ar, en];
}

class $AssetsIconsAuthGen {
  const $AssetsIconsAuthGen();

  /// File path: assets/icons/auth/city.svg
  SvgGenImage get city => const SvgGenImage('assets/icons/auth/city.svg');

  /// File path: assets/icons/auth/eye_off.svg
  SvgGenImage get eyeOff => const SvgGenImage('assets/icons/auth/eye_off.svg');

  /// File path: assets/icons/auth/eye_on.svg
  SvgGenImage get eyeOn => const SvgGenImage('assets/icons/auth/eye_on.svg');

  /// File path: assets/icons/auth/lock.svg
  SvgGenImage get lock => const SvgGenImage('assets/icons/auth/lock.svg');

  /// File path: assets/icons/auth/state.svg
  SvgGenImage get state => const SvgGenImage('assets/icons/auth/state.svg');

  /// File path: assets/icons/auth/user.svg
  SvgGenImage get user => const SvgGenImage('assets/icons/auth/user.svg');

  /// List of all assets
  List<SvgGenImage> get values => [city, eyeOff, eyeOn, lock, state, user];
}

class $AssetsIconsNavigationGen {
  const $AssetsIconsNavigationGen();

  /// File path: assets/icons/navigation/angle_circle_right.svg
  SvgGenImage get angleCircleRight =>
      const SvgGenImage('assets/icons/navigation/angle_circle_right.svg');

  /// File path: assets/icons/navigation/arrow_left.svg
  SvgGenImage get arrowLeft =>
      const SvgGenImage('assets/icons/navigation/arrow_left.svg');

  /// File path: assets/icons/navigation/arrow_right.svg
  SvgGenImage get arrowRight =>
      const SvgGenImage('assets/icons/navigation/arrow_right.svg');

  /// File path: assets/icons/navigation/home.svg
  SvgGenImage get home => const SvgGenImage('assets/icons/navigation/home.svg');

  /// List of all assets
  List<SvgGenImage> get values => [
    angleCircleRight,
    arrowLeft,
    arrowRight,
    home,
  ];
}

class $AssetsIconsUiGen {
  const $AssetsIconsUiGen();

  /// File path: assets/icons/ui/phone_flip.svg
  SvgGenImage get phoneFlip =>
      const SvgGenImage('assets/icons/ui/phone_flip.svg');

  /// File path: assets/icons/ui/phone_ring.svg
  SvgGenImage get phoneRing =>
      const SvgGenImage('assets/icons/ui/phone_ring.svg');

  /// List of all assets
  List<SvgGenImage> get values => [phoneFlip, phoneRing];
}

class Assets {
  const Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsTranslationsGen translations = $AssetsTranslationsGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}

class SvgGenImage {
  const SvgGenImage(this._assetName, {this.size, this.flavors = const {}})
    : _isVecFormat = false;

  const SvgGenImage.vec(this._assetName, {this.size, this.flavors = const {}})
    : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  _svg.SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    _svg.SvgTheme? theme,
    _svg.ColorMapper? colorMapper,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final _svg.BytesLoader loader;
    if (_isVecFormat) {
      loader = _vg.AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = _svg.SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
        colorMapper: colorMapper,
      );
    }
    return _svg.SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter:
          colorFilter ??
          (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
