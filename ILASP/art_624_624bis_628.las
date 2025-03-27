
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


%%%% massima, cassazione penale, sez II, 11/12/2013, n 49832

attempted_theft_snatch(R, V) :- resistence(V, R), interruption(R).
attempted_theft_snatch(R, V) :- attempted_theft(R, V, C), snatch(R, C).
attempted_robbery(R, V) :- resistence(V, R), not interruption(R), not take_possession(R, C), res(C).
attempted_robbery(R, V) :- attempted_theft(R, V, C), person_violence(R, V).
attempted_robbery(R, V) :- attempted_theft(R, V, C), threat(R, V).


:- attempted_theft_snatch(R, V), theft_snatch(R, V).
:- attempted_robbery(R, V), robbery(R, V).

resistence(V, R) :- tug(R, V).

agent("R").
agent("V").


%%% Esempio 1: Cassazione penale sez. I, 10/01/1979
#pos({
        robbery("R", "V"), 
        damage("R", "V")
    }, {

    }, {
        theft_intention("R"). 
        physical_object("oggetto"). 
        own("V", "oggetto"). 
        subtract("R", "oggetto"). 
        tight_physical_adherence("V", "oggetto"). 
        twist("R", "V", "polso"). 
        part_of_body("V", "polso"). 
        take_possession("R", "oggetto").
    }).

%%% Esempio 2: Cassazione penale sez. I, 07/04/1982
#pos({
        robbery("R", "V")
    }, {

    }, {
        theft_intention("R"). 
        physical_object("oggetto"). 
        own("V", "oggetto"). 
        subtract("R", "oggetto"). 
        drag("R", "V"). 
        make_fall("R", "V"). 
        take_possession("R", "oggetto").
    }).

%%% Esempio 3: Tribunale minorenni Catania, 25/11/1983
#pos({
        robbery("R", "V")
    }, {

    }, {
        theft_intention("R"). 
        physical_object("oggetto"). 
        own("V", "oggetto"). 
        subtract("R", "oggetto"). 
        resistence("V", "R"). 
        take_possession("R", "oggetto").
    }).

%%% Esempio 4: Cassazione penale sez. II, 08/11/1984
#pos({
        robbery("R", "V")
    }, {

    }, {
        theft_intention("R"). 
        physical_object("oggetto"). 
        own("V", "oggetto"). 
        subtract("R", "oggetto"). 
        person_violence("R", "V"). 
        take_possession("R", "oggetto").
    }).

%%% Esempio 5: Cassazione penale sez. II, 30/04/1985
#pos({
        robbery("R", "V"), 
        damage("R", "V")
    }, {

    }, {
        theft_intention("R"). 
        physical_object("borsa"). 
        own("V", "borsa"). 
        subtract("R", "borsa"). 
        drag("R", "V"). 
        tug("R", "V"). 
        take_possession("R", "borsa").
    }).

%%% Esempi 6: Cassazione Penale 49832/2013
%%% Esempio 6.a
#pos({
        attempted_theft_snatch("R", "V")
    }, {

    }, {
        theft_intention("R"). 
        physical_object("oggetto"). 
        own("V", "oggetto"). 
        subtract("R", "oggetto").  
        resistence("V", "R"). 
        interruption("R").
    }).
%%% Esempio 6.b
#pos({
        attempted_robbery("R", "V")
    }, {
        interruption("R"), 
        take_possession("R", "oggetto")
    }, {
        theft_intention("R"). 
        physical_object("oggetto"). 
        own("V", "oggetto"). 
        subtract("R", "oggetto"). 
        resistence("V", "R").
    }).
%%% Esempio 6.c
#pos({
        robbery("R", "V")
    }, {
        interruption("R")
    }, {
        theft_intention("R"). 
        physical_object("oggetto"). 
        own("V", "oggetto"). 
        subtract("R", "oggetto"). 
        resistence("V", "R"). 
        take_possession("R", "oggetto").
    }).

%%% Esempi 7: Cassazione penale sez. II, 02/04/2014, n.17348
%%% Esempio 7.a
#pos({
        theft_snatch("R", "V")
    }, {

    }, {
        theft_intention("R"). 
        physical_object("oggetto"). 
        own("V", "oggetto"). 
        subtract("R", "oggetto"). 
        res_violence("R", "oggetto"). 
        indirect_violence_person("R", "V"). 
        take_possession("R", "oggetto").
    }).
