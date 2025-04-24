import 'dart:async';

import 'package:akshaya_flutter/common_utils/common_styles.dart';
import 'package:akshaya_flutter/gen/assets.gen.dart';
import 'package:akshaya_flutter/localization/locale_keys.dart';
import 'package:auto_animated/auto_animated.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:url_launcher/url_launcher.dart';

class CommonWidgets {
  static Widget commonRow({
    required String label,
    required String data,
    Color? labelTextColor,
    Color? dataTextColor = CommonStyles.dataTextColor,
    bool isColon = false,
    TextStyle? style,
    bool isSpace = true,
    List<int> flex = const [6, 1, 7],
  }) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: flex[0],
              child: Text(
                label,
                style: style ??
                    CommonStyles.txStyF14CbFF6.copyWith(
                      color: labelTextColor,
                    ),
              ),
            ),
            isColon
                ? Expanded(
                    flex: flex[1],
                    child: Text(
                      ':',
                      style: style ?? CommonStyles.txStyF14CbFF6,
                    ))
                : const SizedBox(width: 10),
            Expanded(
              flex: flex[2],
              child: Text(
                data,
                style: style ??
                    CommonStyles.txStyF14CbFF6.copyWith(
                      color: dataTextColor,
                    ),
              ),
            ),
          ],
        ),
        if (isSpace) const SizedBox(height: 10),
      ],
    );
  }

  static Widget commonRowWithColon(
      {required String label,
      required String data,
      Color? dataTextColor,
      TextAlign? textAlign = TextAlign.start,
      TextStyle? style = CommonStyles.txStyF14CbFF6,
      List<int> flex = const [5, 1, 6],
      bool isSpace = true}) {
    return Column(
      children: [
        if (isSpace) const SizedBox(height: 5),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: flex[0],
                child: Text(
                  label,
                  textAlign: textAlign,
                  style: style,
                )),
            Expanded(
              flex: flex[1],
              child: Text(
                ':',
                style: style,
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              flex: flex[2],
              child: Text(
                data,
                textAlign: textAlign,
                style: style?.copyWith(
                  color: dataTextColor,
                ),
              ),
            ),
          ],
        ),
        if (isSpace) const SizedBox(height: 5),
      ],
    );
  }

  static Widget viewTemplate({
    Color? bgColor = Colors.white,
    required Widget child,
    void Function()? onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: bgColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10).copyWith(top: 10),
            child: child,
          ),
          GestureDetector(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: CommonStyles.listOddColor,
              ),
              child: Text(
                tr(LocaleKeys.complete_details),
                style: CommonStyles.txStyF16CbFF6.copyWith(
                    color: CommonStyles.viewMoreBtnTextColor,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget customSlideAnimation(
      {required int itemCount,
      bool isSeparatorBuilder = false,
      required Widget Function(int index) childBuilder}) {
    return LiveList.options(
      options: const LiveOptions(
        delay: Duration(milliseconds: 100),
        showItemInterval: Duration(milliseconds: 100),
        showItemDuration: Duration(milliseconds: 500),
        reAnimateOnVisibility: false,
      ),
      itemCount: itemCount,
      separatorBuilder: (context, index) =>
          isSeparatorBuilder ? const SizedBox(height: 10) : const SizedBox(),
      itemBuilder: (context, index, animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.3),
              end: Offset.zero,
            ).animate(animation),
            child: childBuilder(index),
          ),
        );
      },
    );
  }

  static Future<void> launchDatePicker(
    BuildContext context, {
    DateTime? initialDate,
    Function(DateTime? pickedDay)? onDateSelected,
  }) async {
    final DateTime currentDate = DateTime.now();
    final DateTime firstDate = DateTime(currentDate.year - 100);
    final DateTime? pickedDay = await showDatePicker(
        context: context,
        initialDate: initialDate ?? DateTime.now(),
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        firstDate: firstDate,
        lastDate: currentDate,
        initialDatePickerMode: DatePickerMode.day,
        confirmText: tr(LocaleKeys.ok),
        cancelText: tr(LocaleKeys.cancel_capitalized));
    onDateSelected?.call(pickedDay);
  }

  static customDivider(
      {double? height = 0.5, Color? color = const Color(0xFFe86100)}) {
    return Container(
      height: height,
      color: color,
    );
  }

  static Future<void> makePhoneCall(BuildContext context,
      {required String? data}) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: data,
    );
    final result = await launchUrl(launchUri);
    if (!result) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unable to make call')),
      );
    }
  }

  static void customShowZoomedAttachment(BuildContext context,
      {required String imagePath}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            width: double.infinity,
            height: 500,
            child: Stack(
              children: [
                Center(
                  child: FutureBuilder(
                    future: _loadImage(imagePath),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Image.asset(
                              Assets.images.noproductImage
                                  .path, // Path to your error image
                              fit: BoxFit.cover,
                            ),
                          );
                        }
                        return PhotoViewGallery.builder(
                          itemCount: 1,
                          builder: (context, index) {
                            return PhotoViewGalleryPageOptions(
                              imageProvider:
                                  NetworkImage(imagePath, scale: 1.0),
                              minScale: PhotoViewComputedScale.contained,
                              maxScale: PhotoViewComputedScale.contained,
                            );
                          },
                          scrollDirection: Axis.vertical,
                          backgroundDecoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                        );
                      } else {
                        return Center(
                          child: Image.asset(
                            Assets.images.noproductImage.path,
                            fit: BoxFit.cover,
                          ),
                        );
                      }
                    },
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20)),
                      child: const Icon(
                        Icons.close,
                        color: Colors.red,
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Future<void> _loadImage(String url) async {
    final completer = Completer<void>();
    final img = Image.network(url);

    img.image.resolve(const ImageConfiguration()).addListener(
          ImageStreamListener(
            (info, _) => completer.complete(),
            onError: (error, stackTrace) => completer.completeError(error),
          ),
        );
    await completer.future;
  }
}
