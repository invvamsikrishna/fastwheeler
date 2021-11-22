import 'package:fastwheeler/components/common_widget.dart';
import 'package:fastwheeler/utils/counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../size_config.dart';

class ReferScreen extends StatefulWidget {
  const ReferScreen({Key? key}) : super(key: key);

  @override
  _ReferScreenState createState() => _ReferScreenState();
}

class _ReferScreenState extends State<ReferScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Refer and Earn"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              "Invite Your Friend And Earn Money",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.lightGreen,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Image.asset(
            "assets/images/friend.png",
            height: SizeConfig.screenHeight * 0.22,
          ),
          Column(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
                child: Text(
                  'Share Your referral link and invite your friends via SMS/Email/Whatsapp. You earn upto ₹ 100',
                  style: TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Image.asset(
                "assets/images/ref.png",
                height: 70,
                fit: BoxFit.fill,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Your Referral Code',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black38),
                  borderRadius: BorderRadius.circular(5),
                ),
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Text(
                  context.read<Counter>().refer,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(primary: Colors.lightGreen),
                    icon: Icon(Icons.copy_rounded),
                    label: Text(
                      'Tap to Copy',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(
                        text: context.read<Counter>().refer,
                      )).then(
                        (value) => ShowSnackBar(context, "Text Copied"),
                      );
                    },
                  ),
                  SizedBox(width: 20),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(primary: Colors.lightGreen),
                    icon: Icon(Icons.share),
                    label: Text(
                      'Refer Now',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  '* Terms & Conditions *',
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
