
%%%% Art.624 furto

% res: cosa mobile
res(C) :- physical_object(C).
res(C) :- energy(C), economic_value(C).

% reo: chi sottrae la cosa
% vittima: chi subisce il furto
reo(R) :- theft(R, V, C). 
victim(V) :- theft(R, V, C). 
reo(R) :- attempted_theft(R, V, C). 
victim(V) :- attempted_theft(R, V, C). 
agent(R) :- reo(R).
agent(V) :- victim(V).

theft(R, V, C) :- subtract(R, C), own(V, C), theft_intention(R), take_possession(R, C), agent(V), agent(R), res(C), V!=R.     %% dò per scontato che è al fine di procurare profitto per sè/altri
attempted_theft(R, V, C) :- subtract(R, C), own(V, C), theft_intention(R), not take_possession(R, C), agent(V), agent(R), res(C), V!=R. 


%%%% precisazione violenza (massima, tribunale Bologna, sez I, 11/05/2023, n 440)

violence(R, V) :- damage(R, V), agent(R), agent(V), V!=R.      
snatch(R, C) :- loose_physical_adherence(V, C), subtract(R, C), agent(V).
subtract(R, C) :- snatch(R, C), agent(R), res(C).

person_violence(R, V) :- violence(R, V).
person_violence(R, V) :- foreshadowing_violence(R), agent(V).                      %%se le azioni possono portare a una lesione ma non accade è comunque violenza
indirect_violence_person((R, V) :- violence(R, V), not foreshadowing_violence(R). 
res_violence(R, C) :- snatch(R, C), agent(R), res(C).


%% Vaghezza aderenza: L è il livello di aderenza (da 1 a 4, aderenza più stretta a 4)

tight_physical_adherence(S, C) :- adherence(S, C, L), agent(S), res(C), L>2.
loose_physical_adherence(S, C) :- adherence(S, C, L), agent(S), res(C), L<3.


%%%% precisazione violenza (massima, cassazione penale, sez II, 11/12/2013, n 49832)

person_violence(R, V) :- resistence(V, R), not interruption(R).
person_violence(R, V) :- tight_physical_adherence(V, C), subtract(R, C), agent(V).


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


%%% CODICI IDENTIFICATIVI SENTENZE
%  #1: Cassazione penale sez. I, 10/01/1979
%  #2: Cassazione penale sez. I, 07/04/1982
%  #3: Cassazione penale sez. II, 30/04/1985
%  #4: Corte appello Roma sez. I, 19/10/2017, n.7573
%  #5: Cassazione penale sez. II, 21/02/2019, n.16899
%  #6: Cassazione penale sez. II, 14/09/2021, n.36178
%  #7: Cassazione penale sez. II, 10/02/2022, n.12453     


2{damage(R, V); using_judgment("#1")}2 :- twist(R, V, P), part_of_body(V, P).
2{damage(R, V); using_judgment("#2")}2 :- drag(R, V), make_fall(R, V).
2{damage(R, V); using_judgment("#3")}2 :- drag(R, V), tug(R, V).
2{damage(R, V); using_judgment("#4")}2 :- tug(R, V), push(R, V).
2{damage(R, V); using_judgment("#5")}2 :- block(R, V, P), part_of_body(V, P).
2{threat(R, V); using_judgment("#6")}2 :- selfdetermination_limitation(R, V).
2{foreshadowing_violence(R); using_judgment("#7")}2 :- subtract(R, C), tight_physical_adherence(C).
