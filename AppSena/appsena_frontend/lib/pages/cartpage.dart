import 'package:appsena_frontend/models/cart_model.dart';
import 'package:appsena_frontend/widgets/car_item.dart';
import 'package:appsena_frontend/widgets/fade_in_animation.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import '../pdf/web.dart';
import '../provider/cart_provider.dart';
import 'dart:ui' as ui;

class CartPage extends StatefulWidget {
  const CartPage({
    super.key,
  });

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    List<CartModel> carts = cartProvider.carts;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
          ),
        ),
        title: const Text(
          'Mi Carrito',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color(0x00000000),
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ...List.generate(
                    carts.length,
                    (index) => Container(
                      height: 140,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(
                          top: index == 0 ? 30 : 0,
                          right: 25,
                          left: 25,
                          bottom: 30),
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          FadeInAnimation(
                            durationInMs: (index + 1) * 150,
                            animationPosition: AnimationPosition(
                              topAfter: 0,
                              topBefore: 20,
                            ),
                            child: CarItem(
                              cart: carts[index],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Text('Total',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(width: 10),
                    Expanded(
                      child: DottedLine(
                        dashLength: 7,
                        dashColor: Colors.black.withOpacity(0.5),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '\$${(cartProvider.totalCart()).toStringAsFixed(0)}',
                      style: const TextStyle(
                          color: Colors.green,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                const SizedBox(height: 40),
                MaterialButton(
                  onPressed: () {
                    final cartProvider =
                        Provider.of<CartProvider>(context, listen: false);
                    _createPDF(cartProvider);
                    cartProvider.enviarPedido();
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Colors.black,
                  height: 72,
                  minWidth: MediaQuery.of(context).size.width - 50,
                  child: Text(
                    'Pagar \$${(cartProvider.totalCart()).toStringAsFixed(0)}',
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _createPDF(CartProvider cartProvider) async {
    //Create a PDF document.
    final PdfDocument document = PdfDocument();
    //Add page to the PDF
    final PdfPage page = document.pages.add();
    //Get page client size
    final Size pageSize = page.getClientSize();
    //Draw rectangle
    page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(0, 0, pageSize.width, pageSize.height),
        pen: PdfPen(PdfColor(37, 189, 50)));

    String fecha = DateTime.now().toString();
    String pedido = 'Fecha y hora del pedido: $fecha';
    for (var element in cartProvider.carts) {
      pedido +=
          '${element.productModel.name}>>>> ${element.quantity} \n PRECIO UNIDAD: ${element.productModel.price}\n PRECIO: ${(element.quantity * int.parse(element.productModel.price)).toStringAsFixed(2)}\n';
    }
    pedido +=
        '\nTOTAL COMPRA: ${cartProvider.totalCart().toStringAsFixed(0)}\n';

    final qrPainter = QrPainter(
      eyeStyle: const QrEyeStyle(eyeShape: QrEyeShape.circle),
      color: Colors.green.shade900,
      data: pedido,
      version: QrVersions.auto,
      gapless: false,
      errorCorrectionLevel: QrErrorCorrectLevel.H,
    );

    final imageSize = Size.square(700.toDouble());
    final qrImage = await qrPainter.toImage(imageSize.width);

    final byteData = await qrImage.toByteData(format: ui.ImageByteFormat.png);
    final imageData = byteData?.buffer.asUint8List();

    if (imageData != null) {
      final pdfImage = PdfBitmap(imageData);
      page.graphics.drawImage(
        pdfImage,
        Rect.fromLTWH(
          pageSize.width - 170,
          110,
          140,
          140,
        ),
      );
    }

    //Generate PDF grid.
    final PdfGrid grid = _getGrid(cartProvider);
    //Draw the header section by creating text element
    final PdfLayoutResult result =
        await _drawHeader(page, pageSize, grid, cartProvider);
    //Draw grid
    _drawGrid(page, grid, result, cartProvider);

    //Save and dispose the document.
    final List<int> bytes = await document.save();
    document.dispose();
    //Launch file.
    saveAndLaunchFile(bytes, 'Factura.pdf');
  }

  //Draws the invoice header
  Future<PdfLayoutResult> _drawHeader(PdfPage page, Size pageSize, PdfGrid grid,
      CartProvider cartProvider) async {
    //Draw rectangle
    page.graphics.drawRectangle(
        brush: PdfSolidBrush(PdfColor(78, 178, 31)),
        bounds: Rect.fromLTWH(0, 0, pageSize.width - 115, 90));
    //Draw string
    page.graphics.drawString(
        'PEDIDO',
        PdfStandardFont(
          PdfFontFamily.timesRoman,
          25,
          style: PdfFontStyle.bold,
        ),
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(25, 0, pageSize.width - 115, 90),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));
    page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 90),
        brush: PdfSolidBrush(PdfColor(40, 114, 51)));
    page.graphics.drawString(r'$' + cartProvider.totalCart().toStringAsFixed(0),
        PdfStandardFont(PdfFontFamily.timesRoman, 20),
        bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 100),
        brush: PdfBrushes.white,
        format: PdfStringFormat(
            alignment: PdfTextAlignment.center,
            lineAlignment: PdfVerticalAlignment.middle));
    final PdfFont contentFont = PdfStandardFont(PdfFontFamily.helvetica, 15);
    //Draw string
    page.graphics.drawString(
        'Total',
        PdfStandardFont(
          PdfFontFamily.timesRoman,
          20,
          style: PdfFontStyle.bold,
        ),
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 33),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.center,
            lineAlignment: PdfVerticalAlignment.bottom));

    String address =
        ' CBA Mosquera \r\r Cl. 17, Mosquera, Cundinamarca \n\n Nit: 9365550136\r\r Tel: 15462323';
    PdfTextElement(font: contentFont).draw(
        page: page,
        bounds:
            Rect.fromLTWH(pageSize.width - 30, 120, 30, pageSize.height - 120));
    return PdfTextElement(text: address, font: contentFont).draw(
        page: page,
        bounds: Rect.fromLTWH(
            30, 120, pageSize.width - 30, pageSize.height - 120))!;
  }

  //Draws the grid
  void _drawGrid(
      PdfPage page, PdfGrid grid, PdfLayoutResult result, cartProvider) {
    //Invoke the beginCellLayout event.
    grid.beginCellLayout = (Object sender, PdfGridBeginCellLayoutArgs args) {
      final PdfGrid grid = sender as PdfGrid;
      if (args.cellIndex == grid.columns.count - 1) {
      } else if (args.cellIndex == grid.columns.count - 2) {}
    };
    //Draw the PDF grid and get the result.
    result = grid.draw(
        page: page, bounds: Rect.fromLTWH(0, result.bounds.bottom + 40, 0, 0))!;
    //Draw grand total.
  }

  //Create PDF grid and return
  PdfGrid _getGrid(carrito) {
    //Create a PDF grid
    final PdfGrid grid = PdfGrid();

    //Secify the columns count to the grid.
    grid.columns.add(count: 4);
    //Create the header row of the grid.
    final PdfGridRow headerRow = grid.headers.add(1)[0];
    //Set style

    headerRow.cells[0].value = 'Producto';
    headerRow.cells[0].stringFormat.alignment = PdfTextAlignment.center;
    headerRow.cells[1].value = 'Cantidad';
    headerRow.cells[1].stringFormat.alignment = PdfTextAlignment.center;
    headerRow.cells[2].value = 'Precio';
    headerRow.cells[2].stringFormat.alignment = PdfTextAlignment.center;
    headerRow.cells[3].value = 'Total';
    headerRow.cells[3].stringFormat.alignment = PdfTextAlignment.center;
    _addProducts(carrito, grid);
    grid.applyBuiltInStyle(PdfGridBuiltInStyle.gridTable4Accent6);
    grid.columns[1].width = 200;
    for (int i = 0; i < headerRow.cells.count; i++) {
      headerRow.cells[i].style.cellPadding =
          PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
    }
    for (int i = 0; i < grid.rows.count; i++) {
      final PdfGridRow row = grid.rows[i];
      for (int j = 0; j < row.cells.count; j++) {
        final PdfGridCell cell = row.cells[j];
        if (j == 0) {
          cell.stringFormat.alignment = PdfTextAlignment.center;
        }
        cell.style.cellPadding =
            PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
      }
    }
    return grid;
  }

  //Create and row for the grid.
  void _addProducts(CartProvider cartProvider, PdfGrid grid) {
    for (var element in cartProvider.carts) {
      final PdfGridRow row = grid.rows.add();
      row.cells[0].value = element.productModel.name;
      row.cells[0].stringFormat.alignment = PdfTextAlignment.center;
      row.cells[1].value = element.quantity.toString();
      row.cells[1].stringFormat.alignment = PdfTextAlignment.center;
      row.cells[2].value = element.productModel.price.toString();
      row.cells[2].stringFormat.alignment = PdfTextAlignment.center;
      row.cells[3].value =
          (element.quantity * int.parse(element.productModel.price))
              .toStringAsFixed(0);
      row.cells[3].stringFormat.alignment = PdfTextAlignment.center;
    }
  }
}
