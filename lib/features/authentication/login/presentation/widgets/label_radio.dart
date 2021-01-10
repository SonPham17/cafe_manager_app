import 'package:cafe_manager_app/common/constants/enum_constants.dart';
import 'package:flutter/material.dart';

class LabelRadio extends StatelessWidget {
  final String label;
  final EdgeInsets padding;
  final LoginType groupValue;
  final LoginType value;
  final Function onChanged;

  LabelRadio(
      {this.label, this.padding, this.groupValue, this.value, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (value != groupValue) {
          onChanged(value);
        }
      },
      child: Padding(
        padding: padding,
        child: Row(
          children: <Widget>[
            Radio<LoginType>(
              groupValue: groupValue,
              value: value,
              onChanged: (LoginType newValue) {
                onChanged(newValue);
              },
            ),
            Text(label,style: TextStyle(fontSize: 12),),
          ],
        ),
      ),
    );
  }
}
