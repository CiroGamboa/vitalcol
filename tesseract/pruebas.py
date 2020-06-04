import cv2 
import pytesseract

print("PRUEBAS DE TESSERACT\n\n")

name = 'test2.jpeg'
print(name)
img = cv2.imread(name)

# Adding custom options
custom_config = r'--oem 3 --psm 6'
osd = pytesseract.image_to_osd(img)
angle = re.search('(?<=Rotate: )\d+', osd).group(0)

print("angle:",angle)
#string = pytesseract.image_to_string(img, config=custom_config)
#
#print(string)
print("FUNCIONAAAAA")