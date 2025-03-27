%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Art. 56 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Tribunale Roma, 13/11/1992

attempted_personal_injuries(R, V, I) :- injuries_intention(R), damage(R, V), not derive_illness(V), danger_of_illness(V, I), illness(I), agent(R), agent(V), R != V.

attempted_serious_personal_injuries(R, V, I, "lesioni gravi") :- injuries_intention(R), damage(R, V), not derive_illness(V), danger_of_illness(V, I), illness(I), severity(I, 2), agent(R), agent(V), R != V.

attempted_serious_personal_injuries(R, V, I, "lesioni gravissime") :- injuries_intention(R), damage(R, V), not derive_illness(V), danger_of_illness(V, I), illness(I), severity(I, 3), agent(R), agent(V), R != V.

:- danger_of_illness(V, I), derive_illness(V).

% Cassazione penale sez. V, 14/10/2015, n.6460

attempted_personal_injuries(R, V, I) :- injuries_intention(R), damage(R, V), interruption(R), illness(I), agent(R), agent(V), R!=V.

% Tribunale Frosinone, 15/04/2022, n.363
:- attempted_personal_injuries(R, V, I), personal_injuries(R, V, I).

% Corte appello Ancona, 23/01/2023, n.2104 - Tribunale Lecce sez. I, 13/07/2023, n.2529
attempted_murder(R, V) :- death_intention(R), not cause_death(R, V), damage(R, V), agent(R), agent(V), R != V.

:- attempted_crime(R, V, F), crime(R, V, F).

crime(R, V, "murder") :- murder(R, V).
crime(R, V, "consenting_murder") :- consenting_murder(R, V).
crime(R, V, "beatings") :- beatings(R, V).
crime(R, V, "personal_injuries") :- personal_injuries(R, V, I).
crime(R, V, "serious_personal_injuries") :- serious_personal_injuries(R, V, I, "lesioni gravi").
crime(R, V, "serious_personal_injuries") :- serious_personal_injuries(R, V, I, "lesioni gravissime").
crime(R, V, "manslaughter") :- manslaughter(R, V).
crime(G, G1, "affray") :- affray(G, G1).
crime(R, V, "negligent_manslaughter") :- negligent_manslaughter(R, V).
crime(R, V, "vehicular_homicide") :- vehicular_homicide(R, V).
crime(R, V, "negligent_personal_injuries") :- negligent_personal_injuries(R, V, I).
crime(R, V, "defamation") :- defamation(R, V).
crime(R, V, "sexual_assault") :- sexual_assault(R, V).
crime(R, V, "private_violence") :- private_violence(R, V).
crime(R, V, "trespassing") :- trespassing(R, V).
crime(R, V, "theft") :- theft(R, V, C).
crime(R, V, "theft_snatch") :- theft_snatch(R, V).
crime(R, V, "robbery") :- robbery(R, V).

attempted_crime(R, V, "personal_injuries") :- attempted_personal_injuries(R, V, I).
attempted_crime(R, V, "serious_personal_injuries") :- attempted_serious_personal_injuries(R, V, I, "lesioni gravi").
attempted_crime(R, V, "serious_personal_injuries") :- attempted_serious_personal_injuries(R, V, I, "lesioni gravissime").
attempted_crime(R, V, "theft") :- attempted_theft(R, V, C).
attempted_crime(R, V, "theft_snatch") :- attempted_theft_snatch(R, V).
attempted_crime(R, V, "robbery") :- attempted_robbery(R, V).
attempted_crime(R, V, "murder") :- attempted_murder(R, V).

%%%% Reati complessi 

blamed_for("robbery") :- robbery(R, V), beatings(R, V), not manslaughter(R, V).

blamed_for("manslaughter") :- manslaughter(R, V), personal_injuries(R, V, I).

blamed_for("manslaughter") :- manslaughter(R, V), beatings(R, V).

%%%% Delitti contro la persona

reo(R, "murder") :- murder(R, V).
victim(V, "murder") :- murder(R, V).

reo(R, "consenting_murder") :- consenting_murder(R, V).
victim(V, "consenting_murder") :- consenting_murder(R, V).

reo(R, "beatings") :- beatings(R, V).
victim(V, "beatings") :- beatings(R, V).

reo(R, "personal_injuries") :- personal_injuries(R, V, I).
victim(V, "personal_injuries") :- personal_injuries(R, V, I).

reo(R, "serious_personal_injuries") :- serious_personal_injuries(R, V, I, "lesioni gravi").
victim(V, "serious_personal_injuries") :- serious_personal_injuries(R, V, I, "lesioni gravi").

reo(R, "serious_personal_injuries") :- serious_personal_injuries(R, V, I, "lesioni gravissime").
victim(V, "serious_personal_injuries") :- serious_personal_injuries(R, V, I, "lesioni gravissime").

reo(R, "manslaughter") :- manslaughter(R, V).
victim(V, "manslaughter") :- manslaughter(R, V).

reo(G, "affray") :- affray(G, G1), agent(R), part_of(R, G).
reo(G1, "affray") :- affray(G, G1), agent(R1), part_of(R1, G1).
reo(R, "affray") :- affray(G, G1), agent(R), part_of(R, G).
reo(R1, "affray") :- affray(G, G1), agent(R1), part_of(R1, G1).

