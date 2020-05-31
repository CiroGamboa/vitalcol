# -*- coding: utf-8 -*-
"""
Created on Sat May 30 09:49:00 2020

@author: Felipe Sarmiento
"""
#pip install firebase-admin google-cloud-firestore google-cloud-storage
import google.cloud
from google.cloud import storage
import firebase_admin
from firebase_admin import credentials, firestore

#Cargar ruta certificado
ruta_certificado="vitalcol-firebase-adminsdk-ys044-dbc2c8d81d.json"
cred = credentials.Certificate(ruta_certificado)

#Correr una sola vez en caso de que las funciones no sirvan, luego volver a comentar
firebase_admin.initialize_app(cred,{
            'databaseURL': 'https://{}.firebaseio.com'.format("vitalcol"),
            'storageBucket': 'vitalcol.appspot.com'.format("vitalcol")}, name='vitalcol')


collection=u'Medicamentos'

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
       
#consultarTodo()

mapa={u'NombreMedicamento': u'AMLODIPINO',
      u'Dosis': u'1 TAB',
      u'FrecuenciaAdministracion': u'DIARIA', 
      u'TiempoAdministracion': u'3 MESES',
      u'Tipo': u'Tableta',}
mapa2={u'NombreMedicamento': u'IRBESARTAN 150',
      u'Dosis': u'1 TAB',
      u'FrecuenciaAdministracion': u'DIARIA', 
      u'TiempoAdministracion': u'3 MESES',
      u'Tipo': u'Tableta',}
mapa3={u'NombreMedicamento': u'HIDROCROLOTIAZIDA 12.5',
      u'Dosis': u'1 TAB',
      u'FrecuenciaAdministracion': u'DIARIA', 
      u'TiempoAdministracion': u'3 MESES',
      u'Tipo': u'Tableta',}
mapa4={u'NombreMedicamento': u'ACIDO ACETILSALICILICO 100 MG',
      u'Dosis': u'1 TAB',
      u'FrecuenciaAdministracion': u'DIARIA', 
      u'TiempoAdministracion': u'3 MESES',
      u'Tipo': u'Tableta'}
def addFirestoreBD(mapa):
 
    store = firestore.client()
    doc_ref = store.collection(collection)
    doc_ref.add(mapa)
    print("añadido")
    
#addFirestoreBD(mapa)
#addFirestoreBD(mapa2)
#addFirestoreBD(mapa3)
#addFirestoreBD(mapa4)


def numRegistros(collection):
    store = firestore.client()
    doc_ref = store.collection(collection)
    data = []
    docs = doc_ref.stream()
    for doc in docs:
        data.append(doc.to_dict())
    print(len(data))
    
#numRegistros(collection)

imagePath = "C:/Users/Felipe Sarmiento/Downloads/buho.jpg"
nombreArchivo="prueba5"#Como se va guardar en firebase storage
def addsStorageBD(imagePath,nombreArchivo):
    storage_client = storage.Client.from_service_account_json("C:/Users/Felipe Sarmiento/Downloads/vitalcol-firebase-adminsdk-ys044-dbc2c8d81d.json")
    bucket=storage_client.bucket(bucket_name=f"vitalcol.appspot.com")
    imageBlob = bucket.blob("/")
    # imagePath = [os.path.join(self.path,f) for f in os.listdir(self.path)]
    
    imageBlob = bucket.blob(nombreArchivo)
    imageBlob.upload_from_filename(imagePath)
    #imageBlob.upload_from_file(imagePath) Cargar File direcatamente cuando no se tiene ruta
    url = imageBlob.public_url
    #output =imageBlob.download_as_string() Capturar Archivo que se subio
    print(url)

#addImage()



