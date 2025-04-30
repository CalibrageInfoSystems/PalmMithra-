import 'package:akshaya_flutter/common_utils/custom_btn.dart';
import 'package:akshaya_flutter/gen/assets.gen.dart';
import 'package:akshaya_flutter/gen/fonts.gen.dart';
import 'package:akshaya_flutter/localization/locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shimmer/shimmer.dart';
import 'package:toastification/toastification.dart';

class CommonStyles {
  static const appBarColor = Color(0xfff07566);
  static const viewMoreBtnColor = Color(0xffc4c4c4);
  static const viewMoreBtnTextColor = Color(0xffd0691f);
  static const dataTextColor = Color(0xff707070);
  static const dataTextColor2 = Color(0xff5b3021);
  static const screenBgColor = Color(0xfff4f3f1);
  static const screenBgColor2 = Color(0xffe9e7e8);
  static const tabBarColor = Color(0xffe46f5d);
  static const appBarColor2 = Color(0xffdd6950);
  static const dropdownListBgColor = Color(0xff6f6f6f);
  static const labourTemplateColor = Color(0xff636363);
  static const blackColorShade = Color(0xFF636363);
  static const listOddColor = Color(0xFFdfdfdf);
  static const listEvenColor = Color(0xFFf5f5f5);
  static const primaryTextColor = Color(0xFFe86100);
  static const tabBorderColor = Color(0xFFeb7a00);
  static const impPlacesDataColor = Color(0xFF535353);
  static const btnBorderColor = Color(0xFFe36105);
  static const successDialogHeaderColor = Color(0xFFf2614e);
  static const grycolor = Color(0xFF585858);
  static const lightgry = Color(0xffaaaaaa);
  static const halfback = Color(0xffcb000000);
  // colors
  static const gradientColor1 = Color(0xffDB5D4B);
  static const gradientColor2 = Color(0xffE39A63);
  static const statusBlueBg = Color(0xffc3c8cc);
  static const statusBlueText = Color(0xFF11528f);
  static const statusGreenBg = Color(0xFFe5ffeb);
  static const statusGreenText = Color(0xFF287d02);
  static const statusYellowBg = Color(0xfff8e7cb);
  static const statusYellowText = Color(0xFFd48202);
  static const statusRedBg = Color(0xFFffdedf);
  static const statusRedText = Color.fromARGB(255, 236, 62, 68);
  static const startColor = Color(0xFF59ca6b);
  static const noteColor = Color(0xFFfff7c9);

  static const homeBgColor = Color.fromARGB(255, 253, 236, 216);
  static const homeBorderColor = Color.fromARGB(255, 247, 220, 190);
  static const themeTextColor = Color(0xFFf97316);
  // static const homeBorderColor = Color.fromARGB(255, 245, 203, 151);

  static const blackColor = Colors.black;
  static const dropdownbg = Color(0x8D000000);
  static const primaryColor = Color(0xFAF5F5F5);
  // static const primaryTextColor = Color(0xFFe86100);
  static const formFieldErrorBorderColor = Color(0xFFff0000);
  static const blueColor = Color(0xFF0f75bc);
  static const branchBg = Color(0xFFcfeaff);
  static const primarylightColor = Color(0xffe2f0fd);
  static const greenColor = const Color(0xFF34A350);
  static const whiteColor = Colors.white;
  static const hintTextColor = Color(0xCBBEBEBE);
  static const headercolor = Color(0xDAF05F4E);
  // <color name="colorOrange">#e86100</color>
  // styles #FFC93437
  static const RedColor = Color(0xFFC93437);

  static const txStyF12CbFF6 = TextStyle(
    fontSize: 12,
    fontFamily: FontFamily.hind,
    fontWeight: FontWeight.w600,
    color: blackColor,
  );

