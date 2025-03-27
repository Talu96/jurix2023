
illness(I) :- physical_illness(I).
illness(I) :- mental_illness(I).

reo(R, "personal_injuries") :- personal_injuries(R, V, I).
victim(V, "personal_injuries") :- personal_injuries(R, V, I).

reo(R, "attempted_personal_injuries") :- attempted_personal_injuries(R, V, I).
victim(V, "attempted_personal_injuries") :- attempted_personal_injuries(R, V, I).

reo(R, "beatings") :- beatings(R, V).
victim(V, "beatings") :- beatings(R, V).

agent(R) :- reo(R, F). % colui che commette un crimine
agent(V) :- victim(V, F). % la parte lesa

personal_injuries(R, V, I) :- damage(R,V), harmful_intention(R), derive_illness(V), derive(V,I), agent(R), agent(V), illness(I), R!=V.

illness(I) :- derive(V,I).

derive_illness(V) :- derive(V,I), illness(I).

beatings(R, V) :- damage(R,V), harmful_intention(R), not derive_illness(V), agent(R), agent(V), R!=V.

% Vaghezza contusione: D è il grado delle contusioni (da 1 a 3, contusione più lieve a 1, più grave a 3)

degree(1..3).

1{bruises(R, V, D): degree(D)}1 :- unknown_bruises(R, V).

minor_bruises(R, V) :- bruises(R, V, D), agent(R), agent(V), D=1.
serious_bruises(R, V) :- bruises(R, V, D), agent(R), agent(V), D>1.

degree(D) :- bruises(R,V,D).

% Tribunale Roma, 13/11/1992
attempted_personal_injuries(R,V,I) :- injuries_intention(R), damage(R,V), not derive_illness(V), danger_of_illness(V,I), illness(I), agent(R), agent(V), R!=V.

% Cassazione penale sez. V, 14/10/2015, n.6460
attempted_personal_injuries(R,V) :- injuries_intention(R), damage(R,V), interruption(R), agent(R), agent(V), R!=V.

% Tribunale Frosinone, 15/04/2022, n.363
:- attempted_personal_injuries(R,V,I), personal_injuries(R,V,I).

agent("R").
agent("V"). 

%%% Tribunale Roma, 13/11/1992
#pos({
	    attempted_personal_injuries("R", "V", "H.I.V."), 
	    damage("R", "V")
    }, {
    	derive_illness("V")
    }, {
        injuries_intention("R").
        illness("H.I.V.").
     	hit("R", "V").
     	use_object("R", "V", "ago").
     	danger_of_illness("V", "H.I.V.").
    }).


%%% Cassazione penale sez. II, 12/03/2008, n.15420
#pos({
        personal_injuries("R", "V", "contusione escoriata"), 
        derive_illness("V")
    }, {
        beatings("R", "V")
    }, {
        damage("R", "V").
        physical_illness("contusione escoriata").  
        derive("V", "contusione escoriata"). 
        harmful_intention("R"). 
    }).

#pos({
        personal_injuries("R", "V", "cervicalgia"), 
        derive_illness("V")
    }, {
        beatings("R", "V")
    }, {
        damage("R", "V").
        physical_illness("cervicalgia"). 
        derive("V", "cervicalgia"). 
        harmful_intention("R"). 
    }).


%%% Cass. pen., sent. V, 19 gennaio 2010, n. 6371
#pos({
        personal_injuries("R", "V", "lesione cutanea"), 
        damage("R", "V"), 
        derive_illness("V")
    }, {
        beatings("R", "V")
    }, {
        physical_illness("lesione cutanea"). 
        substance("sostanza urticante"). 
        derive("V", "lesione cutanea"). 
        harmful_intention("R"). 
        caused_by("R", "V", "sostanza urticante", "lesione cutanea").
    }).


%%% Cassazione penale sez. V, 29/09/2010, n.43763
#pos({
        personal_injuries("R", "V", "escoriazioni"), 
        derive_illness("V")
    }, {
        beatings("R", "V")
    }, {
        damage("R", "V").
        physical_illness("escoriazioni"). 
        derive("V", "escoriazioni"). 
        harmful_intention("R"). 
    }).


%%% Tribunale Torino sez. uff. indagini prel., 07/04/2011
#pos({
        personal_injuries("R", "V", "abrasioni"), 
        derive_illness("V")
    }, {
        beatings("R", "V")
    }, {
        damage("R", "V").
        physical_illness("abrasioni"). 
        derive("V", "abrasioni"). 
        harmful_intention("R"). 
    }).


%%% Tribunale Bologna sez. II, 18/03/2013, n.1181
#pos({
        beatings("R", "V"), 
        damage("R", "V")
    }, {
        derive_illness("V")
    }, {
        harmful_intention("R"). 
        push("R", "V").
    }).


