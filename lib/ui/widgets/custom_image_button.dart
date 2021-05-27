import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomImageButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final IconData iconData;
  CustomImageButton(this.text, this.onPressed, this.iconData);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.0,
      child: Container(
        width: Get.width / 2,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey, offset: Offset(1.0, 2.0), blurRadius: 8.0, spreadRadius: 2.0)
            ]),
        child: Stack(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                    width: 48.0,
                    height: 48.0,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: Get.theme.primaryColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                    child: Align(
                        alignment: Alignment.center,
                        child: Icon(
                          iconData,
                          color: Colors.white,
                        ))),
                Expanded(
                    child: Center(
                  child: Text(text,
                      style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.black)),
                )),
              ],
            ),
            SizedBox.expand(
              child: Material(
                type: MaterialType.transparency,
                child: InkWell(onTap: () => onPressed()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
