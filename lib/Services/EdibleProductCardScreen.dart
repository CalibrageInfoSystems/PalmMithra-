// import 'package:akshaya_flutter/Services/models/Godowndata.dart';
import 'package:akshaya_flutter/services/models/Godowndata.dart';

import 'package:akshaya_flutter/Services/models/MsgModel.dart';
import 'package:akshaya_flutter/Services/models/RequestProductDetails.dart';
import 'package:akshaya_flutter/Services/models/SubsidyResponse.dart';
import 'package:akshaya_flutter/models/farmer_model.dart';

import 'SelectedibleProductsScreen.dart';

import 'dart:convert';

import 'package:akshaya_flutter/common_utils/common_styles.dart';
import 'package:akshaya_flutter/common_utils/custom_appbar.dart';
import 'package:akshaya_flutter/common_utils/custom_btn.dart';
import 'package:akshaya_flutter/localization/locale_keys.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../common_utils/SuccessDialog.dart';
import '../common_utils/api_config.dart';
import '../common_utils/shared_prefs_keys.dart';

class EdibleProductCardScreen extends StatefulWidget {
  final List<ProductWithQuantity> products;
  final Godowndata godown;

  const EdibleProductCardScreen({
    super.key,
    required this.products,
    required this.godown,
  });

  @override
  State<EdibleProductCardScreen> createState() => _ProductCardScreenState();
}

class _ProductCardScreenState extends State<EdibleProductCardScreen> {
  int? selectedDropDownValue = -1;
  late double subsidyAmount = 0.0;
  late double payableAmount = 0.0;
  late Future<FarmerModel> farmerData;
  late String farmerCode, farmerName, Statecode, StateName;
  late int Cluster_id;
  bool _isCheckboxChecked = false;
  int _selectedPaymentType = -1;
  late int paymentmodeId = 0;
  List<String> selectedList = [];
  String? selectedName;
  double displayamountWithoutGst = 0.0;
  double displaytotalProductCostGst = 0.0;
  double displaytotalGst = 0.0;
  double displayTransportamountWithoutGst = 0.0;
  double displayTransportamountWithGst = 0.0;
  double displaytotaltransportGst = 0.0;

  double totalProductCostGst = 0.0;
  double totalCGST = 0.0;
  double totalSGST = 0.0;
  double totalTransportCostwithgst = 0.0;
  double totalAmountWithGST = 0.0;
  double amountWithoutGst = 0.0;
  double totalGST = 0.0;
  double TransportamountWithoutGst = 0.0;
  double totalTransportGST = 0.0;
  double totalTransCGST = 0.0;
  double totalTrasSGST = 0.0;
  List<RequestProductDetails> productDetailsList = [];
  bool _isLoading = false; // Track loading state

  // Initial value to indicate no selection
  @override
  void initState() {
    super.initState();
    farmerData = getFarmerInfoFromSharedPrefs();
    print('Selected Godown name: ${widget.godown.name}');
    print('Selected Godown ID: ${widget.godown.id}');
    print('Selected Godown code: ${widget.godown.code}');

    farmerData.then((farmer) {
      print('farmerData==${farmer.code}');
      farmerCode = '${farmer.code}';
      farmerName =
          '${farmer.firstName} ${farmer.middleName ?? ''} ${farmer.lastName}';
      Cluster_id = farmer.clusterId!;
      Statecode = '${farmer.stateCode}';
      StateName = '${farmer.stateName}';
    });
    calculateCosts();
  }

  Future<List<dynamic>> getDropdownData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final farmerCode = prefs.getString(SharedPrefsKeys.farmerCode);
    final apiUrl = '$baseUrl$GetPaymentsTypeByFarmerCode$farmerCode';
    print('GetPaymentsTypeByFarmerCode==$apiUrl');
    // const apiUrl = 'http://182.18.157.215/3FAkshaya/API/api/Farmer/GetPaymentsTypeByFarmerCode/APWGBDAB00010005';

