import keyWords
import re

def process_string(string):
    # Split the detected string using line jumps
    no_jump_string = string.split('\n')

    is_header = False
    for line in no_jump_string:

        # Check if the words match the key words in the header
        if(not is_header):
            is_header = check_header(no_space_string,2)

        else:
            dispatch_string(line)

            # Once the header is found, proceed to analice 
            # block of medicine and dosis



def check_header(line, min_matches=2):
    key_words = keyWords.header
    matches = 0

    # Split each line using the space between words
    words = line.split(' ')
    for word in words:
        # Put word in lowercase
        if(word.lower() in key_words):
            matches += 1
    
    if(matches >= min_matches):
        return True
    
    return False
        

def dispatch_string(line):

    # Check for meds first
    meds_found = check_medicine(line)

    # Check for schedules second
    sched_found = check_schedule(line)

    # Hay que saber cuando parar, de algun forma
    # se debe saber cuando hay un medicamento
    # y hay un schedule. Si ya se encontró la
    # pareja bien. Pero si sólo se encontro uno
    # de los dos, no sirve mucho, entonces no se guarda
    


def check_medicine(line):
    meds = keyWords.meds
    meds_found = []
    for med in meds:
        if re.search(med, line):
            meds_found.append(med)
            print('Se encontró el med -> ' + str(med))
        else:
            continue

    return meds_found



        
def check_schedule(line, min_matches=2):
    sched_words = keyWords.schedule
    dosis_words = keyWords.dosis

    sched = {}

    words = line.lower().split(' ')

    # Cases
    if('dosis' in words):
        if('tab' in words):
            cont = 0
            for word in words:
                if(word == 'tab'):
                    dosis = int(words[cont-1])
                    
                    # Esto debería discriminar mejor si es en días o no
                    # por lo pronto devolvamos días

                    sched['med_type'] = 'TABLETAS'
                    sched['dosis'] = dosis
                    sched['period'] = 'day'

                elif(word == 'por'):
                    sched['duration'] = word[cont + 1]
                    sched['duration_units'] = word[cont + 2]

                cont+=1

            pass
        elif('aplicar'):
            for word in words:
                if(word == 'aplicar'):
                    dosis = int(words[cont-1])

                    sched['med_type'] = 'INYECCIÓN'
                    sched['dosis'] = dosis
                    sched['period'] = 'day'

                elif(word == 'por'):
                    sched['duration'] = word[cont + 1]
                    sched['duration_units'] = word[cont + 2]

        elif('tomar'):
            for word in words:

                if(word == 'por'):
                    sched['duration'] = word[cont + 1]
                    sched['duration_units'] = word[cont + 2]
            
    return sched



def check_dosis():
    pass

def contains_digit(string):

    digits = 0
    for character in string:
        if character.isdigit():
            digits += 1
    
    if(digits == 0)
        return 'no'
    elif(digits < len(string)):
        return 'some'
    else:
        return 'all'


