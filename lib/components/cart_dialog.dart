import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sohil_jd/services/cart_service.dart';
import 'package:sohil_jd/services/time_picker.dart';
import 'package:sohil_jd/shared/colors.dart';
import 'package:sohil_jd/shared/ui_helper.dart';

class CartDialog extends StatefulWidget {
  var resto, item;
  bool sameDayPickup;

  CartDialog({this.resto, this.item,this.sameDayPickup});

  @override
  _CartDialogState createState() => _CartDialogState();
}

class _CartDialogState extends State<CartDialog> {

String _selectedDay;
DateTime _selectedTime;
Text notifyText = Text("");
bool _timeCheck = false;
bool _dayCheck = false;
  @override
  Widget build(BuildContext context) {
    widget.sameDayPickup?_dayCheck=true:null;
    return Dialog(
      child: Container(
        height: 180,
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Center(
                child: Column(
              children: [
                Text("Select time between"),
                Text(myToDate(widget.resto['timeFrom']) +
                    " and " +
                    myToDate(widget.resto['timeTo']) +
                    " ONLY"),
                notifyText
              ],
            )),

            // Center(child: Text("Select time from ${DateFormat.jm().format(DateTime.parse(widget.resto['timeForm']))}")),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.sameDayPickup?Container():DropdownButton(
                    onChanged: (value) {
                      setState(() {
                        _dayCheck = true;
                        _selectedDay = value;
                      });
                    },
                    value: _selectedDay,
                    hint: Text("Select Your Day"),
                    items: <DropdownMenuItem>[
                      ...List<DropdownMenuItem>.generate(
                          widget.resto['days'].length, (index) {
                        return DropdownMenuItem(
                            child: Text(widget.resto['days'][index]),
                            value: widget.resto['days'][index]);
                      })
                    ]),
                horizontalSpaceSmall,
                TextButton(
                  onPressed: () {
                    TimePicker()
                        .getPicker(context,
                            "Select your pickup time from restro", "Let's go")
                        .then((val) {
                      if (val != null) {
                        _selectedTime = DateTime.parse(
                            "2020-05-07 ${val.hour.toString().padLeft(2, '0')}:${val.minute.toString().padLeft(2, '0')}:04Z");
                        bool a = isCurrentDateinRange(
                            _selectedTime,
                            DateTime.parse(widget.resto['timeFrom']),
                            DateTime.parse(widget.resto['timeTo']));
                        if(a){
                          setState(() {
                            _timeCheck = true;
                            notifyText = Text(DateFormat.jm().format(_selectedTime)+" Works",style: txColor(kPrim),);
                          });
                        }else{
                          setState(() {
                            _timeCheck = false;
                            notifyText = Text("Please enter valid time from window",style: txColor(kRed),);
                          });
                        }
                      }
                    });
                  },
                  child: Text("Select Time"),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                    onPressed: () {
                      _timeCheck = false;
                      _dayCheck = false;
                      _selectedDay = null;
                      Navigator.pop(context);
                    },
                    child: Text("Cancel")),
                horizontalSpaceSmall,
                widget.sameDayPickup?ElevatedButton(onPressed: _timeCheck?(){

                  Provider.of<CartService>(context,listen: false).addToCart(
                      itemId: widget.item['itemid'],
                      item: widget.item,
                      selectedTime: _selectedTime,
                      selectedDay: _selectedDay,
                      qty: 1,
                      restoId: widget.resto['restoid'],
                      restoName: widget.resto['name']
                  );

                  Navigator.pop(context);
                }:null, child: Text("Set")):ElevatedButton(onPressed: _timeCheck&&_dayCheck?(){

                  Provider.of<CartService>(context,listen: false).addToCart(
                      itemId: widget.item['itemid'],
                      item: widget.item,
                      selectedTime: _selectedTime,
                      selectedDay: _selectedDay,
                      qty: 1,
                      restoId: widget.resto['restoid'],
                      restoName: widget.resto['name']
                  );
                  Navigator.pop(context);
                }:null, child: Text("Set")),
              ],
            )
          ],
        ),
      ),
    );
  }

  bool isCurrentDateinRange(
      DateTime selectedTime, DateTime startTime, DateTime endTime) {
    return selectedTime.isAfter(startTime) && selectedTime.isBefore(endTime);
  }
}