    final jsonResponse = await http.get(Uri.parse(apiUrl));

    if (jsonResponse.statusCode == 200) {
      final response = jsonDecode(jsonResponse.body);
      if (response['listResult'] != null) {
        return response['listResult'] as List<dynamic>;
      } else {
        throw Exception('listResult is empty');
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: tr(LocaleKeys.product_req),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(tr(LocaleKeys.payment_mode),
                      style: CommonStyles.txSty_16black_f5),
                  const SizedBox(width: 5),
                  const Text('*', style: TextStyle(color: Colors.red)),
                ],
              ),
              const SizedBox(height: 5),
              dropdownWidget(),

              // Conditionally display the checkbox
              // if (paymentmodeId == 26)
              //   Row(
              //     children: [
              //       Checkbox(
              //         value: _isCheckboxChecked,
              //         onChanged: (bool? value) {
              //           setState(() {
              //             _isCheckboxChecked = value ?? false;
              //           });
              //         },
              //       ),
              //       Text(tr(LocaleKeys.imdpayment),
              //           style: CommonStyles.txSty_16black_f5),
              //     ],
              //   ),
              const SizedBox(height: 10),

              Text(tr(LocaleKeys.product_details),
                  style: CommonStyles.txSty_16black_f5),
              const SizedBox(height: 5),
              Column(
                children: [
                  ListView.builder(
                    itemCount: widget.products.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return widget.products[index].quantity == 0
                          ? const SizedBox()
                          : productBox(widget.products[index]);
                    },
                  ),
                  const SizedBox(height: 20),
                  CommonStyles.horizontalDivider(colors: [
                    const Color(0xFFFF4500),
                    const Color(0xFFA678EF),
                    const Color(0xFFFF4500),
                  ]),
                  noteBox(),
                  productCostbox(
                      title: tr(LocaleKeys.amount),
                      data: amountWithoutGst.toStringAsFixed(2)),
                  productCostbox(
                      title: tr(LocaleKeys.cgst_amount),
                      data: totalCGST.toStringAsFixed(2)),
                  productCostbox(
                      title: tr(LocaleKeys.sgst_amount),
                      data: totalSGST.toStringAsFixed(2)),
                  productCostbox(
                      title: tr(LocaleKeys.total_amt),
                      data: totalProductCostGst.toStringAsFixed(2)),
                  productCostbox(
                      title: tr(LocaleKeys.transamount),
                      data: TransportamountWithoutGst.toStringAsFixed(2)),
                  productCostbox(
                      title: tr(LocaleKeys.tcgst_amount),
                      data: totalTrasSGST.toStringAsFixed(2)),
                  productCostbox(
                      title: tr(LocaleKeys.tsgst_amount),
                      data: totalTrasSGST.toStringAsFixed(2)),
                  productCostbox(
                      title: tr(LocaleKeys.trnstotal_amt),
                      data: totalTransportCostwithgst.toStringAsFixed(2)),
                  productCostbox(
                      title: tr(LocaleKeys.subsidy_amt),
                      data: subsidyAmount.toStringAsFixed(2)),
                  productCostbox(
                      title: tr(LocaleKeys.amount_payble),
                      data: payableAmount.toStringAsFixed(2)),
                  CommonStyles.horizontalDivider(colors: [
                    const Color(0xFFFF4500),
                    const Color(0xFFA678EF),
                    const Color(0xFFFF4500),
                  ]),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomBtn(
                        label: tr(LocaleKeys.submit),
                        btnTextColor: CommonStyles.primaryTextColor,
                        borderColor: CommonStyles.primaryTextColor,
                        borderRadius: 12,
                        onPressed: () async {
                          // Disable button when loading
                          if (validations()) {
                            if (await isOnline()) {
                              final request = FertilizerRequest(
                                id: 0,
                                requestTypeId: 116,
                                farmerCode: farmerCode,
                                farmerName: farmerName,
                                plotCode: null,
                                requestCreatedDate:
                                    DateTime.now().toIso8601String(),
                                isFarmerRequest: true,
                                createdByUserId: null,
                                createdDate: DateTime.now().toIso8601String(),
                                updatedByUserId: null,
                                updatedDate: DateTime.now().toIso8601String(),
                                godownId: widget.godown.id!,
                                paymentModeType: paymentmodeId,
                                isImmediatePayment: null,
                                fileName: null,
                                fileLocation: null,
                                fileExtension: null,
                                totalCost: totalProductCostGst,
                                subcidyAmount: subsidyAmount,
                                paybleAmount: payableAmount,
                                transportPayableAmount:
                                    totalTransportCostwithgst,
                                comments: null,
                                cropMaintainceDate: null,
                                issueTypeId: null,
                                godownCode: '${widget.godown.code}',
                                requestProductDetails: productDetailsList,
                                clusterId: Cluster_id,
                                stateCode: Statecode,
                                stateName: StateName,
                              );
                              print('CHECK BOX VALUE: $_isCheckboxChecked');
                              await submitFertilizerRequest(request);
                            } else {
                              CommonStyles.showCustomDialog(
                                  context, tr(LocaleKeys.Internet));
                            }
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget productCostbox({
    required String title,
    required String data,
  }) {
    return Column(
      children: [
        CommonStyles.horizontalDivider(colors: [
          const Color(0xFFFF4500),
          const Color(0xFFA678EF),
          const Color(0xFFFF4500),
        ]),
        Row(
          children: [
            Expanded(
                flex: 6,
                child: Text(
                  title,
                  style: CommonStyles.txSty_14p_f5,
                )),
            const Expanded(
                flex: 1,
                child: Text(
                  ':',
                  style: CommonStyles.txSty_14p_f5,
                )),
            Expanded(
                flex: 5,
                child: Text(
                  data,
                  style: CommonStyles.txSty_14p_f5,
                )),
          ],
        ),
      ],
    );
  }

  Container noteBox() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xfffefacb),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tr(LocaleKeys.noteWithOutColon),
            style: CommonStyles.txStyF14CpFF6,
          ),
          Text(
            tr(LocaleKeys.note),
            style: CommonStyles.txStyF14CbFF6,
          ),
        ],
      ),
    );
  }

  Container dropdownWidget() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey),
      ),
      clipBehavior: Clip.antiAlias,
      child: FutureBuilder(
        future: getDropdownData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final paymentModes = snapshot.data as List<dynamic>;
            return filterDropDown(paymentModes);
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                  textAlign: TextAlign.center,
                  snapshot.error.toString().replaceFirst('Exception: ', ''),
                  style: CommonStyles.errorTxStyle),
            );
          }
          return Container(
            padding: const EdgeInsets.all(10),
            child: const Center(child: Text('loading...')),
          );
        },
      ),
    );
  }

  Widget filterDropDown(List<dynamic> paymentModes) {
    return DropdownButtonHideUnderline(
      child: ButtonTheme(
        alignedDropdown: true,
        child: DropdownButton2<int>(
          isExpanded: true,
          items: [
            const DropdownMenuItem<int>(
              value: -1,
              child: Text(
                'Select',
                style: CommonStyles.txSty_14b_f6,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            ...paymentModes.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              return DropdownMenuItem<int>(
                value: index,
                child: Text(
                  item['desc'],
                  style: CommonStyles.txSty_14b_f6,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            }),
          ].toList(),
          value: _selectedPaymentType,
          onChanged: (value) {
            setState(() {
              _selectedPaymentType = value!;
              if (_selectedPaymentType != -1) {
                paymentmodeId = paymentModes[_selectedPaymentType]['typeCdId'];
                final paymentmodeName =
                    paymentModes[_selectedPaymentType]['desc'];

                print('setState paymentmodeId: $paymentmodeId');

                // Adjust the condition for showing the checkbox based on the payment mode ID
                _isCheckboxChecked =
                    false; // Reset the checkbox when changing payment mode
              }
            });
          },
          buttonStyleData: const ButtonStyleData(
            height: 40,
            width: double.infinity,
            padding: EdgeInsets.only(left: 14, right: 14),
          ),
          iconStyleData: const IconStyleData(
            icon: Icon(
              Icons.arrow_drop_down_sharp,
            ),
            iconSize: 24,
            iconEnabledColor: Color(0xFF11528f),
            iconDisabledColor: Color(0xFF11528f),
          ),
          dropdownStyleData: DropdownStyleData(
            decoration: const BoxDecoration(
              // borderRadius: BorderRadius.circular(14),
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(12),
                  bottomLeft: Radius.circular(12)),
              // color: Colors.grey,
              color: CommonStyles.screenBgColor,
            ),
            offset: const Offset(0, 0),
            scrollbarTheme: ScrollbarThemeData(
              radius: const Radius.circular(40),
              thickness: WidgetStateProperty.all<double>(6),
              thumbVisibility: WidgetStateProperty.all<bool>(true),
            ),
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
            padding: EdgeInsets.only(left: 20, right: 20),
          ),
        ),
      ),
    );
  }

  Widget productBox(ProductWithQuantity productinfo) {
    final product = productinfo.product;
    final quantity = productinfo.quantity;
    final productQuantity = product.priceInclGst! * quantity;
    final totalTrasport = product.transPortActualPriceInclGst! * quantity;
    final totalAmount = productQuantity + totalTrasport;
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        // color: Colors.white,
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFCCCCCC),
            Color(0xFFFFFFFF),
            Color(0xFFCCCCCC),
          ],
        ),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(tr(LocaleKeys.product),
                    style: CommonStyles.txStyF14CpFF6),
              ),
              const SizedBox(width: 10),
              Expanded(
                child:
                    Text('${product.name}', style: CommonStyles.txStyF14CpFF6),
              ),
            ],
          ),
          productInfo(
            label1: tr(LocaleKeys.each_product),
            //  label1: 'Item Cost(Rs)',
            data1: '${product.priceInclGst?.toStringAsFixed(2)}',
            label2: tr(LocaleKeys.gst),
            data2: (product.gstPercentage ?? 0.0).toStringAsFixed(1),
          ),
          productInfo(
            label1: tr(LocaleKeys.quantity),
            data1: '$quantity',
            label2: tr(LocaleKeys.amount),
            data2: productQuantity.toStringAsFixed(2),
          ),
          productInfo(
            label1: tr(LocaleKeys.transportprice),
            data1: '${product.transPortActualPriceInclGst?.toStringAsFixed(2)}',
            label2: tr(LocaleKeys.gst),
            data2: '${product.transportGstPercentage?.toStringAsFixed(1)}',
          ),
          productInfo(
            label1: tr(LocaleKeys.totaltransportcost),
            data1: totalTrasport.toStringAsFixed(2),
            label2: tr(LocaleKeys.total_amt),
            data2: totalAmount.toStringAsFixed(2),
          ),
        ],
      ),
    );
  }

  Column productInfo({
    required String label1,
    required String data1,
    required String label2,
    required String data2,
  }) {
    return Column(
      children: [
        CommonStyles.horizontalDivider(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 4, // Adjust the flex value as needed for the label
                    child: Text(label1, style: CommonStyles.txStyF12CbFF6),
                  ),
                  const SizedBox(
                      width: 3), // Optional spacing between label and data
                  Expanded(
                    flex: 2, // Adjust the flex value as needed for the data
                    child: Text(data1, style: CommonStyles.txStyF12CbFF6),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 4, // Adjust the flex value as needed for the label
                    child: Text(label2, style: CommonStyles.txStyF12CbFF6),
                  ),
                  const SizedBox(
                      width: 3), // Optional spacing between label and data
                  Expanded(
                    flex: 2, // Adjust the flex value as needed for the data
                    child: Text(data2, style: CommonStyles.txStyF12CbFF6),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> getFertilizerSubsidies(
      double totalProductCostGst, double totalTransportCostwithgst) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final farmerCode = prefs.getString(SharedPrefsKeys.farmerCode);
    final url = '$baseUrl$fertilizerSubsidies$farmerCode';
    // 'http://182.18.157.215/3FAkshaya/API/api/FertilizerSubsidies/$farmerCode';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final SubsidyResponse subsidyResponse = SubsidyResponse.fromJson(data);

        if (subsidyResponse.isSuccess) {
          setState(() {
            subsidyAmount = subsidyResponse.result.remainingAmount;

            if (subsidyAmount > 0) {
              if (totalProductCostGst < subsidyAmount) {
                payableAmount = 0.0;
                //  payableAmount = totalTransportCostwithgst;
                subsidyAmount = totalProductCostGst;
              } else if (subsidyAmount < totalProductCostGst) {
                // payableAmount = totalProductCostGst - subsidyAmount +
                //     totalTransportCostwithgst;
                payableAmount = totalProductCostGst - subsidyAmount;
              } else {
                payableAmount = totalProductCostGst + totalTransportCostwithgst;
                // payableAmount = totalProductCostGst ;
              }
            } else {
              subsidyAmount = 0.0;
              payableAmount = totalProductCostGst + totalTransportCostwithgst;
              // payableAmount = totalProductCostGst ;
            }

            print("Subsidy Amount: $subsidyAmount");
            print("Payable Amount: $payableAmount");
          });
        }
      } else {
        print("Failed to load data");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> submitFertilizerRequest(FertilizerRequest request) async {
    setState(() {
      _isLoading = true;
    });
// Show the horizontal dots loading dialog after button click
    Future.delayed(Duration.zero, () {
      CommonStyles.showHorizontalDotsLoadingDialog(
          context); // Show loading dialog
    });
    // const url = 'http://182.18.157.215/3FAkshaya/API/api/FertilizerRequest';
    const url = '$baseUrl$productsubRequest';
    //  final response = await http.get(Uri.parse('$baseUrl$GetActivegodowns$stateCode'));
    // Print the request object
    print('Submitting request:');
    print('Request Object: ${jsonEncode(request.toJson())}');

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(request.toJson()),
      );

      print('Request JSON: ${jsonEncode(request.toJson())}');

      if (response.statusCode == 200) {
        // Successfully submitted request
        print('Request submitted successfully');
        print('Response Body: ${response.body}');

        // Process the product list
        for (int i = 0; i < widget.products.length; i++) {
          String productName = widget.products[i].product.name!;
          int quantity = widget.products[i].quantity;
          final product = widget.products[i].product;

          final productCost = product.priceInclGst! * quantity;
          displaytotalProductCostGst += productCost;

          final transportCost = product.transPortActualPriceInclGst! * quantity;
          displayTransportamountWithGst += transportCost;

          final productGSTPercentage = product.gstPercentage ?? 0.0;
          displayamountWithoutGst +=
              productCost / (1 + (productGSTPercentage / 100));

          displaytotalGst =
              displaytotalProductCostGst - displayamountWithoutGst;

          final transportGSTPercentage = product.transportGstPercentage!;
          displayTransportamountWithoutGst +=
              transportCost / (1 + (transportGSTPercentage / 100));

          displaytotaltransportGst =
              displayTransportamountWithGst - displayTransportamountWithoutGst;

          selectedList.add('$productName : $quantity');
        }

        selectedName = selectedList.join(', ');
        List<MsgModel> displayList = [
          MsgModel(key: tr(LocaleKeys.Godown_name), value: widget.godown.name!),
          MsgModel(key: tr(LocaleKeys.product_quantity), value: selectedName!),
          MsgModel(
              key: tr(LocaleKeys.amount),
              value: displayamountWithoutGst.toStringAsFixed(2)),
          MsgModel(
              key: tr(LocaleKeys.gst_amount),
              value: displaytotalGst.toStringAsFixed(2)),
          MsgModel(
              key: tr(LocaleKeys.total_amt),
              value: displaytotalProductCostGst.toStringAsFixed(2)),
          MsgModel(
              key: tr(LocaleKeys.transamount),
              value: displayTransportamountWithoutGst.toStringAsFixed(2)),
          MsgModel(
              key: tr(LocaleKeys.transgst),
              value: displaytotaltransportGst.toStringAsFixed(2)),
          MsgModel(
              key: tr(LocaleKeys.totaltransportcost),
              value: displayTransportamountWithGst.toStringAsFixed(2)),
          MsgModel(
              key: tr(LocaleKeys.subcd_amt),
              value: subsidyAmount.toStringAsFixed(2)),
          MsgModel(
              key: tr(LocaleKeys.amount_payble),
              value: payableAmount.toStringAsFixed(2)),
        ];

        // Show success dialog
        showSuccessDialog(context, displayList, tr(LocaleKeys.success_edible));
      } else {
        print('Failed to submit request: ${response.statusCode}');
        print('Error Response: ${response.body}');
      }
    } catch (e) {
      print('Error occurred: $e');
    } finally {
      setState(() {
        _isLoading = false; // Hide loading
      });
    }
  }

  Future<FarmerModel> getFarmerInfoFromSharedPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final result = prefs.getString(SharedPrefsKeys.farmerData);
    if (result != null) {}
    Map<String, dynamic> response = json.decode(result!);
    Map<String, dynamic> farmerResult = response['result']['farmerDetails'][0];
    return FarmerModel.fromJson(farmerResult);
  }

// Function to show the dialog
  void showSuccessDialog(
      BuildContext context, List<MsgModel> msg, String summary) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PopScope(
            canPop: false, child: SuccessDialog(msg: msg, title: summary));
      },
    );
  }

  void calculateCosts() {
    for (var productWithQuantity in widget.products) {
      if (productWithQuantity.quantity > 0) {
        final product = productWithQuantity.product;
        final quantity = productWithQuantity.quantity;

        final productCost = (product.priceInclGst ?? 0) * quantity;
        totalProductCostGst += productCost;

        final transportCost =
            (product.transPortActualPriceInclGst ?? 0) * quantity;
        totalTransportCostwithgst += transportCost;

        final productGSTPercentage =
            product.gstPercentage ?? 0; // Handle null value
        amountWithoutGst += productCost / (1 + (productGSTPercentage / 100));

        totalGST = totalProductCostGst - amountWithoutGst;
        totalCGST = totalGST / 2;
        totalSGST = totalGST / 2;

        final transportGSTPercentage =
            product.transportGstPercentage ?? 0; // Handle null value
        TransportamountWithoutGst +=
            transportCost / (1 + (transportGSTPercentage / 100));

        totalTransportGST =
            totalTransportCostwithgst - TransportamountWithoutGst;
        totalTransCGST = totalTransportGST / 2;
        totalTrasSGST = totalTransportGST / 2;

        productDetailsList.add(
          RequestProductDetails(
            productId: product.id,
            quantity: quantity,
            bagCost: product.priceInclGst,
            size: product.size,
            gstPersentage: product.gstPercentage,
            productCode: product.code,
            transGstPercentage: product.transportGstPercentage,
            transportCost: product.transPortActualPriceInclGst,
          ),
        );
      }
    }

    // Calculate total amount with GST
    totalAmountWithGST = totalProductCostGst + totalTransportCostwithgst;

    // Call getFertilizerSubsidies only once when the calculation is done
    getFertilizerSubsidies(totalProductCostGst, totalTransportCostwithgst);
  }

  bool validations() {
    print('----- analysis ----->> imdpayment  : $_selectedPaymentType');
    if (_selectedPaymentType == -1) {
      CommonStyles.showCustomDialog(context, tr(LocaleKeys.paym_validation));
      return false;
    }

    return true;
  }

  Future<bool> isOnline() async {
    final ConnectivityResult connectivityResult =
        await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }
}