reo(R, "negligent_manslaughter") :- negligent_manslaughter(R, V).
victim(V, "negligent_manslaughter") :- negligent_manslaughter(R, V).

reo(R, "vehicular_homicide") :- vehicular_homicide(R, V).
victim(V, "vehicular_homicide") :- vehicular_homicide(R, V).

reo(R, "negligent_personal_injuries") :- negligent_personal_injuries(R, V, I).
victim(V, "negligent_personal_injuries") :- negligent_personal_injuries(R, V, I).

reo(R, "defamation") :- defamation(R, V).
victim(V, "defamation") :- defamation(R, V).

reo(R, "sexual_assault") :- sexual_assault(R, V).
victim(V, "sexual_assault") :- sexual_assault(R, V).

reo(R, "private_violence") :- private_violence(R, V).
victim(V, "private_violence") :- private_violence(R, V).

reo(R, "trespassing") :- trespassing(R, V).
victim(V, "trespassing") :- trespassing(R, V).

agent(R) :- reo(R, F). % colui che commette un crimine
agent(V) :- victim(V, F). % la parte lesa

%%% Art. 575 - Omicidio 

murder(R, V) :- death_intention(R), not consent(V), cause_death(R, V), agent(R), agent(V), R != V.

%%% Art. 579 - Omicidio del consenziente

consenting_murder(R, V) :- death_intention(R), consent(V), cause_death(R, V), agent(R), agent(V), R != V.

%%%% Art. 581 - Percosse

beatings(R, V) :- damage(R, V), harmful_intention(R), not derive_illness(V), agent(R), agent(V), R!=V.

%%%% Art. 582 - Lesione personale

illness(I) :- physical_illness(I).
illness(I) :- mental_illness(I).

personal_injuries(R, V, I) :- damage(R, V), harmful_intention(R), derive_illness(V), derive(V, I), agent(R), agent(V), illness(I), R!=V.

derive_illness(V) :- derive(V, I), illness(I).
illness(I) :- derive(V, I).

degree(1..3).

1{bruises(R, V, D): degree(D)}1 :- unknown_bruises(R, V).

minor_bruises(R, V) :- bruises(R, V, D), agent(R), agent(V), D=1.
serious_bruises(R, V) :- bruises(R, V, D), agent(R), agent(V), D>1.

degree(D) :- bruises(R,V,D).


%%% Art. 584 - Omicidio preterintenzionale

manslaughter(R, V) :- harmful_intention(R), cause_death(R, V), agent(R), agent(V), R != V.

%%% Art. 588 - Rissa

affray(G, G1) :- harmful_intention(G), harmful_intention(G1), agent(R), agent(R1), agent(R2), part_of(R,G), part_of(R1,G), part_of(R2,G1), R!=R1, R1!=R2, R2!=R, G!=G1.

group(G) :- agent(R), agent(R1), agent(R2), part_of(R,G), part_of(R1,G), part_of(R2,G1), R!=R1, R1!=R2, R2!=R.
group(G1) :- agent(R), agent(R1), agent(R2), part_of(R,G), part_of(R1,G), part_of(R2,G1), R!=R1, R1!=R2, R2!=R.

%%% Art. 589 - Omicidio colposo 

negligent_manslaughter(R, V) :- negligence(R), not negligence(V), cause_death(R, V), agent(R), agent(V), R != V. % negligence è la colpa

%%% Art. 589 bis - Omicidio stradale

vehicular_homicide(R, V) :- negligence(R), not negligence(V), cause_death(R, V), not respect_rules(R, "circolazione stradale"), rules("circolazione stradale"), agent(R), agent(V), R != V.
vehicular_homicide(R, V) :- negligence(R), not negligence(V), cause_death(R, V), not respect_rules(R, "navigazione marittima"), rules("navigazione marittima"), agent(R), agent(V), R != V.
vehicular_homicide(R, V) :- negligence(R), not negligence(V), cause_death(R, V), not respect_rules(R, "navigazione interna"), rules("navigazione interna"), agent(R), agent(V), R != V.

%%% Art. 590 - Lesioni personali colpose

negligent_personal_injuries(R, V, I) :- negligence(R), derive_illness(V), derive(V, I), illness(I), damage(R, V), agent(R), agent(V), R!=V.

%%% Art. 595 - Diffamazione
defamation(R, V) :- comunicate(R, T), offend(R, V), agent(R), agent(V), agent(T), R != V, R != T, T != V.

%%% Art. 609 bis - Violenza sessuale

sexual_assault(R, V) :- violence(R, V), force(R, V, A), sexual_action(A), not consent(V).
sexual_assault(R, V) :- threat(R, V), force(R, V, A), sexual_action(A), not consent(V).
sexual_assault(R, V) :- abuse_authority(R, V), force(R, V, A), sexual_action(A), not consent(V).

%%% Art. 610 - Violenza privata

private_violence(R, V) :- violence(R, V), force(R, V, A), action(A), R!=V.
private_violence(R, V) :- threat(R, V), force(R, V, A), action(A), R!=V.

%%% Articolo 614 - Violazione di domicilio

trespassing(R, V) :- break_into_dwelling(R, V, D), dwelling(V, D), not consent(V).

%%%%%% Delitti contro il patrimonio - Dreossi Talissa

%%%% Art.624 furto

% res: cosa mobile
res(C) :- physical_object(C).
res(C) :- energy(C), economic_value(C).

