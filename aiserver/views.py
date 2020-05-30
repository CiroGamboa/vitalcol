from django.shortcuts import render
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt

from .forms import UploadFileForm
from .ai import imageProcessing 

# Method for receiving a file a extract characters

@csrf_exempt
def process_file(request):
    if request.method == 'POST':
        #
        if request.FILES.get("photo", None) is not None:
			# grab the uploaded image
            # Image sería la imagen que se envía a Firebase
            image = imageProcessing.grab_image(stream=request.FILES["photo"])
            responseData = {
                'success' : True
            }
        
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