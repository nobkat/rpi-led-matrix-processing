# rpi-led-matrix-processing

Raspberry Pi上のProcessingからマトリックスLEDを表示させるサンプル

## しくみ

ProcessingからSocket通信でマトリックスLEDを制御するPythonで作ったサーバーにデータを送る

## 必要なもの

- Matrix LED (HUB75に対応しているもの)
- Raspberry Pi (スペック的に4以上がよいかも)
- [Adafruit RGB Matrix Bonnet for Raspberry Pi](https://learn.adafruit.com/adafruit-rgb-matrix-bonnet-for-raspberry-pi/) など

## 動作方法

1. [rpi-rgb-led-matrix](https://github.com/hzeller/rpi-rgb-led-matrix/tree/master)のPython用ライブラリを[ドキュメント](https://github.com/hzeller/rpi-rgb-led-matrix/tree/master/bindings/python)に従ってインストールする。
2. [Processingをダウンロード](https://processing.org/download)してインストールする。
3. Python側のプログラム実行に必要なライブラリ(pillow, websockets)をインストールする。
4. 本リポジトリのmain.pyを実行する。
5. Processingを起動し、本リポジトリのprocessing/sample_pdeを開く