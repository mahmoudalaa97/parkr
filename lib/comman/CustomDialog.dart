import 'package:flutter/material.dart';

class CustomDialog extends StatefulWidget {
  final String title;
  final String subTitle;
  final Widget content;
  final Color colorButton;
  final String textButton;
  final VoidCallback onTapButton;
  final VoidCallback onTapText;
  final Widget customLeft;
  final Color colorTextButton;

  const CustomDialog({Key key, this.title, this.subTitle, this.content, this.colorButton, this.textButton, this.onTapButton, this.onTapText, this.customLeft, this.colorTextButton}) : super(key: key);

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 20.0,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(17)),
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20,top: 15),
              child: Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.clear,size: 25,)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(19.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      widget.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 35),
                    ),
                    Text(
                      widget.subTitle,
                      style: TextStyle(fontSize: 11),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Align(
                alignment: Alignment.center,
                child: widget.content,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                widget.customLeft==null?   InkWell(
                      onTap: widget.onTapText,
                      child: Text(
                        "Having issue?",
                        style: TextStyle(
                            color: Colors.grey.withOpacity(0.7), fontSize: 12),
                      )):widget.customLeft,
                  RaisedButton(
                    onPressed: widget.onTapButton,
                    color: widget.colorButton==null?Color(0xffFAC758):widget.colorButton,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(19)),
                    child: Text(widget.textButton==null?"Next":widget.textButton,style: TextStyle(color: widget.colorTextButton==null?Colors.black:widget.colorTextButton),),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
