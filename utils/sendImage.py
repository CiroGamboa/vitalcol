import requests
url = 'http://127.0.0.1:8000/processFile'
files = {'media': open('presc-test.jpg', 'rb')}
r = requests.post(url, files=files)

print(r.status_code)