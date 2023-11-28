# play_audio

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

For generating the custom mp3 files I used this python script:
from gtts import gTTS

def text_to_speech(text, filename):
    tts = gTTS( text=text, lang='en' )  
    tts.save( filename )

word = "hello"
filename = "hello.mp3"
text_to_speech( word, filename )
