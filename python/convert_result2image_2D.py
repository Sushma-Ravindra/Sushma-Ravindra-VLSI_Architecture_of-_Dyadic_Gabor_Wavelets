import numpy as np
from PIL import Image

# Read the contents of the file
with open('res180.txt', 'r') as file:
    file_content = file.read()

# Replace 'x' with '0' in the file content
modified_content = file_content.replace('x', '0')

# Write the modified content back to the file
with open('res_180_modified.txt', 'w') as file:
    file.write(modified_content)

# Split the content into individual values
values = modified_content.strip().split()

# Initialize the array
array = np.zeros((128, 128), dtype=np.uint8)

# Fill the array
for i, val in enumerate(values):
    row = i % 128  # Calculate the row index
    col = i // 128  # Calculate the column index
    if len(val) >= 19:
        # Extract the 8 least significant bits and convert to integer
        extracted_value = int(val[-8:], 2)
        print(f"Value at ({row}, {col}): {extracted_value}")
        array[row, col] = extracted_value
    else:
        print(f"Invalid value at index {i}: {val}")

# Convert the array to an image
image = Image.fromarray(array)
print(array)
print(array.shape)

# Display the image
image.show()