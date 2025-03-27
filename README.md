# XAI-LAW 

This repository contains the code submitted to the workshop proposed for **Jurix 2023** and to the conference of **CILC 2024**.

# ILASP directory
This directory contains the files used to learn new rules with **ILASP**.

- **`art_56.las`** – ILASP examples for Article 56.  
- **`art_583.las`** – ILASP examples for Article 583.  
- **`art_624_624bis_628.las`** – ILASP examples for Articles 624, 624-bis, and 628.  
- **`beating_injury_h.las`** – ILASP examples for Articles 581 and 582 (with a defined hypothesis space).  
- **`beating_injury_md.las`** – ILASP examples for Articles 581 and 582 (with mode declarations).  
- **`crimes_against_person.las`** – ILASP examples for Articles 575, 579, 584, 588, 589, 589-bis, 59, 595, 609-bis, 610, and 614.  


# ASP directory
This directory contains the **ASP encoding** of legal articles.

- **`art_56.lp`** – Encoding of Article 56.  
- **`art_581_582.lp`** – Encoding of Articles 581 and 582.  
- **`art_583.lp`** – Encoding of Article 583.  
- **`crimes_against_person.lp`** – Encoding of Articles 575, 579, 584, 588, 589, 589-bis, 59, 595, 609-bis, 610, and 614.  
- **`theft_robbery.lp`** – Encoding of Articles 624, 624-bis, and 628.  

# Judgments directory
This directory contains **ASP-encoded judgments**, also used in ILASP examples.

- **`all.lp`** – All encoded judgments, including those related to Articles 583, 581, and 582.  
- **`crimes_against_person.lp`** – Judgments related to Articles 575, 579, 584, 588, 589, 589-bis, 59, 595, 609-bis, 610, and 614.  
- **`theft.lp`** – Judgments related to Articles 624, 624-bis, and 628.  

# tool_degree directory
This directory contains files for the **tool that determines judgments in first and second degree**.

- **`input_output/`** – Directory containing JSON files for ASP encoding.  
- **`ask_question.py`** – Functions to interact with the user.  
- **`asp_generator.py`** – Functions to generate ASP code from JSON files.  
- **`make_judgment.py`** – Main script to run the tool.

## Additional Example Files
- **`esempi_sentenze.lp`** – Contains real judgment examples, some of which are used in `ASP/theft_robbery.lp`.  
- **`esempi_workshop.lp`** – Contains real judgment examples explained during the **Jurix 2023** workshop.  
