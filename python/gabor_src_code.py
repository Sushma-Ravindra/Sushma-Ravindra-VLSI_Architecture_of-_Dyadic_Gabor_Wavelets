import numpy as np
import cv2
import matplotlib.pyplot as plt
import math
import matplotlib.image as mpimg
import pandas as pd
import numpy as np
from PIL import Image

def getGaborKernel_test(ksize, sigma_x, sigma_y, theta, freq, gamma, psi, ktype):
    nstds = 3
    xmin, xmax, ymin, ymax = 0, 0, 0, 0
    c = math.cos(theta)
    s = math.sin(theta)
    
    if ksize[0] > 0:
        xmax = ksize[0] // 2
    else:
        xmax = np.round(max(abs(nstds * sigma_x * c), abs(nstds * sigma_y * s)))
    
    if ksize[1] > 0:
        ymax = ksize[1] // 2
    else:
        ymax = np.round(max(abs(nstds * sigma_x * s), abs(nstds * sigma_y * c)))
    
    xmin = -xmax
    ymin = -ymax
    
#    assert ktype == np.float32 or ktype == np.float64
    
    kernel = np.zeros((ymax - ymin + 1, xmax - xmin + 1)) #, dtype=ktype)
    scale = 512
    ex = -0.5 / (sigma_x * sigma_x)
    ey = -0.5 / (sigma_y * sigma_y)
    cscale = np.pi*2*freq
    
    for y in range(ymin, ymax + 1):
        for x in range(xmin, xmax + 1):
            xr = x * c + y * s
            yr = -x * s + y * c
#            v = scale * (1 / (np.pi*2 * sigma_x * sigma_y)) * math.exp(ex * xr * xr + ey * yr * yr) * math.cos(cscale * xr + psi)
            v = scale * math.exp(ex * xr * xr + ey * yr * yr) * math.cos(cscale * xr + psi)
                      
            if ktype == np.float32:
                kernel[ymax + y, xmax + x] = np.float32(v)  ##xmax  - x
            else:
                kernel[ymax + y, xmax + x] = np.float32(v)  ##xmax - x
                
            kernel_round = np.round(kernel)    
    
    return kernel_round


df = pd.DataFrame()
ksize = 5
sigma = 3.18   ###2.2487
sigmax = 4.4974
sigmay = 2.2487
f = 0.125
theta = 1*np.pi/3.913

#30.6         46       60.7        90.8     120.1        136.8       150.8       180
#5.8823       3.913    2.9654     1.9823    1.4987       1.3157      1.1936 

lamda = 0.125     ##1*np.pi/4
gamma = 1
phi = 0

    
kernel1 = getGaborKernel_test((ksize,ksize), sigmax, sigmay, theta, lamda, gamma, phi, ktype=cv2.CV_32F)
print(kernel1)
img = cv2.imread('/Users/sushma/Desktop/medicalimg3.png')
img = cv2.resize(img, (512,512))
kernel2 = kernel1/512
print(kernel1)
print(kernel2)
#img = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)


# Convert the image to a NumPy array
#img_array = np.array(img)
#temp_arr = []
#
#file1 = open("pixel_black.txt", 'w')
#
#
#for i in range(128):
#    for j in range(128):
#        # Assuming img_array contains pixel values as integers
#        pixel_value = img_array[i][j]
#        file1.write(str(pixel_value) + "\n")
#
#file1.close()
#



fimg = cv2.filter2D(img, cv2.CV_8UC3, kernel2)

print(fimg)

#plt.imshow(kernel1)
cv2.imshow('original_image', img)
cv2.imshow('filtered_image', fimg)
cv2.imwrite('filtered_image90.png', fimg)
#df.to_csv ('Gabor.csv')
cv2.waitKey(0)
cv2.destroyAllWindows()
