import 'package:flutter/material.dart';
import 'package:gmapapp/domain/models/location_model.dart';

class HomeScreenTile extends StatelessWidget {
  final void Function()? onTap;
 final LocationModel? locationModel;

  const HomeScreenTile({Key? key, this.onTap,this.locationModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[200],
          boxShadow: const [
            BoxShadow(color: Colors.black54, blurRadius: 2),
          ],
        ),
        child:  Column(
          children: [
            SingleLineTags(
              tagLeftTitle: "From Location",
              tagRightTitle: "To Location",
              tagLeftSubTitle: (locationModel?.address??"").toString(),
              tagRightSubTitle:(locationModel?.address??"").toString() ,
            ),
            const SingleLineTags(
              tagLeftTitle: "From Time : ",
              tagRightTitle: "To Time : ",
            ),
            SingleLineTags(
              tagLeftTitle: "Total Distance : ",
              tagLeftSubTitle: (locationModel?.distance??"").toString() ,
            ),
             SingleLineTags(
              tagLeftTitle: "Battery Usage : ",
              tagLeftSubTitle: (locationModel?.extBatteryVoltage??"").toString() ,
            ),
          ],
        ),
      ),
    );
  }
}

class SingleLineTags extends StatelessWidget {
  final String? tagLeftTitle;
  final String? tagRightTitle;
  final String? tagLeftSubTitle;
  final String? tagRightSubTitle;

  const SingleLineTags(
      {Key? key,
      this.tagLeftTitle,
      this.tagRightTitle,
      this.tagLeftSubTitle,
      this.tagRightSubTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Text("${tagLeftTitle ?? ""}  ${tagLeftSubTitle??""}")),
        if (tagRightTitle != null)
          Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: Text("${tagRightTitle ?? ""}   ${tagLeftSubTitle??""}"))
      ],
    );
  }
}
