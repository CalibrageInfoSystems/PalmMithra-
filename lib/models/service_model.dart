// To parse this JSON data, do
//
//     final serviceModel = serviceModelFromJson(jsonString);

import 'dart:convert';

List<ServiceModel> serviceModelFromJson(List<Map<String, dynamic>> services) =>
    List<ServiceModel>.from(services.map((x) => ServiceModel.fromJson(x)));

String serviceModelToJson(List<ServiceModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ServiceModel {
  final int? id;
  final String? stateCode;
  final String? stateName;
  final int? serviceTypeId;
  final int? createdByUserId;
  final DateTime? createdDate;
  final String? serviceType;
  final String? createdBy;

  ServiceModel({
    this.id,
    this.stateCode,
    this.stateName,
    this.serviceTypeId,
    this.createdByUserId,
    this.createdDate,
    this.serviceType,
    this.createdBy,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
        id: json["id"],
        stateCode: json["stateCode"],
        stateName: json["stateName"],
        serviceTypeId: json["serviceTypeId"],
        createdByUserId: json["createdByUserId"],
        createdDate: json["createdDate"] == null
            ? null
            : DateTime.parse(json["createdDate"]),
        serviceType: json["serviceType"],
        createdBy: json["createdBy"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "stateCode": stateCode,
        "stateName": stateName,
        "serviceTypeId": serviceTypeId,
        "createdByUserId": createdByUserId,
        "createdDate": createdDate?.toIso8601String(),
        "serviceType": serviceType,
        "createdBy": createdBy,
      };
}
