
def json_to_asp(js):
    """Converts JSON data to ASP format."""
    if not js.get("theft", False):
        return "// No theft case detected"
    
    asp_code = []
    asp_code.append(f'res("{js["res"]}").')
    asp_code.append(f'theft_intention("{js["reo"]}").')
    asp_code.append(f'own("{js["victim"]}", "{js["res"]}").')
    asp_code.append(f'substract("{js["reo"]}", "{js["res"]}").')
    
    if js.get("indirect_violence", False):
        asp_code.append(f'indirect_person_violence("{js["reo"]}", "{js["victim"]}").')
    if js.get("adherent", False):
        asp_code.append(f'adherence("{js["victim"]}", "{js["res"]}", {js["adherence_level"]}).')
    if not js.get("take_possession", True):
        asp_code.append(f'not take_possession("{js["reo"]}", "{js["res"]}").')
    
    return "\n".join(asp_code)