reo(R, "theft") :- theft(R, V, C). 
victim(V, "theft") :- theft(R, V, C). 

reo(R, "attempted_theft") :- attempted_theft(R, V, C). 
victim(V, "attempted_theft") :- attempted_theft(R, V, C). 

reo(R, "theft_snatch") :- theft_snatch(R, V). 
victim(V, "theft_snatch") :- theft_snatch(R, V). 

reo(R, "attempted_theft_snatch") :- attempted_theft_snatch(R, V). 
victim(V, "attempted_theft_snatch") :- attempted_theft_snatch(R, V). 

reo(R, "robbery") :- robbery(R, V). 
victim(V, "robbery") :- robbery(R, V). 

reo(R, "attempted_robbery") :- attempted_robbery(R, V). 
victim(V, "attempted_robbery") :- attempted_robbery(R, V). 

theft(R, V, C) :- subtract(R, C), own(V, C), theft_intention(R), take_possession(R, C), agent(V), agent(R), res(C), V!=R.     %% dò per scontato che è al fine di procurare profitto per sè/altri
attempted_theft(R, V, C) :- subtract(R, C), own(V, C), theft_intention(R), not take_possession(R, C), agent(V), agent(R), res(C), V!=R. 


%%%% precisazione violenza (massima, tribunale Bologna, sez I, 11/05/2023, n 440)

violence(R, V) :- damage(R, V), agent(R), agent(V), V!=R.      
snatch(R, C) :- loose_physical_adherence(V, C), subtract(R, C), agent(V), V!=R.
subtract(R, C) :- snatch(R, C), agent(R), res(C).

person_violence(R, V) :- violence(R, V).
person_violence(R, V) :- foreshadowing_violence(R), agent(V), V!=R.                      %%se le azioni possono portare a una lesione ma non accade è comunque violenza
indirect_violence_person(R, V) :- violence(R, V), not foreshadowing_violence(R), V!=R. 
res_violence(R, C) :- snatch(R, C), agent(R), res(C).

%% Vaghezza aderenza: L è il livello di aderenza (da 1 a 4, aderenza più stretta a 4)

level(1..4).

1{adherence(S, C, L): level(L)}1 :- unknown_adherence(S, C).

tight_physical_adherence(S, C) :- adherence(S, C, L), agent(S), res(C), L>2.
loose_physical_adherence(S, C) :- adherence(S, C, L), agent(S), res(C), L<3.

level(L) :- adherence(S, C, L).

%%%% precisazione violenza (massima, cassazione penale, sez II, 11/12/2013, n 49832)

person_violence(R, V) :- resistence(V, R), not interruption(R).
person_violence(R, V) :- tight_physical_adherence(V, C), subtract(R, C), agent(V), R!=V.


%%%% Art.624 bis furto con strappo

theft_snatch(R, V) :- theft(R, V, C), res_violence(R, C), not person_violence(R, V).


%%%% Art.628 rapina

robbery(R, V) :- theft(R, V, C), person_violence(R, V).     %% violenza intesa sia che accada prima che dopo la sottrazione
robbery(R, V) :- theft(R, V, C), threat(R, V).             %% minaccia intesa sia che accada prima che dopo la sottrazione


%%%% massima, cassazione penale, sez II, 11/12/2013, n 49832

attempted_theft_snatch(R, V) :- resistence(V, R), interruption(R).
attempted_theft_snatch(R, V) :- attempted_theft(R, V, C), snatch(R, C).
attempted_robbery(R, V) :- resistence(V, R), not interruption(R), not take_possession(R, C), res(C).
attempted_robbery(R, V) :- attempted_theft(R, V, C), person_violence(R, V).
attempted_robbery(R, V) :- attempted_theft(R, V, C), threat(R, V).


:- attempted_theft_snatch(R, V), theft_snatch(R, V).
:- attempted_robbery(R, V), robbery(R, V).


resistence(V, R) :- tug(R, V).



% Examples
agent("R").
agent("V").

% Cassazione penale, sez. I, 05/10/2017, n. 56701
#pos({
        murder("R", "V")
    },{
        manslaughter("R", "V")
    },{
        robbery("R", "V").
        bind("R", "V").
        gag("R", "V").
        cause_death("R", "V").
    }).

% Cassazione penale, sez. I, 22/12/2017, n. 3619
#pos({
        murder("R", "V")
    },{
        manslaughter("R", "V")
    },{
        robbery("R", "V").
        obstruct("R", "V", "naso").
        obstruct("R", "V", "bocca").
        cause_death("R", "V").
    }).

% Cassazione penale, sez. I, 29/01/2019, n. 16116
#pos({
        attempted_murder("R", "V")
    },{
        cause_death("R", "V")
    },{
        stab("R", "V").
        number_of_wounds("V", 11).
    }).

#pos({
        murder("R", "V")
    },{
        
    },{
        stab("R", "V").
        number_of_wounds("V", 11).
        cause_death("R", "V").
    }).

% Tribunale Taranto sez. II, 14/10/2020, n.795
#pos({
        attempted_murder("R", "V")
    },{
        cause_death("R", "V")
    },{
        use_object("R", "V", "arma da fuoco").
        shoot("R", "V", "volto", 5).
        number_of_shots("V", 5).
    }).

