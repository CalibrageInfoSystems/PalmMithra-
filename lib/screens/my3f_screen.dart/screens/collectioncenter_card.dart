import 'package:akshaya_flutter/common_utils/common_styles.dart';
import 'package:akshaya_flutter/common_utils/common_widgets.dart';
import 'package:akshaya_flutter/common_utils/constants.dart';
import 'package:akshaya_flutter/gen/assets.gen.dart';
import 'package:akshaya_flutter/models/important_places_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../localization/locale_keys.dart';

class CollectionCenterCard extends StatefulWidget {
  final CollectionCenter data;
  final String imagePath;
  const CollectionCenterCard(
      {super.key, required this.data, required this.imagePath});

  @override
  State<CollectionCenterCard> createState() => _CollectionCenterCardState();
}

class _CollectionCenterCardState extends State<CollectionCenterCard> {
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: CommonStyles.whiteColor,
          borderRadius: BorderRadius.circular(5.0),
        ),
        margin: const EdgeInsets.only(bottom: 5),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Image.asset(
                widget.imagePath,
                fit: BoxFit.contain,
                width: 50,
                height: 70,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${widget.data.collectionCenter}',
                      style: CommonStyles.txStyF16CbFF6
                          .copyWith(color: CommonStyles.impPlacesDataColor)),
                  const Divider(
                    color: CommonStyles.primaryTextColor,
                    thickness: 0.3,
                  ),
                  contentBox(
                    label: tr(LocaleKeys.village),
                    data: '${widget.data.villageName}',
                  ),
                  contentBox(
                    label: tr(LocaleKeys.mandal),
                    data: '${widget.data.mandalName}',
                  ),
                  contentBox(
                    label: tr(LocaleKeys.dist),
                    data: '${widget.data.districtName}',
                  ),
                  contentBox(
                    label: tr(LocaleKeys.contact_number),
                    data: (widget.data.contactNumber != null &&
                            widget.data.contactNumber != '')
                        ? widget.data.contactNumber
                        : 'N/A',
                    datatextColor: CommonStyles.greenColor,
                    onTap: () {
                      if (widget.data.contactNumber != null &&
                          widget.data.contactNumber != '') {
                        CommonWidgets.makePhoneCall(context,
                            data: widget.data.contactNumber);
                      }
                    },
                  ),
                  GestureDetector(
                    onTap: () {
                      Constants.launchMap(context,
                          latitude: widget.data.latitude,
                          longitude: widget.data.longitude);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(tr(LocaleKeys.view_in_map),
                            style: CommonStyles.txStyF14CbFF6.copyWith(
                                color: CommonStyles.impPlacesDataColor)),
                        const SizedBox(width: 5),
                        Image.asset(
                          Assets.images.icMapList.path,
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget contentBox(
      {required String label,
      required String? data,
      Color? datatextColor,
      VoidCallback? onTap}) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 3,
                  child: Text(label,
                      style: CommonStyles.txStyF14CbFF6
                          .copyWith(color: CommonStyles.impPlacesDataColor))),
              Text(':  ',
                  style: CommonStyles.txStyF14CbFF6
                      .copyWith(color: CommonStyles.impPlacesDataColor)),
              Expanded(
                flex: 6,
                child: Text('$data',
                    style: CommonStyles.txStyF14CbFF6.copyWith(
                        color:
                            datatextColor ?? CommonStyles.impPlacesDataColor),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis),
              ),
            ],
          ),
        ),
        const Divider(
          color: CommonStyles.primaryTextColor,
          thickness: 0.3,
        ),
      ],
    );
  }
}
