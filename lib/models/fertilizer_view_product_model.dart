import 'dart:convert';

FetilizerViewProduct fetilizerViewProductFromJson(String str) =>
    FetilizerViewProduct.fromJson(json.decode(str));

String fetilizerViewProductToJson(FetilizerViewProduct data) =>
    json.encode(data.toJson());

class FetilizerViewProduct {
  String? requestCode;
  int? productId;
  String? productCode;
  String? godownCode;
  String? name;
  int? quantity;
  double? bagCost;
  String? farmerCode;
  double? bagSize;
  String? size;
  double? amount;
  double? gstPercentage;
  double? cgstPercentage;
  double? sgstPercentage;
  double? cgst;
  double? sgst;
  double? basePrice;
  double? transPortGstPercentage;
  double? transPortCgstPercentage;
  double? transPortSgstPercentage;
  double? transPortCgst;
  double? transPortSgst;
  double? transportBasePrice;
  double? transPortAmount;
  double? transPortTotalAmount;
  double? transPortCost;
  double? totalAmount;
  DateTime? closedDate;
  double? requestTotalAmount;
  double? requestTotalTransport;
  int? licenseTypeId;
  String? licenceType;

  FetilizerViewProduct({
    this.requestCode,
    this.productId,
    this.productCode,
    this.godownCode,
    this.name,
    this.quantity,
    this.bagCost,
    this.farmerCode,
    this.bagSize,
    this.size,
    this.amount,
    this.gstPercentage,
    this.cgstPercentage,
    this.sgstPercentage,
    this.cgst,
    this.sgst,
    this.basePrice,
    this.transPortGstPercentage,
    this.transPortCgstPercentage,
    this.transPortSgstPercentage,
    this.transPortCgst,
    this.transPortSgst,
    this.transportBasePrice,
    this.transPortAmount,
    this.transPortTotalAmount,
    this.transPortCost,
    this.totalAmount,
    this.closedDate,
    this.requestTotalAmount,
    this.requestTotalTransport,
    this.licenseTypeId,
    this.licenceType,
  });

  factory FetilizerViewProduct.fromJson(Map<String, dynamic> json) =>
      FetilizerViewProduct(
        requestCode: json["requestCode"],
        productId: json["productId"],
        productCode: json["productCode"],
        godownCode: json["godownCode"],
        name: json["name"],
        quantity: json["quantity"],
        bagCost: json["bagCost"]?.toDouble(),
        farmerCode: json["farmerCode"],
        bagSize: json["bagSize"]?.toDouble(),
        size: json["size"],
        amount: json["amount"]?.toDouble(),
        gstPercentage: json["gstPercentage"]?.toDouble(),
        cgstPercentage: json["cgstPercentage"]?.toDouble(),
        sgstPercentage: json["sgstPercentage"]?.toDouble(),
        cgst: json["cgst"]?.toDouble(),
        sgst: json["sgst"]?.toDouble(),
        basePrice: json["basePrice"]?.toDouble(),
        transPortGstPercentage: json["transPortGSTPercentage"]?.toDouble(),
        transPortCgstPercentage: json["transPortCGSTPercentage"]?.toDouble(),
        transPortSgstPercentage: json["transPortSGSTPercentage"]?.toDouble(),
        transPortCgst: json["transPortCGST"]?.toDouble(),
        transPortSgst: json["transPortSGST"]?.toDouble(),
        transportBasePrice: json["transportBasePrice"]?.toDouble(),
        transPortAmount: json["transPortAmount"]?.toDouble(),
        transPortTotalAmount: json["transPortTotalAmount"]?.toDouble(),
        transPortCost: json["transPortCost"]?.toDouble(),
        totalAmount: json["totalAmount"]?.toDouble(),
        closedDate: json["closedDate"] == null
            ? null
            : DateTime.parse(json["closedDate"]),
        requestTotalAmount: json["requestTotalAmount"]?.toDouble(),
        requestTotalTransport: json["requestTotalTransport"]?.toDouble(),
        licenseTypeId: json["licenseTypeId"],
        licenceType: json["licenceType"],
      );

  Map<String, dynamic> toJson() => {
        "requestCode": requestCode,
        "productId": productId,
        "productCode": productCode,
        "godownCode": godownCode,
        "name": name,
        "quantity": quantity,
        "bagCost": bagCost,
        "farmerCode": farmerCode,
        "bagSize": bagSize,
        "size": size,
        "amount": amount,
        "gstPercentage": gstPercentage,
        "cgstPercentage": cgstPercentage,
        "sgstPercentage": sgstPercentage,
        "cgst": cgst,
        "sgst": sgst,
        "basePrice": basePrice,
        "transPortGSTPercentage": transPortGstPercentage,
        "transPortCGSTPercentage": transPortCgstPercentage,
        "transPortSGSTPercentage": transPortSgstPercentage,
        "transPortCGST": transPortCgst,
        "transPortSGST": transPortSgst,
        "transportBasePrice": transportBasePrice,
        "transPortAmount": transPortAmount,
        "transPortTotalAmount": transPortTotalAmount,
        "transPortCost": transPortCost,
        "totalAmount": totalAmount,
        "closedDate": closedDate?.toIso8601String(),
        "requestTotalAmount": requestTotalAmount,
        "requestTotalTransport": requestTotalTransport,
        "licenseTypeId": licenseTypeId,
        "licenceType": licenceType,
      };
}
