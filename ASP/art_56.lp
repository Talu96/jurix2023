%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Art. 56 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Chi compie atti idonei, diretti in modo non equivoco a commettere un delitto, 
% risponde di delitto tentato, se l'azione non si compie o l'evento 
% non si verifica.

% attempted_crime(R, V, F) :- criminal_intention(R, F), not action(R), agent(R), agent(V), R!=V.

% attempted_crime(R, V, F) :- criminal_intention(R, F), not event(V), agent(R), agent(V), R!=V.

% criminal_intention(R, "murder") :- death_intention(R).
% criminal_intention(R, "personal_injuries") :- injuries_intention(R).
% criminal_intention(R, "theft_snatch") :- theft_intention(R), not violence(R, V), agent(V).
% criminal_intention(R, "robbery") :- theft_intention(R), violence(R, V).


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