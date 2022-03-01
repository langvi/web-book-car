import 'dart:async';

import 'package:flutter/material.dart';

class TripSlider extends StatefulWidget {
  final void Function() onEndTrip;
  TripSlider({Key? key, required this.onEndTrip}) : super(key: key);

  @override
  State<TripSlider> createState() => _TripSliderState();
}

class _TripSliderState extends State<TripSlider> {
  double _value = 0;
  Timer? _timer;
  @override
  void initState() {
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      if (_value >= 10) {
        widget.onEndTrip();
        _timer?.cancel();
      } else {
        setState(() {
          _value += 0.1;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Slider(value: _value, min: 0, max: 10, onChanged: (v) {});
  }
}
