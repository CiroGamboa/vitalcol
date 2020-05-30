from django.shortcuts import render
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt

from .forms import UploadFileForm
from .ai import imageProcessing 

# Method for receiving a file a extract characters

@csrf_exempt
def process_file(request):
    responseData = {
            'id': 4,
            'name': 'Test Response',
            'roles' : ['Admin','User']
        }

    if request.method == 'POST':
        #
        if request.FILES.get("photo", None) is not None:
			# grab the uploaded image
            # print("Entroooooo")
            image = imageProcessing.grab_image(stream=request.FILES["photo"])
        
        else:
            print("No se envio")

        '''
        _, file = request.FILES.popitem() 
        #file = file[0]
        print(request.headers)
        #imageProcessing.handle_uploaded_image(request.FILES['photo'])
        '''
        '''
        form = UploadFileForm(request.POST, request.FILES)
        print(request.POST)
        if form.is_valid():
            imageProcessing.handle_uploaded_image(request.FILES['file'])
            return JsonResponse(responseData)
        else:
            print("Not valid")
        '''

    return JsonResponse(responseData)