%%% Cassazione penale sez. V, 14/06/2013, n.46787
#pos({
        personal_injuries("R", "V", "irritazione cutanea"), 
        personal_injuries("R", "V", "nausea"), 
        personal_injuries("R", "V", "conati vomito"), 
        derive_illness("V"), 
        damage("R", "V")
    }, {
        beatings("R", "V")
    }, {
        physical_illness("irritazione cutanea"). 
        physical_illness("nausea"). 
        physical_illness("conati vomito"). 
        derive("V", "irritazione cutanea").
        derive("V", "nausea").
        derive("V", "conati vomito").
        substance("sostanza urticante"). 
        harmful_intention("R"). 
        caused_by("R", "V", "sostanza urticante", "irritazione cutanea").
        caused_by("R", "V", "sostanza urticante", "nausea").
        caused_by("R", "V", "sostanza urticante", "conati vomito").
    }).


%%% Cassazione penale sez. V, 26/06/2013 n. 27990
#pos({
        beatings("R", "V")
    }, {
        derive_illness("V")
    }, {
        harmful_intention("R"). 
        hands_around_throat("R", "V").
    }).

#pos({
        personal_injuries("R", "V", "illness"), 
        derive_illness("V"), 
        damage("R", "V")
    }, {
        beatings("R", "V")
    }, {
        illness("illness"). 
        derive("V", "illness"). 
        harmful_intention("R"). 
        hands_around_throat("R", "V").
    }).


%%% Cassazione penale sez. V, 25/10/2013, n.51393
#pos({
        personal_injuries("R", "V", "graffio"), 
        derive_illness("V")
    }, {
        beatings("R", "V")
    }, {
        damage("R", "V").
        physical_illness("graffio"). 
        derive("V", "graffio"). 
        harmful_intention("R"). 
    }).


%%% Cassazione penale sez. V, 13/06/2014, n.51085
#pos({
        beatings("R", "V")
    }, {
        derive_illness("V")
    }, {
        minor_bruises("R", "V"). 
        part_of_body("V", "braccio"). 
        harmful_intention("R"). 
        tug("R", "V", "braccio"). 
        push("R", "V").
    }).


%%% Corte di cassazione penale, sez. III, 16 ottobre 2014 n. 43316
#pos({
        beatings("R", "V"), 
        damage("R", "V")
    }, {
        derive_illness("V")
    }, {
        harmful_intention("R"). 
        slap("R", "V").
    }).


%%% Tribunale Nola, 22/04/2015, n.795
#pos({
        personal_injuries("R", "V", "trauma"), 
        derive_illness("V")
    }, {
        beatings("R", "V")
    }, {
        damage("R", "V").
        physical_illness("trauma"). 
        derive("V", "trauma"). 
        harmful_intention("R"). 
    }).


%%% Cassazione penale ord. sez. VII, 31/05/2016, n. 29786
#pos({
        personal_injuries("R", "V", "contusione"), 
        damage("R", "V"), 
        derive_illness("V")
    }, {
        beatings("R", "V")
    }, {
        physical_illness("contusione"). 
        serious_bruises("R", "V"). 
        derive("V", "contusione"). 
        harmful_intention("R"). 
    }).


%%% Corte appello Torino sez. I, 28/03/2018, n.2349
#pos({
        personal_injuries("R", "V", "trauma sternale"), 
        damage("R", "V"), 
        derive_illness("V")
    }, {
        beatings("R", "V")
    }, {
        physical_illness("trauma sternale"). 
        serious_bruises("R", "V"). 
        derive("V", "trauma sternale"). 
        harmful_intention("R"). 
        assault("R", "V"). 
    }).


%%% Tribunale Bari sez. I, 22/05/2018, n.2400
#pos({
        personal_injuries("R", "V", "ecchimosi"), 
        damage("R", "V"), 
        derive_illness("V")
    }, {
        beatings("R", "V")
    }, {
        physical_illness("ecchimosi").  
        derive("V", "ecchimosi"). 
        substance("bottiglia di vetro"). 
        harmful_intention("R").  
        caused_by("R", "V", "bottiglia di vetro", "ecchimosi").
    }).


%%% Tribunale Torre Annunziata, 30/07/2018, n.1997
#pos({
        personal_injuries("R", "V", "lesione"), 
        damage("R", "V"), 
        derive_illness("V")
    }, {
        beatings("R", "V")
    }, {
        agitate("R", "cane"). 
        bite("cane", "V"). 
        derive("V", "lesione"). 
        illness("lesione").
        agent("cane"). 
        harmful_intention("R").
    }).


%%% Tribunale Nola, 11/09/2018, n.1603
#pos({
        personal_injuries("R", "V", "otorragia"), 
        damage("R", "V"), 
        derive_illness("V")
    }, {
        beatings("R", "V")
    }, {
        physical_illness("otorragia").  
        derive("V", "otorragia"). 
        harmful_intention("R"). 
        slap("R", "V").
    }).


