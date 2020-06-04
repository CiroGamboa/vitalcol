from django.shortcuts import render
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt

from .forms import UploadFileForm
from .ai import imageProcessing 
import requests
import json
import ast
from PIL import Image



# Method for receiving a file a extract characters

@csrf_exempt
def process_file(request):
    if request.method == 'POST':
        #
        #print('HEADERS:', request.headers)
        #print('BODY:', request.body)

        if request.FILES.get("photo", None) is not None:
			# grab the uploaded image
            # Image sería la imagen que se envía a Firebase

            print("PROCESANDO IMAGEN")
            print("Usuario: ", "lSmYJby2xSTD8jXtmDIWolycW5w2\n")
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
def getResult(request):
    #try:
    #response = request.body.decode('utf-8')
    #j = json.dump(response)
    #print(j['idUsuario'])

    byte_str = request.body
    dict_str = byte_str.decode("UTF-8")
    mydata = ast.literal_eval(dict_str)
    print(mydata)


    '''
    idUsuario = request.POST.get('idUsuario', '')
    url = request.POST.get('photo', '')
    print("Id:",idUsuario)
    print("Url",url)
    '''
    id_usuario = mydata['idUsuario']
    url = mydata['photo']
    descargar_imagen(url,'temp')


    img = Image.open('temp.jpeg')
    result = imageProcessing.grab_image5(img)



    #responseData = {'success' : True}
    responseData = result

    # Se deben devolver las caracteristicas de la imagen
    return JsonResponse(responseData)
    #except:
        #return JsonResponse({'success' : False})
    

def descargar_imagen(url, nombre_archivo):
    f = open(nombre_archivo+'.jpeg','wb')
    f.write(requests.get(url).content)
    f.close()


@csrf_exempt
def processImage(request):

    byte_str = request.body
    dict_str = byte_str.decode("UTF-8")
    mydata = ast.literal_eval(dict_str)
    print(mydata)

    id_usuario = mydata['idUsuario']
    url = mydata['photo']
    descargar_imagen(url,'temp')

    img = Image.open('temp.jpeg')
    result = imageProcessing.grab_image5(img)

    #result = 

    #responseData = {'success' : True}
    responseData = result

    # Se deben devolver las caracteristicas de la imagen
    return JsonResponse(responseData)
    #except:
        #return JsonResponse({'success' : False})



    

