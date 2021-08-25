import 'package:flutter/material.dart';
import 'package:google_sheet_task/views/shared/utils/colors.dart';



class AppInput extends StatelessWidget {
  final TextEditingController controller;
  final String title, errorMessage, pickedDate;
  // final String errorMessage;
  final bool hasError, isDate;
  final TextInputType keyboardType;
  final Function pickDate;

  const AppInput({
    Key key,
    this.controller,
    this.isDate,
    this.title,
    this.errorMessage,
    this.hasError,
    this.keyboardType,
    this.pickDate,
    this.pickedDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 25,
          child: Text(
            title ?? '',
            style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: 18,
            ),
          ),
        ),
        isDate == true
            ? InkWell(
                onTap: () {
                  pickDate?.call();
                  // showDatePicker(
                  //   context: context,
                  //   initialDate: DateTime.now(),
                  //   firstDate: DateTime(1, 1, 2020),
                  //   lastDate: DateTime(2025),
                  // );
                },
                child: Container(
                  alignment: Alignment.centerLeft,
                  width: MediaQuery.of(context).size.width,
                  height: 48,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 0.5,
                      ),
                    ),
                  ),
                  child: Text(
                    pickedDate ?? '',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              )
            : TextField(
                controller: controller,
                keyboardType: this.keyboardType,
                // decoration: InputDecoration(),
              ),
        Container(
          alignment: Alignment.bottomLeft,
          height: 25,
          child: hasError == true
              ? Text(
                  errorMessage ?? '',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                )
              : null,
        ),
      ],
    );
  }
}
