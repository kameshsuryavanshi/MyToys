// // ignore_for_file: unused_local_variable, sized_box_for_whitespace, curly_braces_in_flow_control_structures, avoid_print, no_leading_underscores_for_local_identifiers, prefer_is_empty, prefer_final_fields, camel_case_types, non_constant_identifier_names

// ignore_for_file: camel_case_types, no_leading_underscores_for_local_identifiers, prefer_is_empty, prefer_final_fields, sized_box_for_whitespace, curly_braces_in_flow_control_structures, avoid_print, unused_local_variable

import 'package:flutter/material.dart';
import 'package:mytoys/common/widgets/custom_button.dart';
import 'package:mytoys/constants/global_variables.dart';
import 'package:mytoys/features/address/services/address_services.dart';
import 'package:mytoys/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:upi_india/upi_india.dart';

class payment extends StatefulWidget {
  static const String routeName = '/payment';
  final String address;
  const payment({
    Key? key,
    required this.address,
  }) : super(key: key);
  @override
  State<payment> createState() => _paymentState();
}

class _paymentState extends State<payment> {
  Future<UpiResponse>? _transaction;
  UpiIndia _upiIndia = UpiIndia();
  List<UpiApp>? apps;
  // void totalsum(double sum) {
  //   double Sum = sum;
  // }

  final AddressServices addressServices = AddressServices();
  TextStyle header = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  TextStyle value = const TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );

//  SELECT PAYMENT METHORD
  String selectedPaymentMethod = "";
  void _onPaymentMethodSelected(value) {
    setState(() {
      selectedPaymentMethod = value;
    });
  }

  @override
  void initState() {
    _upiIndia.getAllUpiApps(mandatoryTransactionId: false).then((value) {
      setState(() {
        apps = value;
      });
    }).catchError((e) {
      apps = [];
    });
    super.initState();
  }

  double total() {
    final user = context.watch<UserProvider>().user;
    double sum = 0;
    user.cart
        .map((e) => sum += e['quantity'] * e['product']['price'] as int)
        .toList();
    return sum;
  }

  Future<UpiResponse> initiateTransaction(UpiApp app) async {
    // final user = context.watch<UserProvider>().user;
    // double sum = 0;
    // user.cart
    //     .map((e) => sum += e['quantity'] * e['product']['price'] as int)
    //     .toList();
    return _upiIndia.startTransaction(
      app: app,
      receiverUpiId: "kschalase03@okicici",
      receiverName: 'Kanhaiya Chalase',
      transactionRefId: 'TestingUpiIndiaPlugin',
      transactionNote: 'Mytoys',
      amount: 5.00,
    );
  }

  Widget displayUpiApps() {
    if (apps == null)
      return const Center(child: CircularProgressIndicator());
    else if (apps!.length == 0)
      return Center(
        child: Text(
          "No apps found to handle transaction.",
          style: header,
        ),
      );
    else
      return Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Wrap(
            children: apps!.map<Widget>((UpiApp app) {
              return GestureDetector(
                onTap: () {
                  _transaction = initiateTransaction(app);
                  setState(() {});
                },
                child: Container(
                  height: 100,
                  width: 100,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
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
            }).toList(),
          ),
        ),
      );
  }

  String _upiErrorHandler(error) {
    switch (error) {
      case UpiIndiaAppNotInstalledException:
        return 'Requested app not installed on device';
      case UpiIndiaUserCancelledException:
        return 'You cancelled the transaction';
      case UpiIndiaNullResponseException:
        return 'Requested app didn\'t return any response';
      case UpiIndiaInvalidParametersException:
        return 'Requested app cannot handle the transaction';
      default:
        return 'An Unknown error has occurred';
    }
  }

  void _checkTxnStatus(String status) {
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

  Widget displayTransactionData(title, body) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$title: ", style: header),
          Flexible(
              child: Text(
            body,
            style: value,
          )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    double sum = 0;
    user.cart
        .map((e) => sum += e['quantity'] * e['product']['price'] as int)
        .toList();
    // double Sum = sum;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          title: const Text(
            'Select Payment Method',
            selectionColor: Colors.white,
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          RadioListTile(
            title: const Text("Cash on Delivery"),
            value: "Cash on Delivery",
            groupValue: selectedPaymentMethod,
            onChanged: _onPaymentMethodSelected,
          ),
          RadioListTile(
            title: const Text("UPI"),
            value: "UPI",
            groupValue: selectedPaymentMethod,
            onChanged: _onPaymentMethodSelected,
          ),
          const SizedBox(height: 16),
          if (selectedPaymentMethod == "UPI")
            Expanded(
              child: displayUpiApps(),
            ),
          Expanded(
            child: FutureBuilder(
              future: _transaction,
              builder:
                  (BuildContext context, AsyncSnapshot<UpiResponse> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        _upiErrorHandler(snapshot.error.runtimeType),
                        style: header,
                      ), // Print's text message on screen
                    );
                  }

                  // If we have data then definitely we will have UpiResponse.
                  // It cannot be null
                  UpiResponse _upiResponse = snapshot.data!;

                  // Data in UpiResponse can be null. Check before printing
                  String txnId = _upiResponse.transactionId ?? 'N/A';
                  String resCode = _upiResponse.responseCode ?? 'N/A';
                  String txnRef = _upiResponse.transactionRefId ?? 'N/A';
                  String status = _upiResponse.status ?? 'N/A';
                  String approvalRef = _upiResponse.approvalRefNo ?? 'N/A';
                  _checkTxnStatus(status);

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        displayTransactionData('Transaction Id', txnId),
                        // displayTransactionData('Response Code', resCode),
                        // displayTransactionData('Reference Id', txnRef),
                        displayTransactionData('Status', status.toUpperCase()),
                        displayTransactionData('Approval No', approvalRef),
                        CustomButton(
                            text: 'Place Order',
                            onTap: () {
                              addressServices.placeOrder(
                                  context: context,
                                  address: widget.address,
                                  paymentMethod: selectedPaymentMethod,
                                  totalSum: sum);
                            })
                      ],
                    ),
                  );
                } else
                  return const Center(
                    child: Text(''),
                  );
              },
            ),
          ),
          if (selectedPaymentMethod == "Cash on Delivery")
            CustomButton(
              text: 'Place Order',
              onTap: () {
                addressServices.placeOrder(
                    context: context,
                    address: widget.address,
                    paymentMethod: selectedPaymentMethod,
                    totalSum: sum);
              },
            )
        ],
      ),
    );
  }
}
