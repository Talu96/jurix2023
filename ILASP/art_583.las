%%%% Art. 583 lesioni personali aggravate 

illness(I) :- physical_illness(I).
illness(I) :- mental_illness(I).

reo(R, "serious_personal_injuries") :- serious_personal_injuries(R, V, I, "lesioni gravi").
victim(V, "serious_personal_injuries") :- serious_personal_injuries(R, V, I, "lesioni gravi").

reo(R, "serious_personal_injuries") :- serious_personal_injuries(R, V, I, "lesioni gravissime").
victim(V, "serious_personal_injuries") :- serious_personal_injuries(R, V, I, "lesioni gravissime").

crime(R, V, "serious_personal_injuries") :- serious_personal_injuries(R, V, I, "lesioni gravi").
crime(R, V, "serious_personal_injuries") :- serious_personal_injuries(R, V, I, "lesioni gravissime").


reo(R, "personal_injuries") :- personal_injuries(R, V, I).
victim(V, "personal_injuries") :- personal_injuries(R, V, I).

reo(R, "attempted_personal_injuries") :- attempted_personal_injuries(R, V, I).
victim(V, "attempted_personal_injuries") :- attempted_personal_injuries(R, V, I).

reo(R, "beatings") :- beatings(R, V).
victim(V, "beatings") :- beatings(R, V).

agent(R) :- reo(R, F). % colui che commette un crimine
agent(V) :- victim(V, F). % la parte lesa

%%% Cassazione penale sez. V, 14/09/2015, n.4272: Il termine "percuotere" previsto dall'art. 581 cod. pen. (reato di percosse) non è assunto 
%%% nel suo significato letterale di battere, colpire, picchiare, ma in quello più lato, comprensivo di ogni violenta manomissione dell'altrui 
%%% persona fisica.
%%% Con damage(R,V) si intende quindi ogni violenta manomissione dell'altrui persona fisica.

personal_injuries(R, V, I) :- damage(R, V), harmful_intention(R), derive_illness(V), derive(V, I), agent(R), agent(V), illness(I), R!=V.

% lego la malattia alla vittima mediante il predicato derive, se presente ne derivo: illness(I) e derive_illness(V)
derive_illness(V) :- derive(V, I), illness(I).
illness(I) :- derive(V, I).

%%%% Art. 581 percosse
%%% Chiunque percuote taluno, se dal fatto non deriva una malattia nel corpo o nella mente, e' punito, a querela della persona offesa, 
%%% salvo che ricorra la circostanza aggravante prevista dall'art. 61, numero 11-octies), con la reclusione fino a sei mesi o con la multa 
%%% fino a 01euro 309.

beatings(R, V) :- damage(R, V), harmful_intention(R), not derive_illness(V), agent(R), agent(V), R!=V.

% Vaghezza contusione: D è il grado delle contusioni (da 1 a 3, contusione più lieve a 1, più grave a 3)

degree(1..3).

1{bruises(R, V, D): degree(D)}1 :- unknown_bruises(R, V).

minor_bruises(R, V) :- bruises(R, V, D), agent(R), agent(V), D=1.
serious_bruises(R, V) :- bruises(R, V, D), agent(R), agent(V), D>1.

degree(D) :- bruises(R,V,D).

% Tribunale Roma, 13/11/1992
attempted_personal_injuries(R,V,I) :- injuries_intention(R), damage(R,V), not derive_illness(V), danger_of_illness(V, I), illness(I), agent(R), agent(V), R!=V.

:- danger_of_illness(V, I), derive_illness(V).

% Cassazione penale sez. V, 14/10/2015, n.6460
attempted_personal_injuries(R,V) :- injuries_intention(R), damage(R,V), interruption(R), illness(I), agent(R), agent(V), R!=V.


% Tribunale Frosinone, 15/04/2022, n.363
:- attempted_personal_injuries(R,V,I), personal_injuries(R,V,I).

:- attempted_crime(R,V,F), crime(R,V,F).

crime(R, V, "personal_injuries") :- personal_injuries(R, V, I).
crime(R, V, "beatings") :- beatings(R, V).
crime(R, V, "theft_snatch") :- theft_snatch(R, V).
crime(R, V, "robbery") :- robbery(R, V).
attempted_crime(R, V, "personal_injuries") :- attempted_personal_injuries(R, V, I).
attempted_crime(R, V, "theft") :- attempted_theft(R, V, C).
attempted_crime(R, V, "theft_snatch") :- attempted_theft_snatch(R, V).
attempted_crime(R, V, "robbery") :- attempted_robbery(R, V).


