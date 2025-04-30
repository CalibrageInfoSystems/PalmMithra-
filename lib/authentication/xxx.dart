// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'dart:io';

import 'package:akshaya_flutter/authentication/login_otp_screen.dart';
import 'package:akshaya_flutter/common_utils/api_config.dart';
import 'package:akshaya_flutter/common_utils/common_styles.dart';
import 'package:akshaya_flutter/gen/assets.gen.dart';
import 'package:akshaya_flutter/localization/locale_keys.dart';
import 'package:akshaya_flutter/models/FarmerResponseModel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
// import 'package:qrscan/qrscan.dart' as scanner;
import 'package:qrscan/qrscan.dart' as scanner;

class Xxx extends StatefulWidget {
  const Xxx({super.key});

  @override
  State<Xxx> createState() => _XxxState();
}

class _XxxState extends State<Xxx> {
  final TextEditingController _farmercodeController = TextEditingController();
  String farmercode = "";

  String? farmerMobileNumber;
  bool _isLoading = false;
  late String _mobileNumber;

  @override
  initState() {
    super.initState();
    _farmercodeController.text = "APWGBDAB00010001";
  }

  @override
  void dispose() {
    _farmercodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          if (Platform.isAndroid) {
            // Close the app on Android
            SystemNavigator.pop();
            return Future.value(false); // Do not navigate back
          } else if (Platform.isIOS) {
            // Close the app on iOS
            exit(0);
          }
          return Future.value(
              true); // Default behavior (navigate back) if not Android or iOS
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Image.asset(
                    Assets.images.farmerAppLogin.path,
                    // 'assets/images/farmer_app_login.jpg',
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  /*  Container(
                    color: const Color(0x8D000000),
                  ), */
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            'PALM MITRA',
                            style: CommonStyles.txStyF20CwFF6.copyWith(
                              fontSize: 30,
                              color: CommonStyles.loginBtnColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // Image.asset(
                          //   Assets.images.palm360Logo.path,
                          // ),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              " Grower Id",
                              style: TextStyle(
                                  color: CommonStyles.loginBtnColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        TextFormField(
                          controller: _farmercodeController,
                          decoration: InputDecoration(
                            hintText: tr(LocaleKeys.farmar_id),
                            filled: true,
                            fillColor: CommonStyles.whiteColor,
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: CommonStyles.themeTextColor,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: CommonStyles.themeTextColor,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            hintStyle: CommonStyles.txStyF20CwFF6.copyWith(
                              color: Colors.grey.shade500,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 15),
                            alignLabelWithHint: true,
                          ),
                          // textAlign: TextAlign.center,
                          style: CommonStyles.txStyF20CwFF6.copyWith(
                            color: Colors.black,
                          ),
                          textCapitalization: TextCapitalization.characters,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[A-Z0-9]')),
                          ],
                        ),
                        /* Padding(
                          padding: const EdgeInsets.only(top: 22.0),
                          child: SizedBox(
                            width: double.infinity,
                            // Makes the button take up the full width of its parent
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    20.0), // Rounded corners
                                gradient: const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color(
                                        0xFFCCCCCC), // Start color (light gray)
                                    Color(0xFFFFFFFF), // Center color (white)
                                    Color(0xFFCCCCCC), // End color (light gray)
                                  ],
                                ),
                                border: Border.all(
                                  color: const Color(
                                      0xFFe86100), // Orange border color
                                  width: 2.0,
                                ),
                              ),
                              child: ElevatedButton(
                                onPressed: () async {
                                  FocusScope.of(context).unfocus();
                                  bool validationSuccess =
                                      await isvalidations();
                                  if (validationSuccess) {
                                    onLoginPressed();
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 0),
                                  backgroundColor: Colors
                                      .transparent, // Transparent to show the gradient
                                  shadowColor: Colors
                                      .transparent, // Remove button shadow
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                                child: Text(
                                  tr(LocaleKeys.login),
                                  style: CommonStyles.txSty_16p_fb,
                                  // style: CommonStyles.text18orange,
                                ),
                              ),
                            ),
                          ),
                        ), */
                        const SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            FocusScope.of(context).unfocus();
                            bool validationSuccess = await isvalidations();
                            if (validationSuccess) {
                              onLoginPressed();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: CommonStyles.loginBtnColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 15),
                            minimumSize: Size(double.infinity, 0),
                          ),
                          child: Text(
                            tr(LocaleKeys.login),
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                        SizedBox(height: 20),
                        /* Padding(
                          padding: const EdgeInsets.only(top: 6.0),
                          child: Container(
                            alignment: AlignmentDirectional.center,
                            child: Text(
                              tr(LocaleKeys.or),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ), */
                        Row(
                          children: [
                            Expanded(
                                child:
                                    Divider(color: Colors.grey, thickness: 1)),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                'OR',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 16),
                              ),
                            ),
                            Expanded(
                                child:
                                    Divider(color: Colors.grey, thickness: 1)),
                          ],
                        ),
                        SizedBox(height: 20),
                        /* Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: SizedBox(
                            width: double.infinity,
                            // Makes the button take up the full width of its parent
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    20.0), // Rounded corners
                                gradient: const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color(
                                        0xFFCCCCCC), // Start color (light gray)
                                    Color(0xFFFFFFFF), // Center color (white)
                                    Color(0xFFCCCCCC), // End color (light gray)
                                  ],
                                ),
                                border: Border.all(
                                  color: const Color(
                                      0xFFe86100), // Orange border color
                                  width: 2.0,
                                ),
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  print('scan btn clicked');
                                  _scanQR();
                                },
                                style: ElevatedButton.styleFrom(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 0),
                                  backgroundColor: Colors
                                      .transparent, // Transparent to show the gradient
                                  shadowColor: Colors
                                      .transparent, // Remove button shadow
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                                child: Text(
                                  tr(LocaleKeys.scan_qr),
                                  style: CommonStyles.txSty_16p_fb,
                                  // style: CommonStyles.text18orange,
                                ),
                              ),
                            ),
                          ),
                        ),
                         */

