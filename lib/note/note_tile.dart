import 'package:flutter/material.dart';


class NoteTile extends StatelessWidget {
  final String title;
  final String subtitle;

  NoteTile({this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(13),
      ),

      child: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize:MainAxisSize.min ,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600),),
              SizedBox(height: 10,),
              Text(subtitle,style: TextStyle(fontSize: 20,color: Colors.black87),),
            ],
          ),
        ),
      ),
    );
  }
}
