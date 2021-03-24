import 'package:flutter/material.dart';

class CustomRectangularBtn extends StatelessWidget {
  final String title;
  final Function onPressed;
  final double verticalPadding;
  final double horizontalPadding;
  final Color color;

  CustomRectangularBtn(
      {this.title,
      this.onPressed,
      this.horizontalPadding = 15,
      this.color,
      this.verticalPadding = 0});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        child: RaisedButton(
          elevation: 0.0,
          padding: EdgeInsets.symmetric(
              vertical: verticalPadding, horizontal: horizontalPadding),
          textColor: Colors.white,
          color: color,
          child: Text(
            title,
            style: Theme.of(context)
                .accentTextTheme
                .bodyText1
                .merge(TextStyle(fontWeight: FontWeight.bold)),
          ),
          onPressed: onPressed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
      ),
    );
  }
}
