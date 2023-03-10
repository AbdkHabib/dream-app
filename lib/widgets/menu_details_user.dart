import 'package:dream/models/marital_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MenuDetailsUser extends StatefulWidget {
  MenuDetailsUser({
    Key? key,
    required List<MaritalStatus> maritalstatus,
    required String title,
      int? selectedId,
    // required Color backGroundColor
  })  : _maritalstatus = maritalstatus,
        _title = title,
        _selectedId = selectedId,
        // _backGroundColor=backGroundColor,
        super(key: key);

  final List<MaritalStatus> _maritalstatus;
  final String _title;
  int? _selectedId;

  @override
  State createState() => _MenuDetailsUserState();
}

class _MenuDetailsUserState extends State<MenuDetailsUser> {
  // int? _selectedId;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.w),
        border: Border.all(color: Colors.lightBlueAccent),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0.w,vertical: 8.h),
        child: DropdownButton<int>(
          // itemHeight: 60,
          underline: SizedBox(),
          borderRadius: BorderRadius.circular(10.r),
          dropdownColor: Colors.blue.shade100,
          isExpanded: true,
          onChanged: (int? value) {
            setState(() => widget._selectedId = value);
          },
          value: widget._selectedId,
          hint: Text(widget._title),
          menuMaxHeight: 150.h,
          items: widget._maritalstatus.map((MaritalStatus maritalstatus) {
            return DropdownMenuItem<int>(
              alignment: AlignmentDirectional.bottomEnd,
              value: maritalstatus.id,
              child: Container(
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 6.0),
                  child: Text(maritalstatus.name),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey, width: 1.w),
                    ),
                  )),
            );
          }).toList(),
        ),
      ),
    );
  }
}
