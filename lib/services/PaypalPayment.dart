// import 'dart:core';
// import 'dart:ffi';
// import 'package:codeine_crazy/services/PaypalServices.dart';
// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class PaypalPayment extends   StatefulWidget{
//   final Function onFinish;
//   PaypalPayment({@required  this.onFinish});

//   @override
// State<StatefulWidget> createState(){
//   return PaypalPaymentState();
// }

// }
// class PayPalPayment extends State<PaypalPayment>{
//   GlobalKey<ScaffoldState> _scaffoldkey =GlobalKey<ScaffoldState>();
//   var checkoutUrl;
//   var executeUrl;
//   var accessToken;

//   PaypalServices services =PaypalServices();

//   @override 
//   void initState() {
//     // TODO: implement initState
//     super.initState();
  
//   Future.delayed(Duration.zero, ()async{
//     try{
//       accessToken = await services.getAccessToken();
//       final res =await services.createPaypalPayment(transactions, accessToken);
//     }catch(e){}

//   });
//   }
// Map<String, dynamic>getOrderParams(){


  
// }

//   @override
//   Widget build (BuildContext context){
//     return Container(
//       child: null,
//     );
//   }
// }


