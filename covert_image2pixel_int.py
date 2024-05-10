import cv2
import numpy as np
from PIL import Image

# Open the image and convert it to grayscale
img = Image.open(r'/Users/sushma/Desktop/mr pe/images/circle_512x512.jpeg').convert('L')

# Convert the image to a NumPy array
img_array = np.array(img)

# Resize the array to 128x128
arr = cv2.resize(img_array, (512, 512))

file1 = open("output.txt", 'w')

for i in range(512):
    for j in range(512):
        # Write the integer value to the file
        file1.write(str(arr[i][j]))
        file1.write("\n")

file1.close()