  static const txStyF20CbFcF5 = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      fontFamily: 'Calibri',
      color: CommonStyles.blackColor);

  static const txStyF12CpFF6 = TextStyle(
    fontSize: 12,
    fontFamily: FontFamily.hind,
    fontWeight: FontWeight.w600,
    color: primaryTextColor,
  );
  static const txStyF14CpFF6 = TextStyle(
    fontSize: 14,
    fontFamily: FontFamily.hind,
    fontWeight: FontWeight.w600,
    color: primaryTextColor,
  );
  static const txStyF13CpFF6 = TextStyle(
    fontSize: 12,
    fontFamily: FontFamily.hind,
    fontWeight: FontWeight.w600,
    color: primaryTextColor,
  );
  static const txStyF12CwFF6 = TextStyle(
    fontSize: 12,
    fontFamily: FontFamily.hind,
    fontWeight: FontWeight.w600,
    color: whiteColor,
  );

  static const txStyF14CbFF6 = TextStyle(
    fontSize: 14,
    fontFamily: FontFamily.hind,
    fontWeight: FontWeight.w600,
    color: blackColor,
  );
  static const txStyF14bbFF6 = TextStyle(
    fontSize: 14,
    fontFamily: FontFamily.hind,
    fontWeight: FontWeight.w700,
    color: grycolor,
  );
  static const txStyF14CwFF6 = TextStyle(
    fontSize: 14,
    fontFamily: FontFamily.hind,
    fontWeight: FontWeight.w600,
    color: whiteColor,
  );
  static const txStyhalfblack = TextStyle(
    fontSize: 12,
    fontFamily: FontFamily.hind,
    fontWeight: FontWeight.w600,
    color: halfback,
  );

  static const txStyF16CbFF6 = TextStyle(
    fontSize: 16,
    fontFamily: FontFamily.hind,
    fontWeight: FontWeight.w600,
    color: blackColor,
  );

  static const txStyF16CwFF6 = TextStyle(
    fontSize: 16,
    fontFamily: FontFamily.hind,
    fontWeight: FontWeight.w600,
    color: whiteColor,
  );

  static const txStyF20CwFF6 = TextStyle(
    fontSize: 20,
    fontFamily: FontFamily.hind,
    fontWeight: FontWeight.w600,
    color: whiteColor,
  );

  static const TextStyle txStyF14CrFF6 = TextStyle(
    fontSize: 14,
    fontFamily: FontFamily.hind,
    fontWeight: FontWeight.w600,
    color: RedColor,
  );

  static const TextStyle txStyF16CrFF6 = TextStyle(
    fontSize: 16,
    fontFamily: FontFamily.hind,
    fontWeight: FontWeight.w600,
    color: RedColor,
  );

  static const TextStyle txStyF16CpFF6 = TextStyle(
    fontSize: 16,
    fontFamily: FontFamily.hind,
    fontWeight: FontWeight.w600,
    color: primaryTextColor,
  );

  static const TextStyle errorTxStyle = TextStyle(
    fontSize: 18,
    fontFamily: FontFamily.hind,
    fontWeight: FontWeight.w600,
    color: primaryTextColor,
  );

  static const TextStyle txStyF20CgyFF7 = TextStyle(
    fontSize: 20,
    fontFamily: "hind_semibold",
    fontWeight: FontWeight.bold,
    color: hintTextColor,
  );

  /* ...................................... */

  static const TextStyle texthintstyle = TextStyle(
    fontSize: 13,
    fontFamily: "hind_semibold",
    fontWeight: FontWeight.w500,
    color: Colors.grey,
  );

  static const TextStyle txF14Fw5Cb = TextStyle(
    fontSize: 13,
    fontFamily: "hind_semibold",
    fontWeight: FontWeight.w500,
    color: Color.fromARGB(255, 71, 71, 71),
  );

  static const TextStyle txSty_20hint_fb = TextStyle(
    fontSize: 20,
    fontFamily: "hind_semibold",
    fontWeight: FontWeight.w500,
    color: hintTextColor,
  );
  static const TextStyle txSty_14b_f5 = TextStyle(
    fontSize: 13,
    fontFamily: "hind_semibold",
    fontWeight: FontWeight.w500,
    color: blackColor,
  );
  static const TextStyle txSty_14b_f6 = TextStyle(
    fontSize: 14,
    fontFamily: "hind_semibold",
    fontWeight: FontWeight.w600,
    color: blackColor,
  );
  static const TextStyle txSty_14black = TextStyle(
    fontSize: 14,
    fontFamily: "hind_semibold",
    fontWeight: FontWeight.w700,
    color: blackColor,
  );
  static const TextStyle txSty_22b_f5 = TextStyle(
    fontSize: 22,
    fontFamily: "hind_semibold",
    fontWeight: FontWeight.w500,
    color: blackColor,
  );
  static const TextStyle txSty_14p_f5 = TextStyle(
    fontSize: 14,
    fontFamily: "hind_semibold",
    fontWeight: FontWeight.w500,
    color: primaryTextColor,
  );
  static const TextStyle txSty_14g_f5 = TextStyle(
    fontSize: 16,
    fontFamily: "hind_semibold",
    fontWeight: FontWeight.w600,
    color: statusGreenText,
  );
  static const TextStyle txSty_14blu_f5 = TextStyle(
    fontSize: 14,
    fontFamily: "hind_semibold",
    fontWeight: FontWeight.w500,
    color: Color(0xFF0f75bc),
  );
  static const TextStyle txSty_16blu_f5 = TextStyle(
    fontSize: 16,
    fontFamily: "hind_semibold",
    fontWeight: FontWeight.w500,
    color: Color(0xFF0f75bc),
  );
  static const TextStyle txSty_16black_f5 = TextStyle(
    fontSize: 16,
    fontFamily: "hind_semibold",
    fontWeight: FontWeight.w600,
    color: Color(0xFF5f5f5f),
  );
  static const TextStyle txSty_14black_f5 = TextStyle(
    fontSize: 14,
    fontFamily: "hind_semibold",
    fontWeight: FontWeight.w500,
    color: Color(0xFF5f5f5f),
  );
  static const TextStyle txSty_16p_fb = TextStyle(
    fontSize: 16,
    fontFamily: "hind_semibold",
    fontWeight: FontWeight.bold,
    color: primaryTextColor,
  );
  static const TextStyle txSty_18b_fb = TextStyle(
    fontSize: 18,
    color: Colors.black,
    fontWeight: FontWeight.w600,
    fontFamily: 'hind_semibold',
  );
  static const TextStyle txSty_16b6_fb = TextStyle(
    fontSize: 16,
    color: Colors.black,
    fontWeight: FontWeight.w600,
    fontFamily: 'hind_semibold',
  );
  static const TextStyle txSty_16b_fb = TextStyle(
    fontSize: 16,
    color: Colors.black,
    fontWeight: FontWeight.w500,
    fontFamily: 'hind_semibold',
  );
  static const TextStyle txSty_14b_fb = TextStyle(
    fontSize: 14,
    color: Colors.black,
    fontWeight: FontWeight.w700,
    fontFamily: 'hind_semibold',
  );
  static const TextStyle txSty_12p_f5 = TextStyle(
    fontSize: 12,
    fontFamily: "hind_semibold",
    fontWeight: FontWeight.w500,
    color: primaryTextColor,
  );
  static const TextStyle header_Styles = TextStyle(
    fontSize: 26,
    fontFamily: "hind_semibold",
    fontWeight: FontWeight.w700,
    color: Color(0xFF0f75bc),
  );
  static const TextStyle txSty_16w_fb = TextStyle(
    fontSize: 16,
    fontFamily: "hind_semibold",
    fontWeight: FontWeight.bold,
    color: whiteColor,
  );
  static const TextStyle txSty_14w_fb = TextStyle(
    fontSize: 14,
    fontFamily: "hind_semibold",
    fontWeight: FontWeight.bold,
    color: whiteColor,
  );
  static const TextStyle txSty_24w = TextStyle(
      fontSize: 24,
      fontFamily: "hind_semibold",
      fontWeight: FontWeight.bold,
      color: whiteColor,
      letterSpacing: 1);
  static const TextStyle txSty_16p_f5 = TextStyle(
    fontSize: 16,
    fontFamily: "hind_semibold",
    fontWeight: FontWeight.w500,
    color: primaryTextColor,
  );
  static const TextStyle txSty_20p_fb = TextStyle(
    fontSize: 20,
    fontFamily: "hind_semibold",
    fontWeight: FontWeight.w700,
    color: primaryTextColor,
    letterSpacing: 2,
  );
  static const TextStyle txSty_20b_fb = TextStyle(
    fontSize: 20,
    fontFamily: "hind_semibold",
    fontWeight: FontWeight.bold,
    color: blackColor,
  );

  static const TextStyle txSty_12b_fb = TextStyle(
      fontFamily: 'hind_semibold',
      fontSize: 12,
      color: Color(0xFF000000),
      fontWeight: FontWeight.w500);
  static const TextStyle txSty_14SB_fb = TextStyle(
      fontFamily: 'hind_semibold',
      fontSize: 12,
      color: Color(0xFF000000),
      fontWeight: FontWeight.w600);
  static const TextStyle txSty_12bl_fb = TextStyle(
    fontFamily: 'hind_semibold',
    fontSize: 12,
    color: Color(0xA1000000),
  );
  static const TextStyle txSty_12W_fb = TextStyle(
      fontFamily: 'hind_semibold',
      fontSize: 12,
      color: whiteColor,
      fontWeight: FontWeight.w600);
  static const TextStyle txSty_12blu_fb = TextStyle(
    fontFamily: 'hind_semibold',
    fontSize: 12,
    color: Color(0xFF8d97e2),
  );
  static const TextStyle txSty_20black_fb = TextStyle(
    fontSize: 20,
    fontFamily: "hind_semibold",
    color: blackColor,
  );
  static const TextStyle txSty_20blu_fb = TextStyle(
    fontSize: 20,
    fontFamily: "hind_semibold",
    fontWeight: FontWeight.w700,
    color: primaryTextColor,
  );
  static const TextStyle txSty_20w_fb = TextStyle(
    fontSize: 20,
    fontFamily: "hind_semibold",
    color: whiteColor,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle text16white = TextStyle(
    fontSize: 16,
    fontFamily: "hind_semibold",
    fontWeight: FontWeight.w600,
    color: CommonStyles.whiteColor,
  );
  static const TextStyle text14white = TextStyle(
    fontSize: 14,
    fontFamily: "hind_semibold",
    fontWeight: FontWeight.w600,
    color: CommonStyles.whiteColor,
  );

  static TextStyle dayTextStyle =
      const TextStyle(color: Colors.black, fontWeight: FontWeight.w700);

  static const TextStyle text18orange = TextStyle(
    fontSize: 18,
    fontFamily: "hind_semibold",
    fontWeight: FontWeight.w600,
    color: primaryTextColor,
  );
  static const TextStyle text14orange = TextStyle(
    fontSize: 14,
    fontFamily: "hind_semibold",
    fontWeight: FontWeight.w600,
    color: primaryTextColor,
  );
  static const TextStyle text18orangeeader = TextStyle(
    fontSize: 14,
    fontFamily: "hind_semibold",
    fontWeight: FontWeight.w600,
    color: headercolor,
  );

  static Widget rectangularShapeShimmerEffect(
      {double? height = 140, double? separatorHeight = 10}) {
    return ListView.separated(
      itemCount: 4,
      itemBuilder: (context, index) => Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          height: height,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
      separatorBuilder: (context, index) => SizedBox(height: separatorHeight),
    );
  }

  static void customDialognew(BuildContext context, Widget child) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (context, animation1, animation2) {
        return Center(
          child: Material(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            child: Stack(
              children: [
                child,
                Positioned(
                  top: 4.0,
                  right: 4.0,
                  child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Image.asset(
                        Assets.images.cancel.path,
                        height: 20,
                        width: 20,
                      )),
                ),
              ],
            ),
          ),
        );
      },
      transitionBuilder: (context, animation1, animation2, child) {
        return ScaleTransition(
          scale: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: animation1,
              curve: Curves.easeOutBack,
            ),
          ),
          child: child,
        );
      },
    );
  }

  static Widget snapshotError(Object? error) {
    return Center(
      child: Text(error.toString().replaceFirst('Exception: ', ''),
          style: CommonStyles.txStyF16CpFF6),
    );
  }

  static Future<bool> checkInternetConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return true; // Connected to the internet
    } else {
      return false; // Not connected to the internet
    }
  }

  void showCustomToastMessageLong(
    String message,
    BuildContext context,
    int backgroundColorType,
    int length,
  ) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double textWidth = screenWidth / 1.5; // Adjust multiplier as needed

    final double toastWidth = textWidth + 32.0; // Adjust padding as needed
    final double toastOffset = (screenWidth - toastWidth) / 2;

    OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (BuildContext context) => Positioned(
        bottom: 16.0,
        left: toastOffset,
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          child: Container(
            width: toastWidth,
            decoration: BoxDecoration(
              border: Border.all(
                color: backgroundColorType == 0 ? Colors.green : Colors.red,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: Center(
                child: Text(
                  message,
                  style: const TextStyle(fontSize: 16.0, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(overlayEntry);
    Future.delayed(Duration(seconds: length)).then((value) {
      overlayEntry.remove();
    });
  }

  static void showCustomToast(
    BuildContext context, {
    required String title,
  }) {
    toastification.show(
      context: context,
      type: ToastificationType.success,
      style: ToastificationStyle.flat,
      autoCloseDuration: const Duration(seconds: 3),
      title: Text(title),
      alignment: Alignment.bottomCenter,
      icon: Image.asset(Assets.images.icLogo.path, width: 30, height: 30),
      showProgressBar: false,
      showIcon: true,
      backgroundColor: CommonStyles.screenBgColor,
      foregroundColor: CommonStyles.primaryTextColor,
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 33, vertical: 8),
      borderRadius: BorderRadius.circular(32),
    );
  }

  static void showCustomDialog(BuildContext context, String msg,
      {void Function()? onPressed, bool barrierDismissible = true}) {
    showGeneralDialog(
      context: context,
      barrierLabel: '',
      barrierDismissible: barrierDismissible,
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (context, animation1, animation2) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
            side: const BorderSide(
                color: Color(0x8D000000),
                width: 2.0), // Adding border to the dialog
          ),
          child: Container(
            color: blackColor,
            padding: const EdgeInsets.all(0.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // Header with "X" icon and "Error" text
                Container(
                  padding: const EdgeInsets.all(10.0),
                  color: RedColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.close, color: Colors.white),
                      const SizedBox(width: 12.0),
                      Text(tr(LocaleKeys.error), style: txStyF20CwFF6),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                // Message Text
                Text(
                  msg,
                  textAlign: TextAlign.center,
                  style: text16white,
                ),
                const SizedBox(height: 20.0),
                // OK Button
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(20.0), // Rounded corners
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFFCCCCCC), // Start color (light gray)
                          Color(0xFFFFFFFF), // Center color (white)
                          Color(0xFFCCCCCC), // End color (light gray)
                        ],
                      ),
                      border: Border.all(
                        color: const Color(0xFFe86100), // Orange border color
                        width: 2.0,
                      ),
                    ),
                    child: SizedBox(
                      height: 30.0, // Set the desired height
                      child: ElevatedButton(
                        onPressed: onPressed ??
                            () {
                              Navigator.of(context).pop();
                            },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 35.0),
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        child: Text(
                          tr(LocaleKeys.ok),
                          style: txStyF16CbFF6,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
      transitionBuilder: (context, animation1, animation2, child) {
        return ScaleTransition(
          scale: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: animation1,
              curve: Curves.easeOutBack, // Customize the animation curve here
            ),
          ),
          child: child,
        );
      },
    );
  }

  static DateTime? parseDateString(String? dateString) {
    print('Parsing date: $dateString');
    if (dateString == null || dateString.isEmpty) {
      return null;
    }
    try {
      DateFormat dateFormat = DateFormat('d/M/yyyy');
      return dateFormat.parse(dateString);
    } catch (e) {
      print("Error parsing date: $e");
      return null;
    }
  }

  static String? formatDate(String? date) {
    if (date != null) {
      DateFormat formatter = DateFormat('dd/MM/yyyy');
      DateTime parsedDate = DateTime.parse(date);
      return formatter.format(parsedDate);
    } else {
      return date;
    }
  }

  static String? formatDisplayDate(DateTime? date) {
    if (date == null) {
      return null;
    }
    DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    return dateFormat.format(date);
  }

  static String? formatApiDate(DateTime? date) {
    if (date == null) {
      return null;
    }
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    return dateFormat.format(date);
  }

  static void customDialog(
    BuildContext context,
    Widget child, {
    BorderRadiusGeometry? borderRadius,
  }) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (context, animation1, animation2) {
        return Center(
          child: Material(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                  borderRadius: borderRadius ?? BorderRadius.circular(10)),
              child: child),
        );
      },
      transitionBuilder: (context, animation1, animation2, child) {
        return ScaleTransition(
          scale: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: animation1,
              curve: Curves.easeOutBack,
            ),
          ),
          child: child,
        );
      },
    );
  }

  static void errorDialog(
    BuildContext context, {
    bool isHeader = true,
    Widget? errorIcon,
    String? errorLabel,
    Color? errorHeaderColor = const Color(0xffc93436),
    Color? btnTextColor = CommonStyles.blackColor,
    Widget? errorBodyWidget,
    Widget? errorActions,
    required String errorMessage,
    bool barrierDismissible = true,
    Color? bodyBackgroundColor = CommonStyles.blackColor,
    Color? borderColor,
    Color? errorMessageColor = CommonStyles.whiteColor,
    void Function()? onPressed,
  }) {
    final size = MediaQuery.of(context).size;
    showGeneralDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierLabel: '',
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (context, animation1, animation2) {
        return Center(
          child: Material(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                  side: BorderSide(
                    color: borderColor ?? const Color(0xffc93436),
                  )),
              child: SizedBox(
                width: size.width * 0.8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isHeader)
                      errorIcon != null
                          ? Container(
                              alignment: Alignment.center,
                              color: errorHeaderColor,
                              child: errorIcon)
                          : Container(
                              height: 50,
                              alignment: Alignment.center,
                              color: errorHeaderColor,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.close, color: Colors.white),
                                  const SizedBox(width: 7),
                                  Text(tr(LocaleKeys.error),
                                      style: CommonStyles.txStyF16CwFF6),
                                ],
                              )),
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(12.0),
                      // height: 120,
                      color: bodyBackgroundColor,
                      child: Column(
                        children: [
                          errorBodyWidget ??
                              Text(
                                errorMessage,
                                textAlign: TextAlign.center,
                                style: CommonStyles.txStyF16CbFF6
                                    .copyWith(color: errorMessageColor),
                              ),
                          const SizedBox(height: 20),
                          errorActions ??
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomBtn(
                                      label: tr(LocaleKeys.ok),
                                      btnTextColor: btnTextColor,
                                      onPressed: onPressed ??
                                          () {
                                            Navigator.of(context).pop();
                                          }),
                                ],
                              ),
                        ],
                      ),
                    )
                  ],
                ),
              )),
        );
      },
      transitionBuilder: (context, animation1, animation2, child) {
        return ScaleTransition(
          scale: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: animation1,
              curve: Curves.easeOutBack, // Customize the animation curve here
            ),
          ),
          child: child,
        );
      },
    );
  }

  static void showHorizontalDotsLoadingDialog(BuildContext context,
      {String message = "Please Wait...",
      int dotCount = 5,
      bool canPop = true}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return PopScope(
          canPop: canPop,
          child: Dialog(
              backgroundColor: Colors.transparent,
              child: Container(
                width: MediaQuery.of(context).size.width / 1.5,
                height: 100.0,
                color: Colors.black,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      message,
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 20),
                    SpinKitHorizontalDots(
                      color: const Color(0xFFe86100),

                      dotCount: dotCount, // Number of dots
                    ),
                  ],
                ),
              )),
        );
      },
    );
  }

  static Widget horizontalDivider({
    List<Color>? colors,
    double? height = 0.5,
    EdgeInsetsGeometry? margin = const EdgeInsets.symmetric(vertical: 2),
    Color? color = const Color(0xFFe86100),
  }) {
    return Container(
      height: height,
      margin: margin,
      color: color,
    );
  }

  static void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
    );
  }

  static Widget horizontalGradientDivider2(
      {List<Color>? colors, double? height = 0.4}) {
    return Container(
      height: height,
      margin: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors ??
              [
                //  e86100
                const Color(0xFFe86100),
                const Color(0xFFe86100),
                const Color(0xFFe86100),
              ],
        ),
      ),
    );
  }

  static Widget horizontalGradien_Divider2(
      {List<Color>? colors, double? height = 0.4}) {
    return Container(
      height: height,
      margin: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors ??
              [
                //  FF4500
                const Color(0xFFFF4500),
                const Color(0xFFA678EF),
                const Color(0xFFFF4500),
              ],
        ),
      ),
    );
  }

  static void hideHorizontalDotsLoadingDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

  static void _showErrorDialog(BuildContext context, String message) {
    Future.delayed(Duration.zero, () {
      CommonStyles.showCustomDialog(context, message);
    });
  }
}

class SpinKitHorizontalDots extends StatefulWidget {
  final Color color;
  final double size;
  final int dotCount;
  final double dotSpacing;

  const SpinKitHorizontalDots({
    super.key,
    required this.color,
    this.size = 30.0,
    this.dotSpacing = 8.0,
    this.dotCount = 5, // Number of dots
  });

  @override
  SpinKitHorizontalDotsState createState() => SpinKitHorizontalDotsState();
}

class SpinKitHorizontalDotsState extends State<SpinKitHorizontalDots>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: false);

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final totalWidth =
        widget.size + (widget.dotSpacing * (widget.dotCount - 1));
    final dotSize = widget.size / widget.dotCount;

    return SizedBox(
      width: totalWidth,
      height: dotSize,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Stack(
            children: List.generate(widget.dotCount, (index) {
              final offset = _animation.value * (totalWidth + dotSize);
              final double position =
                  (offset - index * (dotSize + widget.dotSpacing)) %
                      (totalWidth + dotSize);

              return Positioned(
                left: position - dotSize,
                child: Container(
                  width: dotSize,
                  height: dotSize,
                  decoration: BoxDecoration(
                    color: widget.color,
                    shape: BoxShape.circle,
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
