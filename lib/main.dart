import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:myanmar_tools/myanmar_tools.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:printpdf/preview.dart';
import 'package:rabbit_converter/rabbit_converter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amberAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final converter = ZawGyiConverter();
  _generatePdf() async {
    final doc = pw.Document();
    final font = await rootBundle.load("asset/fonts/OpenSans-Regular.ttf");
    final mm = await rootBundle.load("asset/fonts/Zawgyi-One.ttf");
    final mtff = pw.Font.ttf(mm);

    final tableHeader = ["No", "", "ယူနစ်", "", "နှုန်း", "သင့်ငွေ"];
    final subTableHeader = ["", "ကျပ်", "ပဲ", "ရွေး", "", ""];
    // final me = await PdfGoogleFonts
    var tableData = [
      ["No", "", "Unit", "", "နှုန်း", "သင့်ငွေ့"],
      ["", "ကျပ်", "ပဲ", "ရွေး", "", ""],
      ["1", "1", "4", "5", "320000000", "340000000"],
      ["2", "2", "1", "5", "720000000", "840000000"],
      ["3", "", "4", "5", "220000000", "340000000"],
    ];

    tableData = tableData
        .map((e) => e.map((e) => e.isNotEmpty ? Rabbit.uni2zg(e) : e).toList())
        .toList();

    final table = pw.TableHelper.fromTextArray(
      data: tableData,
      headerCount: 2,
      cellAlignment: pw.Alignment.center,
      cellPadding: const pw.EdgeInsets.all(5),
      headerStyle: pw.TextStyle(
        fontWeight: pw.FontWeight.bold,
      ),
    );

    final tff = pw.Font.ttf(font);
    doc.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        theme: pw.ThemeData(
            defaultTextStyle: pw.TextStyle(fontFallback: [tff, mtff])),
        build: (pw.Context context) {
          // return pw.Column(children: [
          //   pw.Text("Sein Kyaw Moe"),
          //   pw.SizedBox(height: 30),
          //   table
          // ]);
          return pw.Column(children: [
            pw.Text("Sein Kyaw Moe"),
            pw.SizedBox(height: 40),
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Invoice No: 123021290'),
                  pw.SizedBox(
                    width: 160,
                    child: pw.Text(
                        'Date: ${DateFormat('dd-MM-yyyy').format(DateTime.now())} ${DateFormat.jm().format(DateTime.now()).toString()}'),
                  )
                ]),
            pw.SizedBox(height: 20),
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Name: Lonely'),
                  pw.Container(
                      width: 160,
                      child: pw.Text(
                          'NRC: ${Rabbit.uni2zg('၉/မကန(နိုင်)-၀၆၅၄၃၂၁')}')),
                ]),
            pw.SizedBox(height: 20),
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Phone number: 09231160911'),
                  pw.SizedBox(width: 160, child: pw.Text('City: mogok/panma')),
                ]),
            pw.SizedBox(height: 20),
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Description: '),
                ]),
            pw.SizedBox(height: 30),
            pw.Table(
                columnWidths: {
                  0: const pw.FractionColumnWidth(0.1),
                  1: const pw.FractionColumnWidth(0.15),
                  2: const pw.FractionColumnWidth(0.15),
                  3: const pw.FractionColumnWidth(0.15),
                  4: const pw.FractionColumnWidth(0.24),
                  5: const pw.FractionColumnWidth(0.24),
                  6: const pw.FractionColumnWidth(0.24),
                },
                border: pw.TableBorder.all(),
                children: [
                  pw.TableRow(
                      children: tableHeader
                          .map((e) => pw.Padding(
                              padding: const pw.EdgeInsets.all(10),
                              child: pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      pw.MainAxisAlignment.center,
                                  children: [
                                    pw.Text(e.isNotEmpty ? Rabbit.uni2zg(e) : e)
                                  ])))
                          .toList()),
                  pw.TableRow(
                      children: subTableHeader
                          .map((e) => pw.Padding(
                              padding: const pw.EdgeInsets.all(5),
                              child: pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      pw.MainAxisAlignment.center,
                                  children: [
                                    pw.Text(e.isNotEmpty ? Rabbit.uni2zg(e) : e)
                                  ])))
                          .toList()),
                  for (var i = 0; i < 2; i++)
                    pw.TableRow(children: [
                      pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisAlignment: pw.MainAxisAlignment.center,
                              children: [pw.Text("${i + 1}")])),
                      pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisAlignment: pw.MainAxisAlignment.center,
                              children: [pw.Text("1")])),
                      pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisAlignment: pw.MainAxisAlignment.center,
                              children: [pw.Text("1")])),
                      pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisAlignment: pw.MainAxisAlignment.center,
                              children: [pw.Text("1")])),
                      pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisAlignment: pw.MainAxisAlignment.center,
                              children: [
                                pw.Text(NumberFormat('###,###', 'en_US')
                                    .format(int.parse("312000000")))
                              ])),
                      pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              mainAxisAlignment: pw.MainAxisAlignment.center,
                              children: [
                                pw.Text(NumberFormat('###,###', 'en_US')
                                    .format(int.parse("312000000")))
                              ])),
                    ]),
                ]),
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Container(
                    width: 254,
                      child: pw.Table(
                          border: pw.TableBorder.all(),
                          children: [
                            pw.TableRow(children: [
                              pw.Padding(
                                  padding: const pw.EdgeInsets.all(8),
                                  child: pw.Column(
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          pw.MainAxisAlignment.center,
                                      children: [pw.Text(Rabbit.uni2zg("စုစုပေါင်းကျသင့်ငွေ"))])),
                              pw.Padding(
                                  padding: const pw.EdgeInsets.all(8),
                                  child: pw.Column(
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          pw.MainAxisAlignment.center,
                                      children: [
                                        pw.Text(NumberFormat('###,###', 'en_US')
                                            .format(int.parse("624000000")))
                                      ]))
                            ])
                          ]))
                ])
          ]);
        }));
    // await Printing.layoutPdf(
    //     onLayout: (PdfPageFormat format) async => doc.save());
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => PreView(doc: doc)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: _generatePdf,
            child: const Text(
              "Print",
              style: TextStyle(fontFamily: "Mm"),
            ),
          ),
        ));
  }
}
