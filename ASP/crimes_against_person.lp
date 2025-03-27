
reo(R, "murder") :- murder(R, V).
victim(V, "murder") :- murder(R, V).

reo(R, "consenting_murder") :- consenting_murder(R, V).
victim(V, "consenting_murder") :- consenting_murder(R, V).

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

%%% Art. 584 - Omicidio preterintenzionale

manslaughter(R, V) :- harmful_intention(R), cause_death(R, V), agent(R), agent(V), R != V.

%%% Art. 588 - Rissa

affray(G, G1) :- harmful_intention(G), harmful_intention(G1), group(G), group(G1), G!=G1.

% Tribunale Napoli sez. V, 16/01/2018, n.205
% Cassazione penale sez. VI, 04/12/2019, n.12200
% Tribunale Napoli sez. IV, 07/02/2023, n.1222 
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
%%% dove con dwelling (abitazione/dimora) si intende luogo adibito anche in modo non 
%%% continuativo ad uso domestico (Tribunale Lecce sez. I, 31/03/2022, n.820)