import 'dart:async';
import 'dart:io';

import 'package:akshaya_flutter/common_utils/common_styles.dart';
import 'package:akshaya_flutter/common_utils/custom_appbar.dart';
import 'package:akshaya_flutter/localization/locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFViewScreen extends StatefulWidget {
  final String? path;

  const PDFViewScreen({super.key, this.path});

  @override
  State<PDFViewScreen> createState() => _PDFViewScreenState();
}

class _PDFViewScreenState extends State<PDFViewScreen>
    with WidgetsBindingObserver {
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = ''; // Track the error message

  @override
  void initState() {
    super.initState();
    print('PDFViewScreen: ${widget.path}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: tr(LocaleKeys.document),
        actionIcon: IconButton(
          icon: const Icon(Icons.share, color: Colors.white),
          onPressed: () async {
            final result = await Share.shareXFiles([XFile(widget.path!)],
                text: 'Thank you for sharing');

            if (result.status == ShareResultStatus.success) {
              print('ShareResultStatus.success');
            } else if (result.status == ShareResultStatus.unavailable) {
              print('ShareResultStatus.unavailable');
            } else {
              print('else..........');
            }
          },
        ),
      ),
      body: errorMessage.isEmpty
          ? SfPdfViewer.file(
              File(widget.path!),
              onDocumentLoaded: (PdfDocumentLoadedDetails details) {
                print('PDF loaded successfully.');
              },
              onDocumentLoadFailed: (PdfDocumentLoadFailedDetails details) {
                setState(() {
                  errorMessage = 'No PDF found';
                });
                print('Pdf file not found: ${details.error}');
              },
            )
          : Center(
              child: Text(
                errorMessage,
                style: CommonStyles.errorTxStyle,
              ),
            ),
    );
  }
}
