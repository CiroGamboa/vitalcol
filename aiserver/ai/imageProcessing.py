import cv2
import numpy as np


def grab_image(path=None, stream=None, url=None):
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


