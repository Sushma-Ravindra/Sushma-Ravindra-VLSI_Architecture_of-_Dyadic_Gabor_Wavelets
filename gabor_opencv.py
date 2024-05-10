import numpy as np
import cv2
import matplotlib.pyplot as plt

ksize = 5 # Adjust the kernel size to an odd number

theta = np.pi
lamda = 1*np.pi/4

sigma = 3; 
gamma = 0.5
phi = 0

kernel = cv2.getGaborKernel((ksize, ksize), sigma, theta, lamda, gamma, phi, ktype=cv2.CV_32F)

print(kernel)

kernel_resize = cv2.resize(kernel,(400,400))

#image = cv2.imread('/Users/sushma/Desktop/mr PE/test_image_gabor.jpg')

image = cv2.imread('/Users/sushma/Desktop/medicalimg2.png')
img = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

fimage = cv2.filter2D(img, cv2.CV_8UC3, kernel)

#cv2.imshow('Original Image', img)
cv2.imshow('Filtered Image', fimage)
cv2.imshow('Gabor Kernel', kernel_resize)

cv2.waitKey(0)
cv2.destroyAllWindows()