%%% Esempio 7.b
#pos({
        robbery("R", "V")
    }, {

    }, {
        theft_intention("R"). 
        physical_object("oggetto"). 
        own("V", "oggetto"). 
        subtract("R", "oggetto"). 
        tight_physical_adherence("V", "oggetto"). 
        resistence("V", "R"). 
        take_possession("R", "oggetto").
    }).

%%% Esempio 8: Tribunale Firenze sez. I, 08/04/2016, n.2247
#pos({
        theft_snatch("R", "V")
    }, {
        person_violence("R", "V"), 
        indirect_violence_person("R", "V")
    }, {
        theft_intention("R"). 
        physical_object("telefono"). 
        own("V", "telefono"). 
        subtract("R", "telefono"). 
        snatch("R", "telefono"). 
        take_possession("R", "telefono").
    }).

%%% Esempio 9: Corte appello Roma sez. I, 19/10/2017, n.7573
#pos({
        robbery("R", "V")
    }, {

    }, {
        theft_intention("R"). 
        physical_object("telefono"). 
        own("V", "telefono"). 
        subtract("R", "telefono"). 
        push("R", "V"). 
        resistence("V", "R"). 
        take_possession("R", "telefono").
    }).

%%% Esempio 10: Cassazione penale sez. II, 21/02/2019, n.16899
#pos({
        robbery("R", "V")
    }, {
        res_violence("R", "orecchini")
    }, {
        theft_intention("R"). 
        physical_object("orecchini"). 
        own("V", "orecchini"). 
        subtract("R", "orecchini"). 
%        snatch("R", "orecchini"). 
        block("R", "V", "testa"). 
        part_of_body("V", "testa"). 
        take_possession("R", "orecchini").
    }).

%%% Esempio 11: Tribunale Pescara, 07/05/2019, n.1639 
#pos({
        robbery("R", "V")
    }, {

    }, {
        theft_intention("R"). 
        physical_object("borsa"). 
        own("V", "borsa"). 
        subtract("R", "borsa"). 
        threat("R", "V"). 
        push("R", "V"). 
        tug("R", "V"). 
        take_possession("R", "borsa").
    }).

%%% Esempio 12: Tribunale Trieste, 11/05/2021, n.746
#pos({
        robbery("R", "V")
    }, {
        
    }, {
        theft_intention("R"). 
        physical_object("certificato eredità"). 
        own("V", "certificato eredità"). 
        subtract("R", "certificato eredità"). 
        tug("R", "V"). 
        take_possession("R", "certificato eredità").
    }).

%%% Esempio 13: Cassazione penale sez. II, 14/09/2021, n.36178
#pos({
        robbery("R", "V")
    }, {

    }, {
        theft_intention("R"). 
        physical_object("oggetto"). 
        own("V", "oggetto"). 
        subtract("R", "oggetto").  
        res_violence("R", "finestrini"). 
        selfdetermination_limitation("R", "V"). 
        take_possession("R", "oggetto").
    }).

%%% Esempio 14: Cassazione penale sez. II, 10/02/2022, n.12453
#pos({
        theft("R", "V", "orologio")
    }, {

    }, {
        theft_intention("R"). 
        physical_object("orologio"). 
        own("V", "orologio"). 
        subtract("R", "orologio"). 
        foreshadowing_violence("R"). 
        take_possession("R", "orologio").
    }).


%%% Esempio 15: Tribunale Potenza, 02/12/2022, n.1178
#neg({
        theft("R", "V", "olive")
    }, {
        theft_intention("R")
    }, {
        subtract("R", "olive").
        own("V", "olive").
        take_possession("R", "olive").
    }).

%%% Esempio 16: Tribunale Nola, 04/01/2023, n.1801
#pos({
        theft_snatch("R", "V")
    }, {

    }, {
        theft_intention("R").
        physical_object("collana").
        own("V", "collana").
        subtract("R", "collana").
        take_possession("R", "collana").
        unknown_adherence("V", "collana"). % deve imparare che è loose_physical_adherence essendoci stato theft_snatch
    }).

