import 'package:ds_podi/ds_podi.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils.dart';

/// Aplicação do [NetworkImageWidget] com um [child] na frente
class BackgroundNetworkImageWidget extends StatelessWidget {
  final Widget child;
  final String url;
  final double? height, width;
  final BoxFit fit;
  final bool openImage;
  final Color loadingColor, backgroundColor;
  final BorderRadius borderRadius;
  const BackgroundNetworkImageWidget(
    this.url, {
    required this.child,
    this.height,
    this.width,
    this.openImage = false,
    this.borderRadius = BorderRadius.zero,
    this.backgroundColor = PodiColors.white,
    this.loadingColor = PodiColors.green,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: Container(
        height: height,
        width: width,
        color: backgroundColor,
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              child: NetworkImageWidget(url,
                  fit: fit,
                  height: height,
                  width: width,
                  loadingColor: loadingColor),
            ),
            Container(height: height, width: width, child: child),
          ],
        ),
      ),
    );
  }
}

/// Carrega imagens tanto svg como outros formatos sendo asset ou network
class NetworkImageWidget extends StatelessWidget {
  final String url;
  final BoxFit fit;
  final double? height, width;
  final Color loadingColor;

  ///Deve abrir a imagem no clique em aplicativos mobile
  final bool openImage;

  const NetworkImageWidget(
    this.url, {
    this.height,
    this.width,
    this.openImage = false,
    this.loadingColor = PodiColors.green,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    Widget loader([double? progress]) => Center(
          child: CircularProgressIndicator(
              value: progress,
              valueColor: AlwaysStoppedAnimation<Color>(loadingColor),
              strokeWidth: 3),
        );
    Widget fallback = Container(
      height: height,
      width: width,
      color: PodiColors.white,
      padding: EdgeInsets.all(4),
      child: FittedBox(
        fit: BoxFit.contain,
        child: Icon(Icons.image_not_supported_outlined,
            color: PodiColors.dark[500]),
      ),
    );

    Widget image;
    if (isNull(url) ||
        !["jpg", "png", "svg", "jpeg", "gif", "bmp", "dib", "webp", "wbmp"]
            .any((v) => RegExp(".$v").hasMatch(url.toLowerCase())))
      return fallback;

    try {
      final _url = Uri.parse(url).toString();
      if (url.split(".").last == "svg") {
        image = SizedBox(
          height: height,
          width: width,
          child: SvgPicture.network(
            _url,
            height: height,
            width: width,
            fit: fit,
            placeholderBuilder: (context) => loader(),
          ),
        );
      } else {
        image = SizedBox(
          height: height,
          width: width,
          child: Image.network(
            _url,
            fit: fit,
            height: height,
            width: width,
          ),
        );
      }
    } catch (e) {
      if (url.split(".").last == "svg") {
        image = SizedBox(
          height: height,
          width: width,
          child: SvgPicture.asset(
            url,
            height: height,
            width: width,
            fit: fit,
            placeholderBuilder: (context) => loader(),
          ),
        );
      } else {
        image = SizedBox(
          height: height,
          width: width,
          child: Image.asset(
            url,
            fit: fit,
            height: height,
            width: width,
          ),
        );
      }
    }

    if (!openImage || kIsWeb) return image;

    return GestureDetector(
      child: image,
      onTap: () {
        Navigator.of(context).push(
          FadePageRoute(
            page: Scaffold(
              backgroundColor: PodiColors.dark,
              body: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Stack(
                  children: [
                    InteractiveViewer(
                      child: Center(
                        child: url.split(".").last == "svg"
                            ? SvgPicture.network(
                                Uri.parse(url).toString(),
                                height: double.infinity,
                                width: double.infinity,
                                fit: BoxFit.contain,
                                placeholderBuilder: (_) => loader(),
                              )
                            : Image.network(
                                Uri.parse(url).toString(),
                                height: double.infinity,
                                width: double.infinity,
                                fit: BoxFit.contain,
                              ),
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).padding.top,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        color: PodiColors.white,
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            settings: RouteSettings(name: url),
          ),
        );
      },
    );
  }
}