#pos({
        murder("R", "V")
    },{
        
    },{
        use_object("R", "V", "arma da fuoco").
        shoot("R", "V", "volto", 5).
        number_of_shots("V", 5).
        cause_death("R", "V").
    }).

% Corte appello Ancona, 17/02/2021, n.1604
#pos({
        attempted_murder("R", "V")
    },{
        personal_injuries("R", "V", "illness"),
        cause_death("R", "V")
    },{
        damage("R", "V").
        stab_body("R", "V", "addome").
        part_of_body("V", "addome").
        violence("R", "V").
    }).

#pos({
        murder("R", "V")
    },{
        personal_injuries("R", "V", "illness")
    },{
        stab_body("R", "V", "addome").
        part_of_body("V", "addome").
        violence("R", "V").
        cause_death("R", "V").
    }).

#neg({
        personal_injuries("R", "V", "illness")
    },{

    },{
        death_intention("R").
    }).

% Cassazione penale sez. I, 06/10/2021, n.14751
#pos({
        murder("R", "V")
    },{
        consent("V"),
        consenting_murder("R", "V")
    },{
        incapacity_understanding("V").
        cause_death("R", "V").
        death_intention("R").
    }).

% Cassazione penale sez. I, 30/03/2022, n.29611
#pos({
        attempted_murder("R", "V")
    },{
        cause_death("R", "V")
    },{
        throw("R", "V", "sasso").
        go_through("V", "auto").
    }).

#pos({
        murder("R", "V")
    },{
        
    },{
        throw("R", "V", "sasso").
        go_through("V", "auto").
        cause_death("R", "V").
    }).

% Cassazione penale sez. I, 05/04/2022, n.24173
#pos({
        attempted_murder("R", "V")
    },{

    },{
        stab_body("R", "V", "zona orbitale").
        part_of_body("V", "zona orbitale").
        defense("V").
    }).

% Cassazione penale sez. I, 21/07/2022, n.40819
#pos({
        murder("R", "V")
    },{

    },{
        robbery("R", "V").
        use_object("R", "V", "arma da fuoco").
        cause_death("R", "V").
    }).

% Cassazione penale, sez. I, sent., 23/12/2022 n. 48944
#pos({
        murder("R", "V")
    },{
        consenting_murder("R", "V"),
        consent("V")
    },{
        administer("R", "V", "farmaci sedativi").
        administer("R", "V", "farmaci anestetici").
        medicine("farmaci sedativi").
        medicine("farmaci anestetici").
        cause_death("R", "V").
    }).

% Corte appello Ancona, 23/01/2023, n.2104
#pos({
        attempted_murder("R", "V")
    },{
        cause_death("R", "V")
    },{
        stab("R", "V").
        death_intention("R").
    }).

#pos({
        murder("R", "V")
    },{
        
    },{
        stab("R", "V").
        death_intention("R").
        cause_death("R", "V").
    }).

% Cass. pen., sez. I, sent., 19/06/2023 n. 26316
#pos({
        murder("R", "V")
    },{
        
    },{
        caused_by("R", "V", "alcol denaturato", "death").
        substance("alcol denaturato").
        cause_death("R", "V").
    }).

% Tribunale Lecce sez. I, 13/07/2023, n.2529
#pos({
        attempted_murder("R", "V")
    },{
        cause_death("R", "V")
    },{
        stab_body("R", "V", "organi vitali").
        part_of_body("V", "organi vitali").
        resistence("V", "R").
    }).

% Cassazione penale sez. I, 13/07/2023, n.44677
#pos({
        murder("R", "V")
    },{
        consent("V"),
        consenting_murder("R", "V")
    },{
        slap("R", "V").
        use_object("R", "V", "stampella").
        derive("V", "contusione").
        derive_illness("V").
        illness("contusione").
        cause_death("R", "V").
        death_intention("R").
    }).

% Corte assise Roma, 10/12/1983
#pos({
        consenting_murder("R", "V"),
        handicap("V")
    },{
        murder("R", "V"),
        incapacity_understanding("V")
    },{
        consent("V").
        has_illness("V", "idrocefalo congenito").
        illness("idrocefalo congenito").
        cause_death("R", "V").
        death_intention("R").
    }).

% Corte assise Trieste, 02/05/1988
#pos({
        consenting_murder("R", "V")
    },{
        murder("R", "V"),
        incapacity_understanding("V")
    },{
        consent("V").
        has_illness("V", "affezione morbosa inguaribile").
        illness("affezione morbosa inguaribile").
        cause_death("R", "V").
        death_intention("R").
    }).

% Cassazione penale sez. I, 17/11/2010, n.43954
#pos({
        murder("R", "V")
    },{
        consenting_murder("R", "V")
    },{
        death_intention("R").
        cause_death("R", "V").
    }).

#neg({
        consenting_murder("R", "V")
    },{
        consent("V")
    }).

% Cassazione penale sez. I, 26/05/2017, n.3392
#pos({
        murder("R", "V")
    },{
        consenting_murder("R", "V")
    },{
        handicap("V").
        incapacity_understanding("V").
        death_intention("R").
        cause_death("R", "V").
    }).

#neg({
        consent("V")
    },{

    },{
        handicap("V").
        incapacity_understanding("V").
    }).



% Cassazione penale sez. I, 12/03/2014, n.14647
#neg({
        manslaughter("R", "V")
    },{

    },{
        death_intention("R").
        cause_death("R", "V").
    }).

