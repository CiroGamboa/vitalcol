import pandas as pd

header = ['codigo','descripcion','valor','cant','cantidad','niv','dosis','nivel']

dosis = ['dosis','administrar','admin','administracion','tab']

schedule = ['h','hora','horas','dia','dias','mes','meses','ano','año']

#Se toma la lista de medicamentos
print("Reading meds")
med_names = pd.read_csv("/code/aiserver/ai/med_names.csv")
med_names = pd.Series(med_names["meds"])
medicine = med_names.tolist()  