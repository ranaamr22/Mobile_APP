// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../styles/colors.dart';

void navigateTo(context, widget) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ));

void navigateToAndRemove(context, widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => widget), (route) => false);

Widget pageIndicator(controller, count) => SmoothPageIndicator(
      controller: controller,
      count: count,
      effect: const ExpandingDotsEffect(
        activeDotColor: mainColor,
        dotHeight: 10.0,
        dotWidth: 10.0,
        expansionFactor: 7,
        spacing: 5,
      ),
    );

Widget defaultTextFormField(
        {
          required TextInputType keyboardType,
          required prefix,
          required String label,
          required TextEditingController controller,
          required validate,
          bool isPassword = false,
          onChange,
          onSubmit,
          suffix,
          initialValue
        }
      ) =>
    TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isPassword,
      initialValue: initialValue,
      decoration: InputDecoration(
        suffixIcon: suffix,
        prefixIcon: prefix,
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onChanged: onChange,
      validator: validate,
      onFieldSubmitted: onSubmit,
    );

Widget defaultButton(
    {
      color = mainColor,
      required onPress,
      required label,

    }) =>
    Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: mainColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: MaterialButton(
        onPressed: onPress,
        child: Text(
          label.toString().toUpperCase(),
          style: TextStyle(
              color: Colors.white
          ),
        ),
      ),
    );

enum ToastColor {success, error, warning}

Color chooseColor({required ToastColor state})
{
  Color color;
  switch(state)
  {
    case ToastColor.success:
      color= Colors.green;
      break;
    case ToastColor.error:
      color= Colors.red;
      break;
    case ToastColor.warning:
      color= Colors.amber;
      break;
  }
  return color ;
}

void showToast(
  {
    required String text,
    int time= 5,
    required ToastColor state,
  }
)
{
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: time,
      backgroundColor: chooseColor(state: state),
      textColor: Colors.white,
      fontSize: 16.0
  );
}