%%%% Corte appello Ancona, 09/09/2019, n.949
#pos({
        personal_injuries("R", "V", "trauma con distorsione"), 
        personal_injuries("R", "compagno V", "trauma con distorsione"), 
        damage("R", "compagno V"), 
        damage("R", "V"), 
        derive_illness("V"), 
        derive_illness("compagno V")
    }, {
        beatings("R", "V")
    }, {
        agent("compagno V"). 
        physical_illness("trauma con distorsione"). 
        derive("V", "trauma con distorsione"). 
        derive("compagno V", "trauma con distorsione").  
        hit("R", "V"). 
        hit("R", "compagno V"). 
        harmful_intention("R").
    }).


%%% Corte di cassazione penale, sez. I, 6 novembre 2020 n. 31008
#pos({
        personal_injuries("R", "V", "ematoma"), 
        derive_illness("V")
    }, {
        beatings("R", "V")
    }, {
        damage("R", "V").
        physical_illness("ematoma"). 
        derive("V", "ematoma"). 
        harmful_intention("R"). 
    }).


%%% Cassazione penale sez. V, 06/05/2021, n.31665
#pos({
        beatings("R", "V"), 
        damage("R", "V")
    }, {
        derive_illness("V")
    }, {
        harmful_intention("R"). 
        use_object("R", "V", "oggetto").
        blunt("oggetto").
    }).


%%% Tribunale Rovigo, 14/11/2022, n.707
#pos({
        personal_injuries("R", "V", "ansia"), 
        derive_illness("V") 
    }, {
        beatings("R", "V")
    }, {
        damage("R", "V").
        mental_illness("ansia"). 
        derive("V", "ansia"). 
        harmful_intention("R"). 
    }).

#pos({
        personal_injuries("R", "V", "insonnia"), 
        derive_illness("V")
    }, {
        beatings("R", "V")
    }, {
        damage("R", "V").
        mental_illness("insonnia"). 
        derive("V", "insonnia"). 
        harmful_intention("R"). 
    }).

    
%%% Tribunale Potenza, 06/12/2023, n.1625
#neg({
        personal_injuries("R", "V", "illness"), 
        damage("R", "V"), 
        derive_illness("V")
    }, {
        beatings("R", "V")
    }, {
        uncertain_dynamics("R", "V").
        damage("V", "R").
        harmful_intention("R").
        derive("V", "illness").
        illness("illness").
    }).

% Tribunale Bologna, 20/04/2023, n.1398
#pos({
        personal_injuries("R", "V", "escoriazione"), 
        damage("R", "V")
    }, {

    }, {
        illness("escoriazione").
        derive("V", "escoriazione").
        derive_illness("V").
        punch("R", "V").
        harmful_intention("R").
    }).

% istanziazione predicati non effettuata esternamente, ma all'interno del contesto 

% mode declarations
#modeh(damage(var(agent), var(agent)), (anti_reflexive, positive)).
#modeb(1, hit(var(agent), var(agent)), (anti_reflexive, positive)).
% #modeb(1, substance(const(substance)), (positive)).
#modeb(1, caused_by(var(agent), var(agent), const(substance), var(illness)), (positive)).
#modeb(1, push(var(agent), var(agent)), (anti_reflexive, positive)).
#modeb(1, hands_around_throat(var(agent), var(agent)), (anti_reflexive, positive)).
#modeb(1, minor_bruises(var(agent), var(agent)), (anti_reflexive, positive)).
% #modeb(1, part_of_body(var(agent), const(part)), (anti_reflexive, positive)).
#modeb(1, tug(var(agent), var(agent), const(part)), (positive)).
#modeb(1, slap(var(agent), var(agent)), (anti_reflexive, positive)).
#modeb(1, serious_bruises(var(agent), var(agent)), (anti_reflexive, positive)).
% #modeb(1, assault(var(agent), var(agent)), (anti_reflexive, positive)).
#modeb(1, agitate(var(agent), var(agent)), (anti_reflexive, positive)).
#modeb(1, bite(var(agent), var(agent)), (anti_reflexive, positive)).
#modeb(1, use_object(var(agent), var(agent), const(object)), (positive)).
% #modeb(1, blunt(const(object)), (positive)).
#modeb(1, uncertain_dynamics(var(agent),var(agent)), (anti_reflexive, positive)).
#modeb(1, punch(var(agent), var(agent)), (anti_reflexive, positive)).

% #constant(illness, "lesione cutanea").
% #constant(illness, "irritazione cutanea").
% #constant(illness, "nausea").
% #constant(illness, "conati vomito").
% #constant(illness, "ecchimosi").

#constant(substance, "sostanza urticante").
#constant(substance, "bottiglia di vetro").

#constant(part, "braccio").
#constant(object, "oggetto").
#constant(object, "ago").

#maxv(3).

% Glossario:
% F as felony
% H as harmful substance
% I as illness
% O as object
% R as reo
% T as third part
% V as Victim
