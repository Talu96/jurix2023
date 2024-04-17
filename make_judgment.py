import json
from ask_question import * 
import subprocess
import inquirer

folder_io = "input_output"

print("\nPlease, answer the following questions to get the final judgment. \nWe already assume that there was a theft (intentional) and that the stolen object was snatched.\n")

def printnnl(pp):
    print(pp, end='')

undefined = False
all_answers = {}

degree = get_degree()
all_answers["degree"] = degree

if degree == "First degree":

    people = get_num_people()
    all_answers["n_people"] = people

    agents = get_agents(people)
    all_answers["agents"] = agents

    print("\n")

    theft = True
    all_answers["theft"] = theft


    if theft :
        res = get_res()
        reo = get_reo(agents)
        victim = get_victim([x for x in agents if x != reo])
        snatch = True
        violence = get_violence()
        indirect_violence = get_indirect_violence()
        threat = get_threat()
        adherent = get_adherent()
        
        all_answers["res"] = res
        all_answers["reo"] = reo
        all_answers["victim"] = victim
        all_answers["snatch"] = snatch
        all_answers["violence"] = violence
        all_answers["indirect_violence"] = indirect_violence 
        all_answers["threat"] = threat
        all_answers["adherent"] = adherent
        all_answers["resistence"] = False
        all_answers["interruption"] = False

        if adherent :
            adherence_level = get_adherence_level()
            resistence = get_resistence()
        
            all_answers["adherence_level"] = adherence_level
            all_answers["resistence"] = resistence

            take_possession = get_take_possession()
            all_answers["take_possession"] = take_possession

            if resistence :
    
                if not take_possession:
                    interruption = get_interruption()
                    all_answers["interruption"] = interruption
                else:
                    interruption = False
        else:
            take_possession = get_take_possession()
            all_answers["take_possession"] = take_possession

        if violence:     
            violence_action = get_violence_actions()
            all_answers["violence_action"] = violence_action
            all_answers["part_of_body"] = []
            for v in violence_action:
                if "a part of the body" in v:
                    part_of_body = get_part_of_body(v)
                    all_answers["part_of_body"] = all_answers["part_of_body"] + [part_of_body]
                if v == "other":
                    undefined = True
        else:
            all_answers["violence_action"] = []
            all_answers["part_of_body"] = []

        code = json_to_asp(all_answers)

        with open(folder_io + "/input.lp", "w") as aspInput:
            aspInput.write(code)
        with open(folder_io + "/first_degree.json", "w") as outfile:
            json.dump(all_answers, outfile, indent=2)


        print("\n_________________________________________________________\n")
        
        if undefined:
            print("WARNING: there is something that we are still not able to encode in the model, so the result might not be the real one.")
        
        p = subprocess.Popen('clingo -n 0 modello.lp ' + folder_io + '/input.lp', shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
        lines = []
        for l in p.stdout.readlines():
            lines = lines + [l.decode('UTF-8')]
        p.stdout.close()
            
        print_asp_output(lines, reo)
    
    else:
        print("Nothing has been stolen: there is nothing to judge.")
else:
    filename = get_filename() 
    first_degree = json.load(open( folder_io + '/' + filename, "r"))
    printnnl("\nIn the first degree it was say that:")
    printnnl("\n\tThe persons involved were: " + str(first_degree["agents"]))
    printnnl("\n\tThe reo/theft was: " + first_degree["reo"])
    printnnl("\n\tThe victim was: " + first_degree["victim"])
    printnnl("\n\tThe stealed object was: " + first_degree["res"])
    printnnl("\n\tThere was adherence to the body: " + str(first_degree["adherent"]))
    if first_degree["adherent"]: printnnl("\n\t\tof level: " + str(first_degree["adherence_level"]))
    if first_degree["indirect_violence"]: printnnl("\n\tThere was indirect violence: " + str(first_degree["indirect_violence"]))
    printnnl("\n\tThe victim made resistence to the reo: " + str(first_degree["resistence"]))
    if first_degree["resistence"]: printnnl("\n\tThe reo interrupted the action: " + str(first_degree["interruption"]))
    if first_degree["violence_action"] != []:
        printnnl("\n\tThat " + first_degree["reo"] + " did the following things to " + first_degree["victim"] + "\n: " + first_degree["violence_action"])
        if first_degree["part_of_body"] != []:
            printnnl("That the part/s of the body hit by " + first_degree["reo"] + " were: " + first_degree["part_of_body"])
    print("\n\tThat " + first_degree["reo"] + " was able to take possession of the res: " + str(first_degree["take_possession"]) + "\n\n")
    
    questions = [
        inquirer.Checkbox(
            "to_change",
            message="Check what do you want to change from the first degree",
            choices=["people involved", "reo/theft", "victim", "stealed object", "adherence", "indirect violence", "threat", "resistence", "interruption", "actions of violence", "part of body hit", "took possession"]
        )]
    
    code_first = json_to_asp(first_degree) 
    
    second_degree = first_degree
    second_degree["degree"] = "Second degree"
    answers = inquirer.prompt(questions)
    done_agents = False
    done_violence = False
    done_adherence = False
    for a in answers["to_change"]:
        match a:
            case "people involved"|"reo/theft"|"victim":
                if not done_agents:
                    second_degree["n_people"] = get_num_people()  
                    second_degree["agents"] =  get_agents(second_degree["n_people"] )
                    second_degree["reo"] =  get_reo(second_degree["agents"] )
                    second_degree["victim"] =  get_victim([x for x in second_degree["agents"] if x!=second_degree["reo"] ])   
                    done_agents = True        
            case "stealed object": 
                if not done_adherence:
                    second_degree["res"] = get_res()
                    second_degree["adherent"] = get_adherent()
                    if second_degree["adherent"]: 
                        second_degree["adherence_level"] = get_adherence_level()
                    done_adherence = True
            case "took possession":
                second_degree["take_possession"] = get_take_possession()
            case "indirect violence":
                second_degree["indirect_violence"] = get_indirect_violence()
            case "actions of violence" | "part of body hit":
                if not done_violence:
                    violence = get_violence()
                    if violence:
                        violence_action = get_violence_actions()  
                        second_degree["violence_action"] = violence_action
                        second_degree["part_of_body"] = []
                        for v in violence_action:
                            if "a part of the body" in v:
                                part_of_body = get_part_of_body(v)
                                second_degree["part_of_body"] = second_degree["part_of_body"] + [part_of_body]
                                code = code + "part_of_body(\"" + second_degree["victim"] + "\", \"" + part_of_body + "\").\n"
                                code = code + v.split(" ")[0] + "(\"" + second_degree["reo"]  + "\", \"" + second_degree["victim"]  + "\", \"" + part_of_body  + "\").\n"
                            elif v != "other":
                                code = code + v + "(\"" + second_degree["reo"]  + "\", \"" + second_degree["victim"]   + "\").\n"
                            else:
                                undefined = True
                    done_violence = True
            case "threat":
                second_degree["threat"] = get_threat()
            case "adherence": 
                if not done_adherence:
                    second_degree["adherent"] = get_adherent()
                    if second_degree["adherent"]: second_degree["adherence_level"] = get_adherence_level()
            case "resistence":
                second_degree["resistence"] = get_resistence()
            case "interruption":
                second_degree["interruption"] = get_interruption()
    
    code_second = json_to_asp(second_degree) 

    with open(folder_io + "/first_degree.lp", "w") as outfile:
        outfile.write(code_first)
    with open(folder_io + "/second_degree.lp", "w") as outfile:
        outfile.write(code_second)

    with open(folder_io + "/second_degree.json", "w") as outfile:
        json.dump(second_degree, outfile, indent=2)

    print("\n_________________________________________________________\n")
    
    if undefined:
        print("WARNING: there is something that we are still not able to encode in the model, so the result might not be the real one.")
    
    p_first = subprocess.Popen('clingo -n 0 modello.lp ' + folder_io + '/first_degree.lp', shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    lines = []
    for l in p_first.stdout.readlines():
        lines = lines + [l.decode('UTF-8')]
    p_first.stdout.close()
    
    res_first = print_asp_output(lines, first_degree["reo"])
        
    p_second = subprocess.Popen('clingo -n 0 modello.lp ' + folder_io + '/second_degree.lp', shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    lines = []
    for l in p_second.stdout.readlines():
        lines = lines + [l.decode('UTF-8')]
    p_second.stdout.close()
        
    res_second = print_asp_output(lines, second_degree["reo"])

    if res_first != res_second:
        print("The judgment has changed from " + res_first + " to " + res_second + ".")
    else:
        print("The judgment is stil the same: " + res_second + ".")