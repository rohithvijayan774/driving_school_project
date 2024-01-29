import 'package:driving_school/views/user/payment_successfull.dart';
import 'package:flutter/material.dart';
import 'package:upi_india/upi_india.dart';

class PaymentGateway extends ChangeNotifier {
  UpiResponse? upiResponse;
  final UpiIndia _upiIndia = UpiIndia();
  String? transactionId;

  List<UpiApp> apps = [];
  Future getAllApps() async {
    await _upiIndia.getAllUpiApps(mandatoryTransactionId: false).then((value) {
      apps = value;
    }).catchError((e) {
      apps = [];
    });
  }

  Future initiateTransaction(
      UpiApp app, upiID, receiverName, price, context) async {
    try {
      UpiResponse response = await _upiIndia.startTransaction(
          app: app,
          receiverUpiId: '9778386283@ibl',
          receiverName: receiverName,
          transactionRefId: 'TestingUpiIndiaPlugin',
          transactionNote: 'Payment to Driving School',
          amount: price,
          currency: 'INR');

      print('///////////Payment Response : $response ///////////////////');

      //           if (response == UpiPaymentStatus.SUCCESS) {
      //   // Payment successful
      //   print('Payment successful');
      //   // Add your logic here
      // } else if (response == UpiResponse.SUBMITTED) {
      //   // Payment submitted, but not completed yet
      //   print('Payment submitted, but not completed yet');
      //   // Add your logic here
      // } else if (response == UpiResponse.FAILURE) {
      //   // Payment failed
      //   print('Payment failed');
      //   // Add your logic here
      // } else if (response == UpiResponse.CANCELLED) {
      //   // Payment cancelled by the user
      //   print('Payment cancelled by the user');
      //   // Add your logic here
      // } else if (response == UpiResponse.UNKNOWN) {
      //   // Payment status unknown
      //   print('Payment status unknown');
      //   // Add your logic here
      // }
    } catch (e) {
      print(
          '///////////////Transaction Initialization failed//////////////////');
    }
  }

  Widget displayUpiApps(upiID, receiverName, price, context) {
    if (apps.isEmpty) {
      return const Center(
        child: Text('No Payment Apps found'),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const Text('Select your payment option'),
            const SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              child: Wrap(
                children: apps.map<Widget>(
                  (app) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const PaymentSuccessful(),
                        ));
                      },
                      onLongPress: () {
                        initiateTransaction(
                            app, upiID, receiverName, price, context);
                      },
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: Column(
                          children: [
                            Image.memory(
                              app.icon,
                              height: 60,
                              width: 60,
                            ),
                            Text(app.name),
                          ],
                        ),
                      ),
                    );
                  },
                ).toList(),
              ),
            )
          ],
        ),
      );
    }
  }

  void checkTxnStatus(String status) {
    switch (status) {
      case UpiPaymentStatus.SUCCESS:
        print('Transaction Successful');
        break;
      case UpiPaymentStatus.SUBMITTED:
        print('Transaction Submitted');
        break;
      case UpiPaymentStatus.FAILURE:
        print('Transaction Failed');
        break;
      default:
        print('Received an Unknown transaction status');
    }
  }
}
