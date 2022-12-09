import 'package:flutter/material.dart';

class CustomTextWidget extends StatelessWidget {
  final String textTitle;
  final String textDetails;
  const CustomTextWidget({Key? key,
    required this.textTitle,
    required this.textDetails,
  }) : super(key: key);

  // isItCompleted (String message) {
  //   if (completed == true) {
  //    return message = 'Todo is complete';
  //   } else {
  //     return message = 'Todo is incomplete';
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          SizedBox(
            height: 50,
            width: 120,
            child: Text(textTitle),
          ),
          const VerticalDivider(width: 50,),
          SizedBox(
            height: 50,
            width: 120,
            child: Text(textDetails),
          ),
        ],
      ),
    );
  }
}
