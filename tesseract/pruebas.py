import cv2 
import pytesseract

print("PRUEBAS DE TESSERACT\n\n")

img = cv2.imread('presc-test.jpg')

# Adding custom options
custom_config = r'--oem 3 --psm 6'
string = pytesseract.image_to_string(img, config=custom_config)
print(string)

#string = pytesseract.image_to_string(img)
#print(string)
print("FUNCIONAAAAA")