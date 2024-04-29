# Load the image you want to convert to a VHDL R, G & B matrix representation, 
# this Python script will provide you the .txt file with the code you can paste
# into the VGA drawing entity.

# For instance, if you run it without modification, you'll get a file 
# with a structure like this one:
# constant FRAME_N_DATA  std_int_matrix = (
#   (4,  3,  3,  3,  3),
#	  (4,  3,  2,  3,  3),
#	  (4,  4,  2,  3,  3),
#	  (4,  4,  3,  4,  3),
#	  (4,  4,  3,  3,  3)
# );

# Modify global constants as you need.

import cv2
import numpy as np

WIDTH = 5
HEIGHT = 5
IMAGE_PATH = 'image.png'
MATRIX_FILE_PATH = 'matrix.txt'
VHDL_FILE_PATH = vhdl.txt

def rescale_image(image, width = WIDTH, height = HEIGHT)
    return cv2.resize(image, (width, height))

def assign_color_value(pixel)

    # Define color values

    blue = np.array([255, 0, 0])
    green = np.array([0, 255, 0])
    red = np.array([0, 0, 255])
    white = np.array([255, 255, 255])
    black = np.array([0, 0, 0])

    # Calculate the Euclidean distances from the pixel to each color (blue, green, red, white, black)

    dist_to_blue = np.linalg.norm(pixel - blue)
    dist_to_green = np.linalg.norm(pixel - green)
    dist_to_red = np.linalg.norm(pixel - red)
    dist_to_white = np.linalg.norm(pixel - white)
    dist_to_black = np.linalg.norm(pixel - black)

    # Determine which color is closest

    min_dist = min(dist_to_blue, dist_to_green, dist_to_red, dist_to_white, dist_to_black)

    if min_dist == dist_to_blue
        return 0  # Blue
    elif min_dist == dist_to_green
        return 1  # Green
    elif min_dist == dist_to_red
        return 2  # Red
    elif min_dist == dist_to_black
        return 4  # Black
    else
        return 3  # White

def convert_to_rgb_values(image)

    # Create RGB values image

    rgb_values_image = np.zeros((image.shape[0], image.shape[1]), dtype=np.uint8)

    # Iterate through each pixel

    for i in range(image.shape[0])
        for j in range(image.shape[1])

            pixel = image[i, j]

            # Assign color value based on proximity to blue, green, red, white, or black

            rgb_values_image[i, j] = assign_color_value(pixel)

    return rgb_values_image

def parse_matrix_txt_to_vhdl(matrix_file_path, vhdl_output_file)

    with open(matrix_file_path, r) as file

        matrix_lines = file.readlines()

    vhdl_code = constant FRAME_N_DATA  std_int_matrix = (n

    for line in matrix_lines

        # Remove square brackets and split values

        values = line.strip()[1-1].split(,)
        vhdl_code += t( + , .join(values) + ),n
    
    vhdl_code = vhdl_code.rstrip(,n) + n);

    # Save VHDL code to output file

    with open(vhdl_output_file, w) as output_file
        output_file.write(vhdl_code)

# Load the image

image = cv2.imread(IMAGE_PATH)

if image is None

    print(Error Unable to load image.)

else

    # Rescale the image

    rescaled_image = rescale_image(image)

    # Convert the image to RGB values representation

    rgb_values_image = convert_to_rgb_values(rescaled_image)

    # Save the matrix representation to a file

    with open(MATRIX_FILE_PATH, w) as f

        for row in rgb_values_image.tolist()

            f.write([ + , .join(map(str, row)) + ]n)

parse_matrix_txt_to_vhdl(MATRIX_FILE_PATH, VHDL_FILE_PATH)
print(VHDL code saved to, VHDL_FILE_PATH)
