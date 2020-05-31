from .keyWords import header, dosis, schedule, medicine
import re

def process_string(string):
    # Split the detected string using line jumps
    no_jump_string = string.split('\n')

    is_header = False

    result = {}

    cont = 0
    found_med = False
    found_sched = False

    toggle = 0 # 0 is med, 1 y sched

    cont_med = 0
    cont_sched = 0

    for line in no_jump_string:

        # Check if the words match the key words in the header
        if(not is_header):
            is_header = check_header(line,2)

        else:

            med, sched = dispatch_string(line)

            # Once the header is found, proceed to analice 
            # block of medicine and dosis

            if(med is not None):
                result['med'+str(cont_med)] =  med
                cont_med += 1

            if(sched is not None):
                result['sched'+str(cont_sched)]= sched
                cont_sched += 1

            
    
    return result


            



def check_header(line, min_matches=2):
    key_words = header
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

    return meds_found, sched_found



def check_medicine(line):
    meds = medicine
    meds_found = []
    for med in meds:
        if re.search(med, line):
            meds_found.append(med)
            print('Se encontró el med -> ' + str(med))
        else:
            continue
    if(len(meds_found) > 0):
        return meds_found
    else:
        return None



        
def check_schedule(line):

    words = line.lower().split(' ')
    if('dosis' in words):
        return line
    else:
        return None


        












def check_dosis():
    pass

def contains_digit(string):

    digits = 0
    for character in string:
        if character.isdigit():
            digits += 1
    
    if(digits == 0):
        return 'no'
    elif(digits < len(string)):
        return 'some'
    else:
        return 'all'