%%% Esempi 17: Cassazione penale sez. II, 24/01/2023, n.23932
%%% Esempio 17.a
#pos({
        robbery("R", "V")
    }, {
        
    }, {
        theft_intention("R"). 
        res("res"). 
        own("V", "res"). 
        subtract("R", "res"). 
        tight_physical_adherence("V", "res"). % la person_violence è data da subtract e tight_physical_adherence  
        resistence("V", "R"). 
        take_possession("R", "res").
    }).

%%% Esempio 17.b
#pos({
        theft_snatch("R", "V")
    }, {
         
    }, { 
        theft_intention("R").
        physical_object("orologio").
        own("V", "orologio").
        subtract("R", "orologio").
        block("R", "V", "braccio"). 
        part_of_body("V", "braccio"). 
        res_violence("R", "orologio").
        take_possession("R", "orologio").
    }).

% Cassazione penale sez. un., 25/05/2023, n.41570: theft_intention è dolo che indica 
% qualunque vantaggio anche di natura non patrimoniale, perseguito dall'autore

%%% Esempio 18: Tribunale Genova sez. II, 06/09/2023, n.2622

#pos({
        attempted_theft("R", "V", "oggetto"), 
        theft_intention("R")
    }, {
        take_possession("R", "oggetto")
    }, {
        open("R", "armadietti").
        open("R", "porte").
        force("R", "armadietti").
        force("R", "porte").
        own("V", "oggetto").
        subtract("R", "oggetto").
        res("oggetto").
    }).


%%% Esempio 19: Corte appello Roma sez. IV, 03/10/2023, n.9885
#pos({
        robbery("R", "V"), 
        damage("R", "V")
    }, {
        theft_snatch("R", "V")
    }, {
        theft_intention("R").
        own("V", "borsa").
        subtract("R", "borsa").
        take_possession("R", "borsa").
        physical_object("borsa").
        assault("R", "V").
    }).

%%% Esempio 20: Corte appello Ancona, 11/10/2023, n.2307
#pos({
        theft("R", "V", "merce")
    }, {
        pay("R", "merce")
    }, {
        theft_intention("R").
        own("V", "merce").
        subtract("R", "merce").
        hide("R", "merce").
        res("merce").
        take_possession("R", "merce").
    }).


%%% Esempio 21: Tribunale Nocera Inferiore, 02/11/2023, n.2208

#pos({
    	theft_snatch("R", "V")
	}, {
    	robbery("R", "V"), 
    	resistence("V", "R")
	}, {
    	theft_intention("R").
    	own("V", "oggetto").
    	subtract("R", "oggetto").
    	take_possession("R", "oggetto").
    	res_violence("R", "oggetto").       
    	physical_object("oggetto").
	}).


%%% Esempio 22: Tribunale Frosinone, 06/11/2023, n.1571

#pos({
    	theft("R", "società idrica", "acqua"), 
        theft_intention("R")
	}, {

	}, {
	    own("società idrica", "acqua").
	    take_possession("R", "acqua").
    	subtract("R", "acqua").
	    force("R", "condutture").
        seal("società idrica", "condutture").
	    energy("acqua").
    	economic_value("acqua").
	    agent("società idrica").
    }).

% Hypotesis space H

2 ~ damage(R, V) :- assault(R, V).

3 ~ damage(R, V) :- twist(R, V, P), part_of_body(V, P).

3 ~ damage(R, V) :- drag(R, V), make_fall(R, V).

3 ~ damage(R, V) :- drag(R, V), tug(R, V).

3 ~ damage(R, V) :- tug(R, V), push(R, V).

2 ~ threat(R, V) :- selfdetermination_limitation(R, V).

3 ~ theft_intention(R):- force(R, O), seal(V, O).

3 ~ theft_intention(R) :- open(R, O), force(R, O).

4 ~ foreshadowing_violence(R) :- subtract(R, C), tight_physical_adherence(S, C), agent(S).

8 ~ damage(R, V) :- block(R, V, P), part_of_body(V, P), not res_violence(R, C), agent(R), agent(V), res(C), R!=V.

8 ~ indirect_violence_person(R, V) :- block(R, V, P), part_of_body(V, P), res_violence(R, C), agent(R), agent(V), res(C), R!=V.

%%%%