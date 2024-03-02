// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_final_fields

import 'package:mytoys/common/widgets/custom_button.dart';
// import 'package:mytoys/constants/utils.dart';
import 'package:mytoys/features/address/screens/upi.dart';
import 'package:mytoys/features/address/services/address_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mytoys/constants/global_variables.dart';
import 'package:mytoys/providers/user_provider.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address';
  final String totalAmount;
  const AddressScreen({
    Key? key,
    required this.totalAmount,
  }) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  // final TextEditingController flatBuildingController = TextEditingController();
  // final TextEditingController areaController = TextEditingController();
  // // final TextEditingController nameController = TextEditingController();
  // // final TextEditingController numberController = TextEditingController();
  // final TextEditingController pincodeController = TextEditingController();
  // final TextEditingController cityController = TextEditingController();
  // final _addressFormKey = GlobalKey<FormState>();
  final _formKey = GlobalKey<FormState>();
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _addressLine1Controller = TextEditingController();
  TextEditingController _addressLine2Controller = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _postalCodeController = TextEditingController();

  String addressToBeUsed = "";
  // List<PaymentItem> paymentItems = [];
  final AddressServices addressServices = AddressServices();

  @override
  void initState() {
    super.initState();
  }

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      // Perform form submission logic here
      // You can access the address details using the controller values
      addressToBeUsed =
          "${_addressLine1Controller.text},${_addressLine2Controller.text},${_cityController.text},${_stateController.text} - ${_postalCodeController.text}";
    }
  }

  String selectedAddress = "";
  void AddressMethodSelected(value) {
    setState(() {
      selectedAddress = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          title: const Text('Select Address'),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (address.isNotEmpty)
                Column(
                  children: [
                    RadioListTile(
                      title: Text("Select this address"),
                      value: address,
                      groupValue: selectedAddress,
                      onChanged: AddressMethodSelected,
                    ),
                    // if (selectedAddress == "Select this address")
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black12,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          address,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'OR',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              // RadioListTile(
              //   title: Text(address),
              //   value: address,
              //   groupValue: selectedAddress,
              //   onChanged: AddressMethodSelected,
              // ),
              RadioListTile(
                title: const Text("Select new address"),
                value: "Select new address",
                groupValue: selectedAddress,
                onChanged: AddressMethodSelected,
              ),
              const SizedBox(height: 16),
              if (selectedAddress == address)
                CustomButton(
                    text: 'Next',
                    onTap: () {
                      Navigator.pushNamed(context, payment.routeName,
                          arguments: address);
                    }),

              if (selectedAddress == "Select new address")
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _fullNameController,
                        decoration: InputDecoration(labelText: 'Full Name'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your full name';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _addressLine1Controller,
                        decoration:
                            InputDecoration(labelText: 'Address Line 1'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter address line 1';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _addressLine2Controller,
                        decoration:
                            InputDecoration(labelText: 'Address Line 2'),
                      ),
                      TextFormField(
                        controller: _cityController,
                        decoration: InputDecoration(labelText: 'City'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your city';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _stateController,
                        decoration: InputDecoration(labelText: 'State'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your state';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _postalCodeController,
                        decoration: InputDecoration(labelText: 'Postal Code'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your postal code';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: submitForm,
                        child: Text('Save Address'),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 10),
              // if()
              if (selectedAddress == "Select new address")
                CustomButton(
                    text: 'Next',
                    onTap: () {
                      addressServices.saveUserAddress(
                          context: context, address: addressToBeUsed);

                      Navigator.pushNamed(context, payment.routeName,
                          arguments: address);
                    }),
            ],
          ),
        ),
      ),
    );
  }
}
