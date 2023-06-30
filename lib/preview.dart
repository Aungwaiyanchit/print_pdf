import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;

class PreView extends StatefulWidget {
  const PreView({super.key, required this.doc});
  final pw.Document doc;
  @override
  State<PreView> createState() => _PreViewState();
}

class _PreViewState extends State<PreView> {
  @override
  Widget build(BuildContext context) {
    return PdfPreview(
      build: (format) {
        return widget.doc.save();
      },
    );
  }
}