functionality(F) :- sense(F).
functionality(F) :- limb(F).
functionality(F) :- organ(F).
functionality(F) :- procreate(F).
functionality(F) :- speach(F).

serious_personal_injuries(R, V, I, "lesioni gravi") :- personal_injuries(R, V, I), severity(I, 2).
serious_personal_injuries(R, V, I, "lesioni gravi") :- personal_injuries(R, V, I), weakening(V, F), functionality(F). % W è un senso o un arto.

serious_personal_injuries(R, V, I, "lesioni gravissime") :- personal_injuries(R, V, I), severity(I, 3).
serious_personal_injuries(R, V, I, "lesioni gravissime") :- personal_injuries(R, V, I), loss(V, F), functionality(F).


severity(I, 2) :- serious_personal_injuries(R, V, I, "lesioni gravi").

severity(I, 3) :- serious_personal_injuries(R, V, I, "lesioni gravissime").


% W : può essere senso, arto, organo, capacità di procreare o parlare.


%% La gravità di una malattia è una discriminante per le lesioni (art 582 e 583, gravi e gravissime): illness ha grado 1, dangerous_illness 2, untreatable_illness 3

dangerous_illness(I):- severity(I, 2), illness(I). % malattia che metta in pericolo la vita della persona offesa: una malattia o incapacità di attendere alle ordinarie occupazioni per un tempo superiore ai 40 giorni
untreatable_illness(I) :- severity(I, 3), illness(I). % malattia certamente o probabilmente insanabile


agent("R").
agent("V").

%%% Examples

% Cassazione penale sez. V, 24/04/1987, n.5087
#pos({
        serious_personal_injuries("R", "V", "alterazione psicopatica", "lesioni gravissime")
    },{
        serious_personal_injuries("R", "V", "alterazione psicopatica", "lesioni gravi")
    },{
        harmful_intention("R").
        mental_illness("alterazione psicopatica").
        damage("R", "V").
        derive_illness("V").
        derive("V", "alterazione psicopatica").
        severity("alterazione psicopatica", 3).
    }).

% Cassazione penale sez. IV, 13/10/1988, n.9933
#pos({
        serious_personal_injuries("R", "V", "silicosi", "lesioni gravi"),
        damage("R", "V")
    },{

    },{
        illness("silicosi").
        derive_illness("V").
        derive("V","silicosi").
        harmful_intention("R").
        caused_by("R", "V", "particelle di quarzo", "silicosi").
        substance("particelle di quarzo").
        weakening("V", "organi respiratori").
        organ("organi respiratori").
    }).

% Cassazione penale sez. V, 24/10/1991, n.10644
#pos({
        serious_personal_injuries("R", "V", "perdita milza", "lesioni gravissime")
    },{
        serious_personal_injuries("R", "V", "perdita milza", "lesioni gravi")
    },{
        personal_injuries("R", "V", "perdita milza").
        loss("V", "milza").
        organ("milza").
    }).

% Cassazione penale sez. V, 12/04/1994, n.4130 
#pos({
        serious_personal_injuries("R", "V", "perdita occhio", "lesioni gravi")
    },{
        serious_personal_injuries("R", "V", "perdita occhio", "lesioni gravissime"),
        loss("V","vista"),
        loss("V","occhio")
    },{
        personal_injuries("R", "V", "perdita occhio").
        weakening("V", "vista").
        sense("vista").
        weakening("V", "occhio").
        organ("occhio").
    }).

#pos({
        serious_personal_injuries("R", "V", "perdita rene", "lesioni gravi")
    },{
        serious_personal_injuries("R", "V", "perdita rene", "lesioni gravissime"),
        loss("V","rene")
    },{
        personal_injuries("R", "V", "perdita rene").
        weakening("V", "rene").
        organ("rene").
    }).

#pos({
        serious_personal_injuries("R", "V", "perdita testicolo", "lesioni gravi")
    },{
        serious_personal_injuries("R", "V", "perdita testicolo", "lesioni gravissime"),
        loss("V","testicolo")
    },{
        personal_injuries("R", "V", "perdita testicolo").
        weakening("V", "testicolo").
        organ("testicolo").
    }).

