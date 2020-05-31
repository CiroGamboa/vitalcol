import cv2
import numpy as np
import pytesseract
from .stringAnalysis import process_string


def grab_image(path=None, stream=None, url=None):
	# if the path is not None, then load the image from disk
    if path is not None:
        image = cv2.imread(path)
        print("Sirvio")
        custom_config = r'--oem 3 --psm 6'
        string = pytesseract.image_to_string(image, config=custom_config)
        
        result = process_string(string)
        print(result)
	# otherwise, the image does not reside on disk
    else:	
		# if the URL is not None, then download the image
        if url is not None:
            print("No hay URL")
		# if the stream is not None, then the image has been uploaded
        elif stream is not None:
            data = stream.read()
		# convert the image to a NumPy array and then read it into
		# OpenCV format
        image = np.asarray(bytearray(data), dtype="uint8")
        image = cv2.imdecode(image, cv2.IMREAD_COLOR)
        print("IMAGEN LEÍDA CORRECTAMENTE")

        custom_config = r'--oem 3 --psm 6'
        string = pytesseract.image_to_string(image, config=custom_config)
        
        result = process_string(string)
        print(result)


	# return the image
    return result    


def grab_image3(image):
    custom_config = r'--oem 3 --psm 6'
    string = pytesseract.image_to_string(image, config=custom_config)
    
    result = process_string(string)
    print(result)

	# return the image
    return result    




def grab_image2(path=None, stream=None, url=None):
	# if the path is not None, then load the image from disk
    if path is not None:
        image = cv2.imread(path)
        print("Sirvio")
	# otherwise, the image does not reside on disk
    else:	
		# if the URL is not None, then download the image
        if url is not None:
            print("No hay URL")
		# if the stream is not None, then the image has been uploaded
        elif stream is not None:
            data = stream.read()
		# convert the image to a NumPy array and then read it into
		# OpenCV format
        image = np.asarray(bytearray(data), dtype="uint8")
        image = cv2.imdecode(image, cv2.IMREAD_COLOR)
        print("Imagen leida correctamente")
 
	# return the image
    return image


def grab_image5(img):
    custom_config = r'--oem 3 --psm 6'
    #img = Image.open('foto_prescripcion.jpeg')
    string = pytesseract.image_to_string(img, config=custom_config)
    result = process_string(string)
    print(result)
    return result


