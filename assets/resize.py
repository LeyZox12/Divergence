import sys
from PIL import Image
import os
import time

path = os.path.dirname(__file__)

imgs = [o for o in os.listdir(path + "/1x/") if ".png" in o] 
print(path)
print(imgs)
for i in imgs:
    imgFile = Image.open(path + "/1x/" + i)
    
    new_size = (imgFile.width * 2, imgFile.height * 2)
    resized_image = imgFile.resize(new_size, Image.NEAREST)  # NEAREST resampling preserves pixelation


    resized_image.save(path + "/2x/" + i)