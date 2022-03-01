import 'package:socket_io_client/socket_io_client.dart' as IO;

class BookSocketIo {
  static final instance = BookSocketIo._private();
  BookSocketIo._private();
  IO.Socket socket = IO.io('http://localhost:3000');

  void initConnectToSocket() {
    socket.onConnect((_) {
      print('connected...');
    });
    socket.on('book-car', (data) {
      print(data);
    });
    socket.onDisconnect((_) => print('disconnect'));
  }

  void sendBookCarRequest(String userName) {
    socket.emit('book-car', {"username": userName});
  }
}