% Cassazione penale sez. V, 21/09/2016, n.44986
#pos({
    	negligent_manslaughter("R", "V")
    },{
        manslaughter("R", "V"),
        harmful_intention("R")
    },{
    	pleasure_intention("R").
        cause_death("R", "V").
        breath_playing("R", "V").
        consent("V").
    }).

#pos({
    	negligent_manslaughter("R", "V")
    },{
        manslaughter("R", "V"),
        harmful_intention("R")
    },{
    	pleasure_intention("R").
        cause_death("R", "V").
        bondage("R", "V").
        consent("V").
    }).

% Cassazione penale sez. V, 21/09/2016, n.44986
#pos({
    	negligent_manslaughter("R", "V")
    },{
        manslaughter("R", "V"),
        harmful_intention("R")
    },{
    	consent("V").
        sadomasochistic_practises("R", "V").
        cause_death("R", "V").
    }).

% Cassazione penale sez. V, 01/02/2018, n.18048
#pos({
    	manslaughter("R", "V")
    },{
   	 
    },{
    	harmful_intention("R").
        cause_death("R", "V").
    }).

% Cassazione penale sez. V, 11/12/2018, n.13192
#pos({
        manslaughter("R", "V")
    },{
        blamed_for("robbery")
    },{
        theft_intention("R").
        own("V", "oggetto").
        subtract("R", "oggetto").
        res("oggetto").
        take_possession("R", "oggetto").
        harmful_intention("R").
        damage("R", "V").
        cause_death("R","V").
    }).

% Cassazione penale, sez. V, 27/09/2022, n. 46467
#pos({
        manslaughter("R", "V")
    },{

    },{
        assault("R", "V").
        derive_illness("V").
        derive("V", "rottura osso ioide").
        illness("rottura osso ioide").
        cause_death("R", "V").
        harmful_intention("R").
    }).

% Cassazione penale, sez. V, 06/12/2022, n. 11670
#pos({
        personal_injuries("R", "V", "ecchimosi"),
        manslaughter("R", "V"),
        blamed_for("manslaughter")
    },{

    },{
        harmful_intention("R").
        shake("R", "V").
        derive_illness("V").
        derive("V", "ecchimosi").
        physical_illness("ecchimosi").
        cause_death("R", "V").
    }).

% Cassazione penale sez. II, 22/11/2023, n.890
#pos({
        personal_injuries("R", "V", "insufficienza cardiaca acuta"),
        manslaughter("R", "V"),
        blamed_for("manslaughter")
    },{

    },{
        robbery("R", "V").
        derive_illness("V"). 
        derive("V", "insufficienza cardiaca acuta").
        illness("insufficienza cardiaca acuta").
        harmful_intention("R").
        immobilize("R", "V").
        gag("R", "V").
        cause_death("R", "V").
    }).

% Cassazione penale, sez. V, 16/04/2015, n. 48007
#neg({
        affray("G", "G1")
    },{

    },{
        harmful_intention("G").
        resistence("G1", "G").
    }).

#neg({
        affray("G", "G1")
    },{

    },{
        harmful_intention("G").
        defense("G1").
    }).

#neg({
        affray("G", "G1")
    },{

    },{
        harmful_intention("G1").
        resistence("G", "G1").
    }).

#neg({
        affray("G", "G1")
    },{

    },{
        harmful_intention("G1").
        defense("G").
    }).

% Cassazione penale sez. I, 07/04/2016, n.30215
#pos({
        affray("G1","G2"),
        personal_injuries("R","R1","illness")
    },{

    },{
        harmful_intention("R").
        harmful_intention("R2").
        harmful_intention("G2").
        damage("R", "R1").
        derive_illness("R1").
        derive("R1", "illness").
        illness("illness").
        agent("R1").
        agent("R2").
        part_of("R","G1").
        part_of("R1","G2").
        part_of("R2","G1").
    }).

#pos({
        affray("G1","G2"),
        murder("R", "R1")
    },{

    },{
        harmful_intention("G1").
        harmful_intention("G2").
        death_intention("R").
        cause_death("R", "R1").
        agent("R1").
        agent("R2").
        part_of("R","G1").
        part_of("R1","G2").
        part_of("R2","G1").
    }).

% Tribunale Napoli sez. V, 16/01/2018, n.205
#pos({
        beatings("R", "R2"),
        beatings("R1", "R2")
    },{
        affray("G", "G1")
    },{
        harmful_intention("R").
        harmful_intention("R1").
        defense("G1").
        damage("R1", "R2"). % rispondono di eventuali conseguenze di loro azione violenta
        damage("R", "R2").
        agent("R1").
        agent("R2").
        part_of("R","G").
        part_of("R1", "G").
        part_of("R2", "G1").
    }).

% Cassazione penale sez. VI, 04/12/2019, n.12200
#neg({
        affray("R", "V")
    },{

    },{
        harmful_intention("G").
        run_away("R2").
        agent("R1").
        agent("R2").
        part_of("R","G").
        part_of("R1", "G").
        part_of("R2", "G1").
    }).

% Tribunale Frosinone, 11/10/2023, n. 1823
#neg({
        negligent_manslaughter("R", "V")
    },{
    
    },{
        uncertain_dynamics("R", "V").
        illness("lesione").
        derive("V", "lesione").
        derive_illness("V").
        caused_by("V", "V", "caduta bicicletta", "lesione").
    }).

