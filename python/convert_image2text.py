import cv2
import numpy as np
from PIL import Image

# Open the image and convert it to grayscale
#img = Image.open(r'/Users/sushma/Desktop/mr pe/test_image_gabor.jpg').convert('L')
img = Image.open(r'/Users/sushma/Desktop/mr pe/images/circle_512x512.jpeg').convert('L')
# Convert the image to a NumPy array
img_array = np.array(img)



# Resize the array to 128x128
arr = cv2.resize(img_array, (512,512))
print (arr)




temp_arr = []

def convert(number):
    binary = bin(number)[2:]  # Convert the decimal number to binary and remove the '0b' prefix
    padded = binary.zfill(8)
    return(padded)


file1 = open("output1.txt", 'w')
#file1.write("memory_initialization_radix=2;")
#file1.write("\n")
#file1.write("memory_initialization_vector=")
for i in range(512):
    for j in range(512):
        temp_arr.append(convert(arr[i][j]))
        file1.writelines(temp_arr)
       # file1.write("")
        file1.write("\n")
        temp_arr=[]
file1.close()