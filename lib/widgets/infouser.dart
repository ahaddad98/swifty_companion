import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class InfoUser extends StatefulWidget {
  final data;
  InfoUser({super.key, required this.data});

  @override
  State<InfoUser> createState() => _InfoUserState();
}

class _InfoUserState extends State<InfoUser> {


  @override
  void initState() {
    print(widget.data);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            width: 120,
            height: 120,
            child: new ListView(
              children: [
                ClipRRect(
                  // clipBehavior: Clip.hardEdge,
                  // borderRadius: BorderRadius.circular(100.0),
                  // child: Image.network(widget.data['image']['link']),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('username'),
              // SizedBox(height: 10),
              // Text('Wallet'),
              // SizedBox(height: 10),
              // Text('Collision'),
              // SizedBox(height: 10),
              // Text('correction_point'),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(widget.data['login'].toString()),
              // SizedBox(height: 10),
              // Text(widget.data['wallet'].toString()),
              // SizedBox(height: 10),
              // Text('Collision'),
              // SizedBox(height: 10),
              // Text(widget.data['correction_point'].toString()),
            ],
          )
        ],
      ),
    );
  }
}
