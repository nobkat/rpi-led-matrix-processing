from io import BytesIO

from PIL import Image, ImageDraw
import rgbmatrix
import socket


HOST = "127.0.0.1"
PORT = 5000

def receive_data(client_socket):
    data_length = int.from_bytes(client_socket.recv(4), byteorder='big')

    data = b""
    while len(data) < data_length:
        packet = client_socket.recv(data_length - len(data))
        if not packet:
            break
        data += packet

    return data

def main(
    size=(64,64),
    platform="adafruit-hat",
):
    width, height = size

    options = rgbmatrix.RGBMatrixOptions()
    options.cols = width
    options.rows = height
    options.chain_length = 1
    options.parallel = 1
    options.gpio_slowdown = 4 #gets rid of flickering leds on my Pi3
    options.drop_privileges = False  # allow images to be loaded
    options.show_refresh_rate = False
    options.brightness = 70
    options.hardware_mapping = "adafruit-hat"

    matrix = rgbmatrix.RGBMatrix(options=options)

    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as server_socket:
        server_socket.bind((HOST, PORT))
        server_socket.listen(1)
        print(f"Server listening on {HOST}:{PORT}")

        client_socket, addr = server_socket.accept()
        print(f"Connection established with {addr}")

        try:
            while True:
                # Receive image data from processing
                image_data = receive_data(client_socket)
                image = Image.open(BytesIO(image_data))
                matrix.SetImage(image)

        except KeyboardInterrupt:
            print("\nServer shutting down.")
        finally:
            client_socket.close()
            

if __name__ == "__main__":
    main()




