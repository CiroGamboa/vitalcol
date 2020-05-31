import keyWords

def process_string(string):
    # 1. Split the detected string using line jumps
    no_jump_string = string.split('\n')

    is_header = False
    for line in no_jump_string:

        # 2. Split each line using the space between words
        no_space_string = line.split(' ')
        
        # 3. Check if the words match the key words in the header
        if(not is_header):
            is_header = check_header(no_space_string,2)

        else:
            dispatch_string(no_space_string)
            # 4. Once the header is found, proceed to analice 
            # block of medicine and dosis



def check_header(words, min_matches=2):
    key_words = keyWords.header
    matches = 0

    for word in words:
        # Put word in lowercase
        if(word.lower() in key_words):
            matches += 1
    
    if(matches >= min_matches):
        return True
    
    return False
        

def dispatch_string(words):
    possible_med_found = False
    med = []
    dosis = []
    sched = []
    for word in words:
        # Check if the word contains numbers
        digits = contains_digit(word)
        if(digits == 'no'):
            # Possible med
            med.append(word)

        elif(digits == 'some'):
            # Possible schedule or dosis
            dosis.append(word)
            sched.append(word)

        #Only numbers
        elif(digits == 'all'):
            # Possible id, schedule or dosis
            dosis.append(word)
            sched.append(word)
            pass

    
    print("Possible medicine: ",med)
    print("Possible dosis: ", dosis)
    print("Possible schedule: ", sched)


            

                



def check_medicine():
    pass

def check_schedule():
    pass

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


