from PIL import Image, ImageDraw
import rgbmatrix

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
    options.brightness = 100
    options.hardware_mapping = "adafruit-hat"

    matrix = rgbmatrix.RGBMatrix(options=options)

    # Canvas setting
    image = Image.new("RGB", (64, 64))
    draw = ImageDraw.Draw(image)
    draw.rectangle((1,10, 20, 30), fill=(10,40,100))

    while True:
        matrix.SetImage(image)

if __name__ == "__main__":
    main()
