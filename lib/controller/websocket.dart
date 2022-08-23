import 'package:web_socket_channel/web_socket_channel.dart';
void WebSocket(){
  final socket= WebSocketChannel.connect(Uri.parse("ws://localhost:8000"));
  socket.sink.add("hello");
}

void main(){
  WebSocket();
}