#pos({
        serious_personal_injuries("R", "V", "perdita occhi", "lesioni gravissime")
    },{
        serious_personal_injuries("R", "V", "perdita occhi", "lesioni gravi"),
        weakening("V","occhi")
    },{
        personal_injuries("R", "V", "perdita occhi").
        loss("V", "occhi").
        organ("occhi").
    }).

#pos({
        serious_personal_injuries("R", "V", "perdita reni", "lesioni gravissime")
    },{
        serious_personal_injuries("R", "V", "perdita reni", "lesioni gravi"),
        weakening("V","reni")
    },{
        personal_injuries("R", "V", "perdita reni").
        loss("V", "reni").
        organ("reni").
    }).

#pos({
        serious_personal_injuries("R", "V", "perdita testicoli", "lesioni gravissime")
    },{
        serious_personal_injuries("R", "V", "perdita testicoli", "lesioni gravi"),
        weakening("V","testicoli")
    },{
        personal_injuries("R", "V", "perdita testicoli").
        loss("V", "testicoli").
        procreate("testicoli").
    }).

% Cassazione penale sez. V, 26/06/2013, n.27986
#pos({
        serious_personal_injuries("R", "V", "frattura", "lesioni gravi")
    },{
        serious_personal_injuries("R", "V", "frattura", "lesioni gravissime")
    },{
        illness("frattura").
        derive_illness("V").
        derive("V","frattura").
        harmful_intention("R").
        damage("R", "V").
        weakening("V", "masticazione").
        organ("masticazione").
    }).

% Cassazione penale sez. V, 18/05/2015, n.34390
#pos({
        serious_personal_injuries("R", "V", "acufene", "lesioni gravi")
    },{
        serious_personal_injuries("R", "V", "acufene", "lesioni gravissime")
    },{
        illness("acufene").
        derive_illness("V").
        derive("V","acufene").
        harmful_intention("R").
        damage("R", "V").
        weakening("V", "udito").
        sense("udito").
    }).

% Tribunale Firenze sez. I, 11/03/2016, n.1713
#pos({
        serious_personal_injuries("R", "V", "illness", "lesioni gravi"),
        damage("R", "V")
    },{
        serious_personal_injuries("R", "V", "illness", "lesioni gravissime")
    },{
        illness("illness").
        derive_illness("V").
        derive("V","illness").
        harmful_intention("R").
        avulsion("R", "V", "dente").
        organ("dente").
        weakening("V", "dente").
    }).

% Cassazione penale sez. VI, 19/12/2019, n.7271
#pos({
        serious_personal_injuries("R", "V", "dolenzia", "lesioni gravi")
    },{
        serious_personal_injuries("R", "V", "dolenzia", "lesioni gravissime")
    },{
        illness("dolenzia").
        derive_illness("V").
        derive("V","dolenzia").
        harmful_intention("R").
        damage("R", "V").
        weakening("V", "arto").
        limb("arto").
    }).

% Tribunale Treviso, 18/05/2021, n.149
#pos({
        serious_personal_injuries("R", "V", "illness", "lesioni gravi"),
        damage("R", "V")
    },{
        serious_personal_injuries("R", "V", "illness", "lesioni gravissime")
    },{
        use_object("R", "V", "oggetto").
        blunt("oggetto").
        harmful_intention("R").
        illness("illness").
        derive_illness("V").
        derive("V", "illness").
        weakening("V", "udito").
        sense("udito").
    }).

#pos({
        serious_personal_injuries("R", "V", "illness", "lesioni gravi"),
        damage("R", "V")
    },{
        serious_personal_injuries("R", "V", "illness", "lesioni gravissime")
    },{
        use_object("R", "V", "oggetto").
        blunt("oggetto").
        harmful_intention("R").
        illness("illness").
        derive_illness("V").
        derive("V", "illness").
        weakening("V", "vista").
        sense("vista").
    }).

#pos({
        serious_personal_injuries("R", "V", "illness", "lesioni gravi"),
        damage("R", "V")
    },{
        serious_personal_injuries("R", "V", "illness", "lesioni gravissime")
    },{
        use_object("R", "V", "oggetto").
        blunt("oggetto").
        harmful_intention("R").
        illness("illness").
        derive_illness("V").
        derive("V", "illness").
        weakening("V", "olfatto").
        sense("olfatto").
    }).

