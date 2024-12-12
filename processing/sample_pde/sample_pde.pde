import java.io.*;
import java.net.*;

Socket socket;
PrintWriter output;

void setup() {
  size(400, 400);

  try {
    // Pythonサーバーに接続（IPアドレスとポート番号を指定）
    socket = new Socket("127.0.0.1", 5000);
    output = new PrintWriter(socket.getOutputStream(), true);
    println("Connected to Python server");
  } catch (Exception e) {
    e.printStackTrace();
  }
}

void draw() {
  background(200);

  // データを送信
  String data = "Hello from Processing: " + frameCount;
  sendData(data);

  // FPSに合わせて少し待つ
  delay(1000 / 30);
}

void sendData(String data) {
  if (output != null) {
    output.println(data);
    println("Sent: " + data);
  }
}

void stop() {
  // ソケットを閉じる
  try {
    if (output != null) output.close();
    if (socket != null) socket.close();
  } catch (Exception e) {
    e.printStackTrace();
  }
  super.stop();
}