% Cassazione penale, sez. IV, 19/12/2023, n. 7192
#pos({
        negligent_manslaughter("R", "V")
    },{
        respect_rules("norme antinfortunistiche")     
    },{
        cause_death("R", "V").
        rules("norme antinfortunistiche").
        negligence("R").
    }).

% Corte appello, Bari, sez. II, 22/02/2024, n. 315
#neg({
        negligent_manslaughter("R", "V")
    },{

    },{
        uncertain_dynamics("R", "V").
        cause_death("R", "V").
    }).

#modeb(uncertain_dynamics(var(agent), var(agent)), (anti_reflexive)).
#modeb(cause_death(var(agent), var(agent)), (anti_reflexive)).
#modeb(negligent_manslaughter(var(agent), var(agent)), (anti_reflexive)).

% Tribunale Genova sez. I, 30/05/2022, n.2072
#pos({
        vehicular_homicide("R", "V")
    },{
        respect_rules("R", "circolazione stradale")
    },{
        negligence("R").
        cause_death("R", "V").
        rules("circolazione stradale").
    }).

% Tribunale Frosinone, 21/08/2023, n.1110
#pos({
        vehicular_homicide("R", "V"),
        negligence("R")
    },{
        caution("R")
    },{
        cause_death("R", "V").
        rules("circolazione stradale").
    }).

% Cassazione penale sez. IV, 22/11/2023, n.1929
#neg({
        vehicular_homicide("R", "V")
    },{
        decelerate("R"),
        observe_precedence("V"),
        respect_rules("V", "circolazione stradale"),
        respect_rules("R", "circolazione stradale")
    },{
        higher_speed("R").
        cause_death("R", "V").
        negligence("V").
        rules("circolazione stradale").
    }).

% Cassazione penale sez. IV, 16/01/2024, n.9903
#pos({
        vehicular_homicide("R", "V")
    },{
        observe_precedence("R"), 
        respect_rules("R", "circolazione stradale")
    },{
        higher_speed("R").
        negligence("R").
        cause_death("R", "V").
        rules("circolazione stradale").
    }).

#neg({
        respect_rules("R", "circolazione stradale")
    },{

    },{
        higher_speed("R"). 
        rules("R", "circolazione stradale").
    }).

% Cassazione penale sez. IV, 08/02/2024, n.12328
#pos({
        vehicular_homicide("R", "V"),
        personal_injuries("R", "V1", "illness"),
        harmful_intention("R")
    },{
        respect_rules("R", "circolazione stradale")
    },{
        cause_death("R", "V").
        rules("circolazione stradale").
        negligence("R").
        agent("V1").
        illness("illness").
        derive("V1", "illness").
        derive_illness("V1").
        damage("R", "V1").        
    }).



% Cassazione penale sez. V, 31/05/2023, n.36468
#pos({
        defamation("R", "V")
    },{
        
    },{
        spread("R", "che carogne", "V", "Facebook").
        social("Facebook").
    }).

% Corte appello Napoli sez. III, 31/07/2023, n.7725
#pos({
        defamation("R", "V")
    },{
        
    },{
        spread("R", "frasi lesive", "V", "T").
    }).

% Cassazione penale sez. V, 23/01/2024, n.17141
#pos({
        defamation("R", "V")  
    },{
        
    },{
        spread("R", "foto offensiva", "V", "WhatsApp").
        social("WhatsApp").
    }).

% Tribunale Cassino, 05/02/2024, n.30
#neg({
        defamation("R", "V")
    },{
        offend("R", "V")
    },{
        comunicate("R", "T").
        agent("T").
    }).

% Tribunale Ferrara, 23/02/2024, n.1659
#pos({
        defamation("R", "V")
    },{
        
    },{
        spread("R", "frasi lesive", "V", "Facebook"). 
        social("Facebook").
    }).

% Cassazione penale sez. III, 23/05/2023, n.32951
#pos({
        sexual_assault("R", "V")
    },{

    },{
        violence("R", "V").
        threat("R", "V").
        force("R", "V", "rapporto sessuale").
        sexual_action("rapporto sessuale").
    }).

% Tribunale Taranto sez. I, 11/07/2023, n.1856
#pos({
        sexual_assault("R", "V")
    },{
        consent("R", "V")
    },{
        threat("R", "V").
        force("R", "V", "bacio").
        sexual_action("bacio").
    }).

% Tribunale Torino, 23/10/2023, n.1684
#pos({
        sexual_assault("R", "V")
    },{
        consent("V")
    },{
        violence("R", "V"). 
        force("R", "V", "palpeggiamento").
        sexual_action("palpeggiamento").
    }).

#pos({
        sexual_assault("R", "V")
    },{
        consent("V")
    },{
        violence("R", "V"). 
        force("R", "V", "sfregamento").
        sexual_action("sfregamento").
    }).

#pos({
        sexual_assault("R", "V")
    },{
        consent("V")
    },{
        violence("R", "V"). 
        force("R", "V", "bacio").
        sexual_action("bacio").
    }).

#pos({
        sexual_assault("R", "V")
    },{
        consent("V")
    },{
        threat("R", "V"). 
        force("R", "V", "palpeggiamento").
        sexual_action("palpeggiamento").
    }).

