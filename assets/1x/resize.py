import sys
from PIL import Image
import os
import time

def upscale_pixel_art(input_image, output_directory, fileName):
    # Double the size
    new_size = (input_image.width * 2, input_image.height * 2)
    resized_image = input_image.resize(new_size, Image.NEAREST)  # NEAREST resampling preserves pixelation

    # Save the resized image
    output_image_path = os.path.join(output_directory, fileName)
    resized_image.save(output_image_path)
imgs = [o for o in os.listdir("C:/Users/leo84/AppData/Roaming/Balatro/Mods/PlaceholderMod/assets/1x") if ".png" in o] 
for i in imgs:
    imgFile = Image.open("C:/Users/leo84/AppData/Roaming/Balatro/Mods/PlaceholderMod/assets/1x" + "/" + i)
    upscale_pixel_art(imgFile, "C:/Users/leo84/AppData/Roaming/Balatro/Mods/PlaceholderMod/assets/2x/", i)