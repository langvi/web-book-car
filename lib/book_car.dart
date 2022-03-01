import 'package:flutter/material.dart';
import 'package:web_book_car/trip_slider.dart';
import 'package:web_book_car/waiting_view.dart';

enum BookStatus { loading, found, notfound, done, other }

class BookCarPage extends StatefulWidget {
  BookCarPage({Key? key}) : super(key: key);

  @override
  State<BookCarPage> createState() => _BookCarPageState();
}

class _BookCarPageState extends State<BookCarPage> {
  BookStatus _currentStatus = BookStatus.other;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book car Demo"),
      ),
      body: Center(
        child: _buildViewByStatus(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          Icons.message,
          color: Colors.orange,
        ),
      ),
    );
  }

  Widget _buildViewByStatus() {
    switch (_currentStatus) {
      case BookStatus.other:
        return ElevatedButton(
            onPressed: () {
              handleBookCar();
            },
            child: Text("Book car now"));
      case BookStatus.loading:
        return WaitingView();
      case BookStatus.found:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Found driver. Start the trip...',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            TripSlider(
              onEndTrip: () {
                setState(() {
                  _currentStatus = BookStatus.done;
                });
              },
            )
          ],
        );
      case BookStatus.notfound:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Driver not found...'),
            TextButton(
                onPressed: () {
                  handleBookCar();
                },
                child: Text('Try again'))
          ],
        );
      default:
        return Text(
          'Trip completed',
          style: TextStyle(fontSize: 20),
        );
    }
  }

  void handleBookCar() async {
    setState(() {
      _currentStatus = BookStatus.loading;
    });
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _currentStatus = BookStatus.found;
    });
  }
}
