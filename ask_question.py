import json
import os
from pprint import pprint
import subprocess
import inquirer

def printnnl(pp):
    print(pp, end='')

def get_degree():
    questions = [
        inquirer.List(
            "degree",
            message="Choose the degree of judgment",
            choices=["First degree", "Second degree"],
        )
    ]

    answers = inquirer.prompt(questions)
    return answers["degree"]

def get_num_people():
    print("How many people are involved?")

    while True:
        people = int(input())
        if people > 0:
            break
        else:
            print("The number of people involved must be at least 1.")
            print("Insert again how many people are involved:")

    return people

def get_agents(people):
    agents = []
    print("\nInsert names of people:")

    i = 1
    agents = []
    while i <= people:
        person = input(str(i) + ": ")
        if person in agents:
            print("\tWarning: there is another agent named " + person + ".")
            person = person + "_" + str(i)
            print("\tWe will refer to this second agent with the name " + person)
        agents = agents + [person]
        i = i+1
    
    return agents

def get_res():
    questions = [inquirer.Text(name='res', message="What has been stolen?")]
    answers = inquirer.prompt(questions)
    return answers["res"]
    
def get_reo(agents):
    questions = [
        inquirer.List(
            name="reo",
            message="Who stole the object",
            choices=agents,
        )]
    answers = inquirer.prompt(questions)
    return answers["reo"]


def get_victim(agents):    
    questions = [
            inquirer.List(
                name="victim",
                message="Who was the owner of the object",
                choices= agents,
            )]
    answers = inquirer.prompt(questions)
    return answers["victim"]

def get_take_possession():    
    questions = [
            inquirer.List(
                name="complete_theft",
                message="Was the thief actually able to take possesion of the object",
                choices=["Yes", "No"],
            )]
    answers = inquirer.prompt(questions)
    return True if answers["complete_theft"] == "Yes" else False

def get_violence():    
    questions = [
            inquirer.List(
                name="violence",
                message="Did thief make violence directly to victim to steal the object",
                choices=["Yes", "No", "Not sure"]
            )]
    answers = inquirer.prompt(questions)
    return True if answers["violence"] != "No" else False

def get_indirect_violence():    
    questions = [
            inquirer.List(
                name="indirect_violence",
                message="Did the thief make violence indirectly to the victim to steal the object",
                choices=["Yes", "No"],
            )]
    answers = inquirer.prompt(questions)
    return True if answers["indirect_violence"] != "No" else False

def get_threat():    
    questions = [
            inquirer.List(
                name="threat",
                message="Did the thief threat the victim to steal the object",
                choices=["Yes", "No"],
            )]
    answers = inquirer.prompt(questions)
    return True if answers["threat"] == "Yes" else False

def get_adherent():    
    questions = [
            inquirer.List(
                name="adherent",
                message="Was the stolen object physically adherent to the body of the victim",
                choices=["Yes", "No"],
            )]
    answers = inquirer.prompt(questions)
    return True if answers["adherent"] == "Yes" else False

def get_adherence_level():
    questions = [
        inquirer.List(
            "adherence_level",
            message="Between 1 and 4, where 1 means 'loose adherence' and 4 'tight adherence', which level of adherence could you give to the stolen object to the body of the victim",
            choices=[i for i in range(1, 5)],
        )]
    answers = inquirer.prompt(questions)
    return answers["adherence_level"]

def get_resistence():
    questions = [
        inquirer.List(
            "resistence",
            message="Did victim  make resistence to the snatch",
            choices= ["Yes", "No"],
        )]
    
    answers = inquirer.prompt(questions)
    return True if answers["resistence"] == "Yes" else False

def get_interruption():
    questions = [
        inquirer.List(
            "interruption",
            message="Did the thief interrupt the act when the resistence started",
            choices= ["Yes", "No"]
        )]
    answers = inquirer.prompt(questions)
    return True if answers["interruption"] == "Yes" else False

def get_violence_actions():
    questions = [
        inquirer.Checkbox(
            "violence_action",
                message="What the thieft did to the victim",
                choices=["drag", "make_fall", "tug", "push", "block a part of the body", "twist a part of the body", "other"]
            )]
    answers = inquirer.prompt(questions)
    return answers["violence_action"]
    
