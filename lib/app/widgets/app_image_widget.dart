import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/app/constants/app_colors.dart';
import 'package:flutter_svg/svg.dart';

class AppImageWidget extends StatefulWidget {
  final String? url;
  final double? width;
  final double? height;
  final Color? color;
  final double? ratio;
  final BoxFit? fit;
  final ColorFilter? colorFilter;
  final bool showBackground;
  final EdgeInsets? padding;

  const AppImageWidget({
    Key? key,
    this.url,
    this.color,
    this.ratio,
    this.fit,
    this.width,
    this.height,
    this.colorFilter,
    this.padding,
    this.showBackground = false,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AppImageWidgetState();
  }
}

class _AppImageWidgetState extends State<AppImageWidget> {
  bool isError = false;

  @override
  Widget build(BuildContext context) {
    return widget.url != null
        ? widget.url!.contains("http")
            ? widget.showBackground
                ? isError
                    ? SizedBox(
                        width: widget.width,
                      )
                    : Container(
                        width: widget.width,
                        height: widget.height,
                        padding: widget.padding ?? EdgeInsets.zero,
                        decoration: BoxDecoration(
                          border: isError ? null : Border.all(),
                          shape: BoxShape.circle,
                          color: isError ? Colors.transparent : AppColors.white,
                        ),
                        child: Center(
                          child: _buildImageNetwork(widget.url  ?? ''),
                        ),
                      )
                : _buildImageNetwork(widget.url ?? '')
            : _buildImageAsset(widget.url  ?? '')
        : Image.asset(
            widget.url ?? '',
            width: widget.width,
            height: widget.height,
            color: widget.color,
            fit: widget.fit ?? BoxFit.fitWidth,
            errorBuilder: (_, __, ___) {
              return const SizedBox();
            },
          );
  }

  Widget _buildImageNetwork(String url) {
    if (url.toString().toLowerCase().endsWith('.svg')) {
      if (widget.ratio != null) {
        return AspectRatio(
          aspectRatio: widget.ratio!,
          child: SvgPicture.network(
            url,
            fit: widget.fit ?? BoxFit.fitWidth,
            width: widget.width,
            height: widget.height,
          ),
        );
      }
      if (widget.colorFilter != null) {
        return ColorFiltered(
          colorFilter: widget.colorFilter!,
          child:  SvgPicture.network(
            url,
            fit: widget.fit ?? BoxFit.fitWidth,
            width: widget.width,
            height: widget.height,
          ),
        );
      }
      return  SvgPicture.network(
        url,
        fit: widget.fit ?? BoxFit.fitWidth,
        width: widget.width,
        height: widget.height,
        color: widget.color,
      );
    } else {
      if (widget.ratio != null) {
        return AspectRatio(
          aspectRatio: widget.ratio!,
          child: CachedNetworkImage(
            imageUrl: url,
            fit: widget.fit ?? BoxFit.fitWidth,
            width: widget.width,
            height: widget.height,
          ),
        );
      }
      if (widget.colorFilter != null) {
        return ColorFiltered(
          colorFilter: widget.colorFilter!,
          child: CachedNetworkImage(
            imageUrl: url,
            fit: widget.fit ?? BoxFit.fitWidth,
            width: widget.width,
            height: widget.height,
          ),
        );
      }
      return CachedNetworkImage(
        imageUrl: url,
        fit: widget.fit ?? BoxFit.fitWidth,
        width: widget.width,
        height: widget.height,
        errorWidget: (_, __, ___) {
          WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
            setState(() {
              isError = true;
            });
          });
          return Image.asset(
            "assets/ic_place_holder.png",
            height: double.infinity,
            fit: widget.fit ?? BoxFit.fill,
          );
        },
      );
    }
  }

  Widget _buildImageAsset(String url) {
    if (url.toString().toLowerCase().endsWith('.svg')) {
      if (widget.ratio != null) {
        return AspectRatio(
          aspectRatio: widget.ratio!,
          child: SvgPicture.asset(
            url,
            fit: widget.fit ?? BoxFit.fitWidth,
            width: widget.width,
            height: widget.height,
            color: widget.color,
          ),
        );
      }
      return SvgPicture.asset(
        url,
        fit: widget.fit ?? BoxFit.fitWidth,
        width: widget.width,
        height: widget.height,
        color: widget.color,
      );
    } else {
      if (widget.ratio != null) {
        return AspectRatio(
          aspectRatio: widget.ratio!,
          child: Image.asset(
            url,
            fit: widget.fit ?? BoxFit.fitWidth,
            width: widget.width,
            height: widget.height,
            color: widget.color,
          ),
        );
      }
      return Image.asset(
              url,
              fit: widget.fit ?? BoxFit.fitWidth,
              width: widget.width,
              height: widget.height,
              color: widget.color,
            );
    }
  }
}
