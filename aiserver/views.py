from django.shortcuts import render
from django.http import JsonResponse
from .forms import UploadFileForm
from .ai import imageProcessing 

# Method for receiving a file a extract characters
def process_file(request):
    responseData = {
            'id': 4,
            'name': 'Test Response',
            'roles' : ['Admin','User']
        }

    if request.method == 'POST':
        form = UploadFileForm(request.POST, request.FILES)
        if form.is_valid():
            imageProcessing.handle_uploaded_image(request.FILES['file'])
            return JsonResponse(responseData)
        else:
            print("Not valid")

    return JsonResponse(responseData)