def get_part_of_body(verb):
    part_of_body = input("Which part of the body was " + verb.split(" ")[0] + "ed?\n")
    return part_of_body

def get_filename():
    res = [x for x in os.listdir("input_output") if ".json" in x ]
    questions = [
        inquirer.List(
            "filename",
                message="Select the json file for the first degree",
                choices= res
            )]
    answers = inquirer.prompt(questions)
    return answers["filename"]

def print_asp_output(asp_res, reo):
    start = False
    robbery = False
    snatch = False
    attempted = False
    for e in asp_res:
        if "Solving" in e or start:
            start = True
            print(e.replace("\n", ""))
            if "robbery" in e:
                robbery = True
            if "snatch" in e:
                snatch = True            
            if "attempted" in e:
                attempted = True

    if attempted and robbery: 
        print("\nFinal judgment: " + reo + " is guilty of attempted robbery.\n") 
        return "attempted robbery"
    if attempted and snatch and not robbery: 
        print("\nFinal judgment: " + reo + " is guilty of attempted snatch.\n")
        return "attempted snatch"
    if not attempted and robbery: 
        print("\nFinal judgment: " + reo + " is guilty of robbery.\n")
        return "robbery"
    if not attempted and snatch and not robbery: 
        print("\nFinal judgment: " + reo + " is guilty of snatch.\n")
        return "snatch"
    else:
        return str(attempted) + str(snatch) + str(robbery)


def json_to_asp(js):
    code = ""
    if js["theft"]:
        for p in js["agents"]:
            code = code + "agent(\"" + p + "\").\n"
        code = code + "res(\"" + js["res"] + "\").\n"
        code = code + "theft_intention(\"" + js["reo"] + "\").\n"
        code = code + "own(\"" + js["victim"] + "\", \"" + js["res"] + "\").\n"
        code = code + "substract(\"" + js["reo"] + "\", \"" + js["res"] + "\").\n"
        if js["indirect_violence"]:
            code = code + "indirect_person_violence(\"" + js["reo"] + "\", \"" + js["victim"] + "\").\n"
        if js["adherent"]:
            code = code + "adherence(\"" + js["victim"] + "\", \"" + js["res"] + "\", " + str(js["adherence_level"]) + ").\n"
        if js["resistence"]:
            code = code + "resistence(\"" + js["victim"] + "\", \"" + js["reo"] + "\").\n"
        if not js["take_possession"]:
            code = code + "not take_possession(\"" + js["reo"] + "\", \"" + js["res"] + "\").\n"
            if js["interruption"]:               
                code = code + "interruption(\"" + js["reo"] + "\").\n"
            else:
                code = code + "not interruption(\"" + js["reo"] + "\").\n"
        else:
            code = code + "take_possession(\"" + js["reo"] + "\", \"" + js["res"] + "\").\n"
        if js["violence_action"] != []:
            i = 0
            for v in js["violence_action"]:
                if "a part of the body" in v:
                    part_of_body = js["part_of_body"][i]
                    i = i+1
                    code = code + v.split(" ")[0] + "(\"" + js["reo"] + "\", \"" + js["victim"] + "\", \"" + part_of_body  + "\").\n"
                    code = code + "part_of_body(\"" + js["victim"] + "\", \"" + part_of_body + "\").\n"
                elif v != "other":
                    code = code + v + "(\"" + js["reo"] + "\", \"" + js["victim"]  + "\").\n"
                else:
                    undefined = True
        
        if js["threat"] :
            code = code + "threat(\"" + js["reo"] + "\", \"" + js["victim"] + "\").\n"
        else:
            code = code + "not threat(\"" + js["reo"] + "\", \"" + js["victim"] + "\").\n"

        if js["snatch"] :
            code = code + "snatch(\"" + js["reo"] + "\", \"" + js["res"] + "\").\n"
        else:
            code = code + "not snatch(\"" + js["reo"] + "\", \"" + js["res"] + "\").\n"
        return code
    else:
        print("No theft")