#pos({
        serious_personal_injuries("R", "V", "illness", "lesioni gravi"),
        damage("R", "V")
    },{
        serious_personal_injuries("R", "V", "illness", "lesioni gravissime")
    },{
        use_object("R", "V", "oggetto").
        blunt("oggetto").
        harmful_intention("R").
        illness("illness").
        derive_illness("V").
        derive("V", "illness").
        weakening("V", "tatto").
        sense("tatto").
    }).

#pos({
        serious_personal_injuries("R", "V", "illness", "lesioni gravi"),
        damage("R", "V")
    },{
        serious_personal_injuries("R", "V", "illness", "lesioni gravissime")
    },{
        use_object("R", "V", "oggetto").
        blunt("oggetto").
        harmful_intention("R").
        illness("illness").
        derive_illness("V").
        derive("V", "illness").
        weakening("V", "gusto").
        sense("gusto").
    }).

% Tribunale Trieste, 02/02/2022, n.1776
#pos({
        serious_personal_injuries("R", "V", "lussazione", "lesioni gravi")
    },{
        serious_personal_injuries("R", "V", "lussazione", "lesioni gravissime")
    },{
        illness("lussazione").
        derive_illness("V").
        derive("V", "lussazione").
        damage("R", "V").
        weakening("V", "arto").
        limb("arto").
        harmful_intention("R").
    }).

% Tribunale Vicenza, 15/06/2022, n.381
#pos({
        serious_personal_injuries("R", "V", "illness", "lesioni gravi")
    },{
        serious_personal_injuries("R", "V", "illness", "lesioni gravissime")
    },{
        personal_injuries("R", "V", "illness").
        weakening("V", "timpano").
        organ("timpano").
    }).

% Tribunale Trieste, 19/09/2022, n.1443
#pos({
        serious_personal_injuries("R", "V", "lesione", "lesioni gravi"),
        damage("R", "V")
    },{
        serious_personal_injuries("R", "V", "lesione", "lesioni gravissime")
    },{
        severity("lesione", 2).
        illness("lesione").
        derive_illness("V").
        derive("V", "lesione").
        hands_around_throat("R", "V").
        hit("R", "V").
        harmful_intention("R").
    }).

% Cassazione penale sez. V, 23/11/2022, n.6911
#pos({
        serious_personal_injuries("R", "V", "H.I.V.", "lesioni gravissime")
    },{
        serious_personal_injuries("R", "V", "H.I.V.", "lesioni gravi")
    },{
        illness("H.I.V.").
        severity("H.I.V.", 3). % untreatable_illness
        derive_illness("V").
        derive("V", "H.I.V.").
        damage("R", "V").
        harmful_intention("R").
    }).

#neg({
        serious_personal_injuries("R", "V", "illness", "lesioni gravi"), 
        serious_personal_injuries("R", "V", "illness", "lesioni gravissime")
    },{

    },{
        illness("illness").
    }).

#modeh(damage(var(agent), var(agent)), (anti_reflexive)).
% #modeb(1, harmful_intention(var(agent))).
% #modeb(1, illness(const(illness))).
% #modeb(1, derive_illness(var(agent))).
% #modeb(1, derive(var(agent), const(illness)), (anti_reflexive)). 
% #modeb(1, severity(const(illness), const(number))).
#modeb(1, caused_by(var(agent), var(agent), const(substance), const(illness))).
#modeb(1, substance(const(substance))).
% #modeb(1, weakening(var(agent), const(organ)), (anti_reflexive)).
#modeb(1, organ(const(organ))).
#modeb(1, avulsion(var(agent), var(agent), const(organ))).
#modeb(1, use_object(var(agent), var(agent), const(object))).
#modeb(1, blunt(const(object))).
#modeb(1, hands_around_throat(var(agent), var(agent)), (anti_reflexive)).
#modeb(1, hit(var(agent), var(agent)), (anti_reflexive)).


#constant(illness, "silicosi").

#constant(substance, "particelle di quarzo").

#constant(organ, "dente").

#constant(object,"oggetto").


#maxv(2).