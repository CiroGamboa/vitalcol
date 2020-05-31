import google.cloud
from google.cloud import storage
import firebase_admin
from firebase_admin import credentials, firestore
import os, sys


def initFirebase():
    #Cargar ruta certificado
    #ruta_certificado= os.path.join(sys.path[0],"vitalcol-firebase-adminsdk-ys044-dbc2c8d81d.json")
    ruta_certificado= "/code/vitalcol-firebase-adminsdk-ys044-dbc2c8d81d.json"

    cred = credentials.Certificate(ruta_certificado)

    #Correr una sola vez en caso de que las funciones no sirvan, luego volver a comentar
    firebase_admin.initialize_app(cred,{
                'databaseURL': 'https://{}.firebaseio.com'.format("vitalcol"),
                'storageBucket': 'vitalcol.appspot.com'.format("vitalcol")}, name='vitalcol')


def consultarFirestoreBD(collection):
    store = firestore.client()
    doc_ref = store.collection(collection).limit(2)
    try:
        docs = doc_ref.stream()
        for doc in docs:
            print(type(doc))
            print(u'Doc Data:{}'.format(doc.to_dict()))
    except google.cloud.exceptions.NotFound:
        print(u'Missing data')

def numRegistros(collection):
    store = firestore.client()
    doc_ref = store.collection(collection)
    data = []
    docs = doc_ref.stream()
    for doc in docs:
        data.append(doc.to_dict())
    print(len(data))


def addsStorageBD(imagePath,nombreArchivo):
    storage_client = storage.Client.from_service_account_json("vitalcol-firebase-adminsdk-ys044-dbc2c8d81d.json")
    bucket=storage_client.bucket(bucket_name=f"vitalcol.appspot.com")
    imageBlob = bucket.blob("/")
    # imagePath = [os.path.join(self.path,f) for f in os.listdir(self.path)]
    
    imageBlob = bucket.blob(nombreArchivo)
    imageBlob.upload_from_filename(imagePath)
    #imageBlob.upload_from_file(imagePath) Cargar File direcatamente cuando no se tiene ruta
    url = imageBlob.public_url
    #output =imageBlob.download_as_string() Capturar Archivo que se subio
    print(url)