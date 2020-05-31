from django.shortcuts import render
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt

from .forms import UploadFileForm
from .ai import imageProcessing 
import requests


# Method for receiving a file a extract characters

@csrf_exempt
def process_file(request):
    if request.method == 'POST':
        #
        print('HEADERS:', request.headers)
        #print('BODY:', request.body)

        if request.FILES.get("photo", None) is not None:
			# grab the uploaded image
            # Image sería la imagen que se envía a Firebase
            responseData = imageProcessing.grab_image(stream=request.FILES["photo"])
            #responseData = {
            #    'success' : True 
            #}
        
        else:
            print("No se envio")
            responseData = {
                'success' : False
            }

    else:
        responseData = {
            'success' : False
        }

    # Se deben devolver las caracteristicas de la imagen
    return JsonResponse(responseData)


@csrf_exempt
def test_db(request):
    # Codigo para probar la conexion con la DB

    db_test_success = True

    if(db_test_success):
        return JsonResponse({'success' : True})
    
    else:
        return JsonResponse({'success' : False})


@csrf_exempt
def getResult(request, id, url):

    print("Id:",id)
    print("Url",url)

    #url = 'https://firebasestorage.googleapis.com/v0/b/vitalcol.appspot.com/o/WhatsApp%20Image%202020-05-31%20at%201.45.20%20PM.jpeg?alt=media&token=70663696-e7e9-4a43-a73b-9adcadca0795'
    #r = requests.get(url, allow_redirects=True)

    #try:
    #open('temp.jpg', 'wb').write(r.content)
    #responseData = imageProcessing.grab_image(path='temp.jpg')
    
    #except:
    responseData = {'success' : False}

    # Se deben devolver las caracteristicas de la imagen
    return JsonResponse(responseData)
    




    

