
%%%% Art.624 furto

% res: cosa mobile
res(C) :- physical_object(C).
res(C) :- energy(C), economic_value(C).

% reo: chi sottrae la cosa
% vittima: chi subisce il furto
reo(R, "robbery") :- robbery(R, V). 
victim(V, "robbery") :- robbery(R, V). 

reo(R, "attempted_robbery") :- attempted_robbery(R, V). 
victim(V, "attempted_robbery") :- attempted_robbery(R, V). 

reo(R, "theft_snatch") :- theft_snatch(R, V). 
victim(V, "theft_snatch") :- theft_snatch(R, V). 

reo(R, "attempted_theft_snatch") :- attempted_theft_snatch(R, V). 
victim(V, "attempted_theft_snatch") :- attempted_theft_snatch(R, V). 

agent(R) :- reo(R, F). % colui che commette un crimine
agent(V) :- victim(V, F). % la parte lesa

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



%%%% Art 582 lesioni personali

illness(I) :- physical_illness(I).
illness(I) :- mental_illness(I).

reo(R, "personal_injuries") :- personal_injuries(R, V, I).
victim(V, "personal_injuries") :- personal_injuries(R, V, I).

reo(R, "beatings") :- beatings(R, V).
victim(V, "beatings") :- beatings(R, V).

personal_injuries(R, V, I) :- damage(R, V), harmful_intention(R), derive_illness(V), derive(V, I), agent(R), agent(V), illness(I), R!=V.

illness(I) :- derive(V, I).

%%%% Art. 581 percosse  

beatings(R, V) :- damage(R, V), harmful_intention(R), not derive_illness(V), agent(R), agent(V), R!=V.

% Vaghezza contusione: D è il grado delle contusioni (da 1 a 3, contusione più lieve a 1, più grave a 3)

degree(1..3).

1{bruises(R, V, D): degree(D)}1 :- unknown_bruises(R, V).

minor_bruises(R, V) :- bruises(R, V, D), agent(R), agent(V), D=1.
serious_bruises(R, V) :- bruises(R, V, D), agent(R), agent(V), D>1.

degree(D) :- bruises(R, V, D).



:- danger_of_illness(V, I), derive_illness(V).

% Tribunale Roma, 13/11/1992

% attempted_personal_injuries(R, V, I) :- injuries_intention(R), damage(R, V), not derive_illness(V), danger_of_illness(V, I), illness(I), agent(R), agent(V), R!=V.

% Cassazione penale sez. V, 14/10/2015, n.6460

% attempted_personal_injuries(R, V, I) :- injuries_intention(R), damage(R, V), interruption(R), agent(R), agent(V), R!=V.


% Tribunale Frosinone, 15/04/2022, n.363
:- attempted_personal_injuries(R, V, I), personal_injuries(R, V, I).

:- attempted_crime(R, V, F), crime(R, V, F).

crime(R, V, "personal_injuries") :- personal_injuries(R, V, I).
crime(R, V, "beatings") :- beatings(R, V).
crime(R, V, "theft_snatch") :- theft_snatch(R, V).
crime(R, V, "robbery") :- robbery(R, V).
attempted_crime(R, V, "personal_injuries") :- attempted_personal_injuries(R, V, I).
attempted_crime(R, V, "theft") :- attempted_theft(R, V, C).
attempted_crime(R, V, "theft_snatch") :- attempted_theft_snatch(R, V).
attempted_crime(R, V, "robbery") :- attempted_robbery(R, V).


%%% art 56
% Chi compie atti idonei, diretti in modo non equivoco a commettere un delitto, 
% risponde di delitto tentato [8 4 c.p.p.], se l'azione non si compie o l'evento 
% non si verifica [49 2].


% attempted_crime(R, V, F) :- criminal_intention(R, F), not action(R), agent(R), agent(V), R!=V.

% attempted_crime(R, V, F) :- criminal_intention(R, F), not event(V), agent(R), agent(V), R!=V.

criminal_intention(R, "personal_injuries") :- injuries_intention(R).
criminal_intention(R, "robbery") :- theft_intention(R), violence(R, V).
criminal_intention(R, "theft_snatch") :- theft_intention(R).

action(R) :- take_possession(R, C).
event(V) :- derive_illness(V).


agent("R").
agent("V"). 


%%% art 49
% [II]. La punibilità è altresì esclusa quando, per la inidoneità dell'azione o per la inesistenza 
% dell'oggetto di essa, è impossibile l'evento dannoso o pericoloso



#pos({
	    attempted_crime("R", "V", "personal_injuries"), 
	    damage("R", "V")
    }, {
    	derive_illness("V")
    }, {
        illness("H.I.V.").
     	hit("R", "V").
        injuries_intention("R").
     	use_object("R", "V", "ago").
     	danger_of_illness("V", "H.I.V.").
    }).


%%%  Cassazione Penale 49832/2013

#pos({
        attempted_crime("R", "V", "theft_snatch")
    },{

    },{
        theft_intention("R"). 
        physical_object("oggetto"). 
        own("V", "oggetto"). 
        subtract("R", "oggetto").  
        resistence("V", "R"). 
        interruption("R").
    }).

#pos({
        attempted_crime("R", "V", "robbery")
    },{
        interruption("R"), 
        take_possession("R","oggetto")
    },{
        theft_intention("R"). 
        physical_object("oggetto"). 
        own("V","oggetto"). 
        subtract("R","oggetto"). 
        resistence("V","R").
    }).

%%% Tribunale Genova sez. II, 06/09/2023, n.2622

#pos({
        attempted_crime("R","V","theft"),
        theft_intention("R")
    },{
        take_possession("R","oggetto")
    },{
        open("R","armadietti").
        open("R","porte").
        force("R","armadietti").
        force("R","porte").
        own("V","oggetto").
        subtract("R","oggetto").
        res("oggetto").
    }).


#modeh(attempted_crime(var(agent), var(agent), const(crime))).
#modeb(1, damage(var(agent), var(agent)), (anti_reflexive)).
#modeb(1, danger_of_illness(var(agent), const(illness)), (anti_reflexive)).
#modeb(1, illness(const(illness))).
#modeb(1, injuries_intention(var(agent))).
#modeb(1, theft_intention(var(agent))).
#modeb(1, resistence(var(agent), var(agent)), (anti_reflexive)).

#modeb(1, own(var(agent), const(res)), (anti_reflexive)).
#modeb(1, subtract(var(agent), const(res)), (anti_reflexive)).
#modeb(1, res(const(res))).
#constant(res, "oggetto").

#modeh(damage(var(agent), var(agent)), (anti_reflexive)).
#modeb(1, hit(var(agent), var(agent)), (anti_reflexive)).
#modeb(1, use_object(var(agent), var(agent), const(object))).
#constant(object, "ago").

#constant(crime, "personal_injuries").
#constant(crime, "beatings").
#constant(crime, "theft_snatch").
#constant(crime, "robbery").

#constant(illness, "H.I.V.").

3 ~ theft_intention(R) :- open(R, O), force(R, O).

#maxv(2).