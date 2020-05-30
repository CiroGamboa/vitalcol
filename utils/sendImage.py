import requests

url = 'http://127.0.0.1:8000/processFile'

'''
files = {'media': open('presc-test.jpg', 'rb')}

#headers = {'Content-Type': 'multipart/form-data'}
r = requests.post(url, files=files)

print(r.status_code)
'''


with open('presc-test.jpg', 'rb') as payload:
    files = {
        'photo': payload,
        'enctype': 'multipart/form-data'
    }
    r = requests.post(
        url=url,
        verify=False, files=files
    )
    print(r)