#pos({
        sexual_assault("R", "V")
    },{
        consent("V")
    },{
        threat("R", "V"). 
        force("R", "V", "sfregamento").
        sexual_action("sfregamento").
    }).

#pos({
        sexual_assault("R", "V")
    },{
        consent("V")
    },{
        threat("R", "V"). 
        force("R", "V", "bacio").
        sexual_action("bacio").
    }).

#pos({
        sexual_assault("R", "V")
    },{
        consent("V")
    },{
        abuse_authority("R", "V"). 
        force("R", "V", "palpeggiamento").
        sexual_action("palpeggiamento").
    }).

#pos({
        sexual_assault("R", "V")
    },{
        consent("V")
    },{
        abuse_authority("R", "V"). 
        force("R", "V", "sfregamento").
        sexual_action("sfregamento").
    }).

#pos({
        sexual_assault("R", "V")
    },{
        consent("V")
    },{
        abuse_authority("R", "V"). 
        force("R", "V", "bacio").
        sexual_action("bacio").
    }).

% Tribunale Gorizia, 08/11/2023, n.853
#pos({
        sexual_assault("R", "V")
    },{
        consent("V")
    },{
        violence("R", "V").
        force("R", "V", "penetrazione").
        sexual_action("penetrazione").
        absence_will("V").
    }).

#neg({
        consent("V")
    },{

    },{
        absence_will("V").
    }).


% Tribunale Lecce sez. I, 20/02/2024, n.355
#pos({
        sexual_assault("R", "V")
    },{
        consent("V")
    },{
        abuse_authority("R", "V").
        force("R", "V", "palpeggiamento").
        sexual_action("palpeggiamento").
        resistence("V", "R").
    }).

#neg({
        consent("V")
    },{

    },{
        resistence("V", "R").
    }).

%%% Articolo 610
% Cassazione penale sez. V, 17/11/2022, n.9957
#pos({
        private_violence("R", "V")
    },{

    },{
        force("R", "V", "rinunciare a visita").
        action("rinunciare a visita").
        block_way("R", "V").
    }).

% Cassazione penale sez. V, 14/12/2022, n.3991
#pos({
        private_violence("R", "V")
    },{

    },{
        occupy("R", "V", "casa").
        force("R", "V", "non accedere").
        action("non accedere").
    }).

% Tribunale Nola, 10/01/2023, n.24
#pos({
        private_violence("R", "V")
    },{

    },{
        threat("R", "V").
        push("R", "V").
        force("R", "V", "rimanere").
        action("rimanere").
    }).

% Cassazione penale sez. V, 27/01/2023, n.20365
#pos({
        private_violence("R", "V")
    },{

    },{
        threat("R", "V").
        force("R", "V", "tollerare").
        action("tollerare").
    }).

#pos({
        private_violence("R", "V")
    },{

    },{
        threat("R", "V").
        force("R", "V", "omettere").
        action("omettere").
    }).

#pos({
        private_violence("R", "V")
    },{

    },{
        threat("R", "V").
        force("R", "V", "fare").
        action("fare").
    }).

% Tribunale Gorizia, 24/05/2023, n.534
#pos({
        private_violence("R", "V")
    },{

    },{
        threat("R", "V").
        force("R", "V", "obbedire").
        action("obbedire").
    }).

% Tribunale Frosinone, 20/10/2023, n.1588
#pos({
        private_violence("R", "V"),
        trespassing("R", "V")
    },{
        consent("V")
    },{
        dwelling("V", "ingresso").
        force("R", "ingresso").
        assault("R", "V").
        threat("R", "V").
        res_violence("R", "beni").
        res("beni").
        force("R", "V", "barricarsi").
        action("barricarsi").
    }).

#pos({
        private_violence("R", "V")
    },{

    },{
        surpass("R", "V").
        block_way("R", "V").
        force("R", "V", "non proseguire").
        action("non proseguire").
    }).



% Tribunale Pescara, 31/10/2018, n.2659
#pos({
        trespassing("R", "V"),
        private_violence("R", "V")
    },{
        consent("V")
    },{
        break_into_dwelling("R", "V", "abitazione").
        dwelling("V", "abitazione").
        violence("R", "V").
        force("R", "V", "uscire").
        action("uscire").
    }).

#pos({
        trespassing("R", "V"),
        private_violence("R", "V")
    },{
        consent("V")
    },{
        break_into_dwelling("R", "V", "abitazione").
        dwelling("V", "abitazione").
        threat("R", "V").
        force("R", "V", "uscire").
        action("uscire").
    }).

% Tribunale La Spezia sez. uff. indagini prel., 22/10/2020
#neg({
        trespassing("R", "V"),
        break_into_dwelling("R", "V", "coorte")
    },{
        consent("V")
    },{
        feed("R", "gatti").
        dwelling("V", "coorte").
    }).

% Cassazione penale sez. V, 13/07/2022, n.34784
#pos({
        trespassing("R", "V")
    },{
        consent("V")
    },{
        dwelling("V", "androne palazzo").
        dwelling("V", "scale palazzo").
        break_into_dwelling("R", "V", "androne palazzo").
        break_into_dwelling("R", "V", "scale palazzo").
    }).

