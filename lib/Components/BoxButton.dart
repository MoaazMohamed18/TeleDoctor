import 'package:flutter/material.dart';

class BoxButton extends StatelessWidget {

  final color,image,text,style,Screen;


  BoxButton({this.color, this.image, this.text, this.style, this.Screen});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        onPressed:(){
          Navigator.of(context).push(
              MaterialPageRoute(builder: (c){
                return Screen;
              })
          );
        },
    color: color,
      child:
      Container(
        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 25.0),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.only(right: 20.0),
              child: Image.asset(image,
              width: 60,
              height: 60,
              ),
            ),
            Flexible(
              child: Container(
                padding: EdgeInsets.only(right: 10.0),
                child: Text(text,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            // Other widgets in your Row
          ],
        ),
      ),
    );
  }
}