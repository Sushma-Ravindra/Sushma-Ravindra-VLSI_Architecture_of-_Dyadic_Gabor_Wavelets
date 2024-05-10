import cv2

# Load the images
image1 = cv2.imread('/Users/sushma/Desktop/filtered_image45.png')
image2 = cv2.imread('/Users/sushma/Desktop/filtered_image90.png')
image3 = cv2.imread('/Users/sushma/Desktop/filtered_image135.png')
image4 = cv2.imread('/Users/sushma/Desktop/filtered_image180.png')

# Resize images to the same dimensions if necessary
# You can use cv2.resize() for resizing

# Superimpose the images
result = cv2.addWeighted(image1, 0.5, image2, 0.5, 0)
result = cv2.addWeighted(result, 0.5, image3, 0.5, 0)
result = cv2.addWeighted(result, 0.5, image4, 0.5, 0)

# Display or save the result
cv2.imshow('Superimposed Images', result)
cv2.waitKey(0)
cv2.destroyAllWindows()
