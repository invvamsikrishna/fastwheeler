import 'package:flutter/material.dart';
import '../constants.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key? key,
    required this.text,
    required this.press,
  }) : super(key: key);
  final String text;
  final Function() press;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: press,
      style: ElevatedButton.styleFrom(
        primary: kPrimaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(8.0),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}

class DefaultButton2 extends StatelessWidget {
  const DefaultButton2({
    Key? key,
    required this.text,
    required this.press,
  }) : super(key: key);
  final String text;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () => press(),
      style: OutlinedButton.styleFrom(
        shape: StadiumBorder(),
        side: BorderSide(color: kPrimaryColor, width: 2),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          color: kPrimaryColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class DefaultButton3 extends StatelessWidget {
  const DefaultButton3({
    Key? key,
    required this.text,
    required this.press,
    required this.icon,
  }) : super(key: key);
  final String text;
  final Function press;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () => press(),
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.all(10),
        shape: StadiumBorder(),
        side: BorderSide(color: Colors.blue, width: 2),
      ),
      label: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          color: Colors.blue,
          fontWeight: FontWeight.w600,
        ),
      ),
      icon: Icon(icon),
    );
  }
}

class DefaultFullButton extends StatelessWidget {
  const DefaultFullButton({Key? key, required this.text, required this.press})
      : super(key: key);
  final String text;
  final Function() press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: press,
        style: ElevatedButton.styleFrom(
          primary: kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(8.0),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}

class DefaultLargeButton extends StatelessWidget {
  const DefaultLargeButton({Key? key, required this.text, required this.press})
      : super(key: key);
  final String text;
  final Function() press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: press,
        style: ElevatedButton.styleFrom(
            primary: kPrimaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(8.0),
            ),
            padding: EdgeInsets.all(10)),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