% Cassazione penale sez. V, 05/05/2023, n.31700
#pos({
        trespassing("R", "V")
    },{
        consent("V")
    },{
        park("R", "parcheggio condominiale", "moto").
        park("R", "parcheggio condominiale", "auto").
        dwelling("V", "parcheggio condominiale").
    }).

% Tribunale Trieste, 27/11/2023, n.1928
#pos({
        trespassing("R", "V"),
        theft("R", "V", "sostanza stupefacente")
    },{
        consent("V")
    },{
        break_into_dwelling("R", "V", "abitazione").
        dwelling("V", "abitazione").
        own("V", "sostanza stupefacente").
        subtract("R", "sostanza stupefacente").
        take_possession("R", "sostanza stupefacente").
        theft_intention("R"). 
        res("sostanza stupefacente").
    }).


% Hypothesis space:

2 ~ death_intention(R) :- aware_of_consequences(R).

2 ~ damage(R, V) :- assault(R, V).

2 ~ damage(R, V) :- stab(R, V).

2 ~ :- not consent(V), consenting_murder(R, V).

2 ~ sadomasochistic_practises(R, V) :- breath_playing(R, V).

2 ~ sadomasochistic_practises(R, V) :- bondage(R, V).

2 ~ :- pleasure_intention(R), harmful_intention(R).

2 ~ damage(R, V) :- shake(R, V).

2 ~ harmful_intention(V1) :- damage(V1,V2), rules("circolazione stradale").

2 ~ offend(V1,V2) :- spread(V1,"foto offensiva",V2,V3).

2 ~ comunicate(V1,V2) :- spread(V1,"foto offensiva",V3,V2).

2 ~ offend(V1,V2) :- spread(V1,"frasi lesive",V2,V3).

2 ~ comunicate(V1,V2) :- spread(V1,"frasi lesive",V3,V2).

2 ~ agent(V1) :- spread(V2,"foto offensiva",V3,V1).

2 ~ agent(V1) :- spread(V2,"frasi lesive",V3,V1).

2 ~ spread(R, "frasi lesive", V, T) :- spread(R, "che carogne", V, T).

2 ~ :- consent(V), resistence(V, R).

2 ~ :- feed(R, "gatti"), break_into_dwelling(R,  V, "coorte").

2 ~ violence(R, V) :- deprive_freedom(R, V).

3 ~ deprive_freedom(R, V) :- block_way(R, V), force(R, V, A), action(A).

3 ~ deprive_freedom(R, V) :- occupy(R, V, C), force(R, V, A), action(A).

3 ~ threat(R, V) :- surpass(R, V), block_way(R, V).

3 ~ break_into_dwelling(R, V, C):- force(R, C), dwelling(V, C).

3 ~ death_intention(R):- robbery(R, V), use_object(R, V, "arma da fuoco").

3 ~ death_intention(R) :- caused_by(R, V, "alcol denaturato", "death"), substance("alcol denaturato").

3 ~ handicap(V) :- has_illness(V, "idrocefalo congenito"), illness("idrocefalo congenito").

3 ~ handicap(V) :- has_illness(V, "affezione morbosa inguaribile"), illness("affezione morbosa inguaribile").

3 ~ :- handicap(V), incapacity_understanding(V), consent(V).

3 ~ damage(R, V) :- immobilize(R, V), gag(R, V).

3 ~ :- higher_speed(R), respect_rules(R, "circolazione stradale").

4 ~ aware_of_consequences(R) :- robbery(R, V), bind(R, V), gag(R, V).

3 ~ observe_precedence(R) :- respect_rules(R, "circolazione stradale"), rules("circolazione stradale").

4 ~ aware_of_consequences(R) :- robbery(R, V), obstruct(R, V, "naso"), obstruct(R, V, "bocca").

4 ~ 2{death_intention(R); damage(R, V)}2:- stab(R, V), number_of_wounds(V, 11).

4 ~ 2{death_intention(R); damage(R, V)}2 :- use_object(R, V, "arma da fuoco"), shoot(R, V, "volto", 5), number_of_shots(V, 5).

4 ~ death_intention(R) :- stab_body(R, V, "addome"), part_of_body(V, "addome"), violence(R, V).

4 ~ 2{damage(R, V); death_intention(R)}2 :- throw(R, V, "sasso"), go_through(V, "auto").

4 ~ 2{damage(R, V); death_intention(R)}2 :- stab_body(R, V, "zona orbitale"), part_of_body(V, "zona orbitale").

4 ~ murder(R, V) :- administer(R, V, N), medicine(N), cause_death(R, V).

4 ~ 2{damage(R, V); death_intention(R)}2 :- stab_body(R, V, "organi vitali"), part_of_body(V, "organi vitali").

4 ~ negligence(R) :- sadomasochistic_practises(R, V), not harmful_intention(R), consent(V).

4 ~ harmful_intention(G) :- harmful_intention(R), agent(R), part_of(R, G).

4 ~ :- uncertain_dynamics(R, V), caused_by(V, V, H, I), illness(I), negligent_manslaughter(R, V), R!=V.

4 ~ break_into_dwelling(R, V, "parcheggio condominiale") :- park(R, "parcheggio condominiale", "moto"), park(R, "parcheggio condominiale", "auto"), dwelling(V, "parcheggio condominiale").

5 ~ negligence(R) :- not caution(R), not respect_rules(R, "circolazione stradale"), rules("circolazione stradale"), cause_death(R, V).