                        ElevatedButton(
                          onPressed: _scanQR,
                          /* style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF4CAF50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 15),
                            minimumSize: Size(double.infinity, 0),
                          ), */
                          style: ElevatedButton.styleFrom(
                            backgroundColor: CommonStyles.loginBtnColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 15),
                            minimumSize: Size(double.infinity, 0),
                          ),
                          child: Text(
                            tr(LocaleKeys.scan_qr),
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Future<void> onLoginPressed() async {
    String farmerIdText = _farmercodeController.text.trim();
    if (farmerIdText.isNotEmpty) {
      farmercode = farmerIdText.replaceAll(" ", "");
      print("former==id: $farmercode");

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('farmerid', farmercode);
      bool isConnected = await CommonStyles.checkInternetConnectivity();
      if (isConnected) {
        // Call your login function here
        getLogin();
      } else {
        print("Please check your internet connection.");
        //showDialogMessage(context, "Please check your internet connection.");
      }
    } else {
      // showDialogMessage(context, "Please enter Grower ID.");
    }
  }

  void getLogin() async {
    // Ensure that the keyboard is hidden and the focus is removed
    FocusScope.of(context).unfocus();

    // Prevent further actions if already loading
    if (_isLoading) return;

    setState(() {
      CommonStyles.showHorizontalDotsLoadingDialog(
          context); // Show loading dialog
      _isLoading = true;
    });

    final farmerId = _farmercodeController.text.trim();
    print("farmerId==255: $farmerId");
    final apiUrl = '$baseUrl$Farmer_ID_CHECK$farmerId/null';
    try {
      final jsonResponse = await http.get(Uri.parse(apiUrl));
      print("farmerId==259: $jsonResponse");
      print("farmerId==260: ${jsonResponse.statusCode}");

      if (jsonResponse.statusCode == 200) {
        final response = jsonDecode(jsonResponse.body);
        final farmerResponseModel = FarmerResponseModel.fromJson(response);
        print("farmerId==266: ${farmerResponseModel.isSuccess!}");
        if (farmerResponseModel.isSuccess!) {
          if (farmerResponseModel.result != null) {
            _mobileNumber = farmerResponseModel.result!;
            print('mobile_number=== $_mobileNumber');
            CommonStyles.hideHorizontalDotsLoadingDialog(context);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => LoginOtpScreen(mobile: _mobileNumber),
              ),
            );
            // context.go('${Routes.loginOtpScreen.path}/$_mobileNumber');
          } else {
            CommonStyles.hideHorizontalDotsLoadingDialog(context);
            _showErrorDialog('No Registered Mobile Number to Send OTP');
          }
        } else {
          CommonStyles.hideHorizontalDotsLoadingDialog(context);
          _showErrorDialog('Invalid Farmer');
        }
      } else {
        CommonStyles.hideHorizontalDotsLoadingDialog(context);
        _showErrorDialog('Server Not Responding, Please Try Again');
      }
    } catch (e) {
      print('Error: $e');
      CommonStyles.hideHorizontalDotsLoadingDialog(context);
      _showErrorDialog('$e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _scanQR() async {
    String cameraScanResult = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", "Cancel", false, ScanMode.DEFAULT);
    print('cameraScanResult: $cameraScanResult');
    if (cameraScanResult != '-1') {
      setState(() {
        _farmercodeController.text = cameraScanResult;
      });
    }
  }

  Future<bool> isvalidations() async {
    bool isValid = true;

    if (_farmercodeController.text.isEmpty) {
      CommonStyles.showCustomDialog(context, ' Enter Grower Id');
      isValid = false;
    }

    return isValid;
  }

  void _showErrorDialog(String message) {
    Future.delayed(Duration.zero, () {
      CommonStyles.showCustomDialog(context, message);
    });
  }
}
