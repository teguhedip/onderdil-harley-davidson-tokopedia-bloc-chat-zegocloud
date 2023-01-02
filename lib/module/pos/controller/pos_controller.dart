import 'dart:convert';

import 'package:example/core.dart';
import 'package:example/service/order_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PosController extends State<PosView> implements MvcController {
  static late PosController instance;
  late PosView view;

  // final products = LocalProductService.products;

  String paymentMethod = "cash";
  double total = 0;
  double point = 0;

  @override
  void initState() {
    instance = this;
    OrderService.init();
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  List productsToQr = [];

  countPoin() async {
    total = OrderService.total;
    point = total * (10 / 100);
  }

  doCheckout() async {
    print("POIN >>>> $point");
    print("TOTAL >>>> $total");
    print("PAYMENT METHOD >>>> $paymentMethod");

    productsToQr = OrderService.productsCheckout();
    print("productsToQr >>>> $productsToQr");

    //Atur point menjadi 10% dari total
    var qrCodeString = jsonEncode({
      "total": total,
      "point": point,
      "items": productsToQr,
      "payment_method": paymentMethod, //"Dana" | OVO | Gopay
      "vendor": {
        "id": FirebaseAuth.instance.currentUser!.uid,
        "email": FirebaseAuth.instance.currentUser!.email,
        "name": FirebaseAuth.instance.currentUser!.displayName,
      }
    });

    print("qrCodeString ======= $qrCodeString");

    await showCustomDialog(
      title: "Order success",
      children: [
        SizedBox(
          height: 250.0,
          width: 250.0,
          child: QrImage(
            data: qrCodeString,
            version: QrVersions.auto,
            size: 200.0,
          ),
        ),
      ],
    );

    Get.back();
  }
}
