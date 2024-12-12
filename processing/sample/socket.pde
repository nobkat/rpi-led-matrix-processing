import java.net.*;
import java.io.*;
import java.awt.image.BufferedImage;
import javax.imageio.ImageIO;

Socket socket;
OutputStream outputStream;

void setupSocket() {
  try {
    socket = new Socket("127.0.0.1", 5000);
    outputStream = socket.getOutputStream();
    println("Connected to Python server");
  } catch (Exception e) {
    e.printStackTrace();
  }
}

void sendImage(){
  PImage canvasImage = get();

  try{
    ByteArrayOutputStream baos = new ByteArrayOutputStream();
    BufferedImage bufferedImage = (BufferedImage) canvasImage.getNative();
    ImageIO.write(bufferedImage, "png", baos);
    byte[] imageBytes = baos.toByteArray();

    if (outputStream != null) {
      outputStream.write(intToByteArray(imageBytes.length));
      outputStream.write(imageBytes);
      outputStream.flush();
    }
  } catch (Exception e) {
    e.printStackTrace();
  }
}

void stopSocket() {
  try {
    if (outputStream != null) outputStream.close();
    if (socket != null) socket.close();
  } catch (IOException e) {
    e.printStackTrace();
  }
  super.stop();
}


byte[] intToByteArray(int value) {
  return new byte[] {
    (byte)(value >> 24),
    (byte)(value >> 16),
    (byte)(value >> 8),
    (byte)value
  };
}
