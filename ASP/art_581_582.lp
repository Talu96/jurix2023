%%%% Art. 582 lesione personale

%%% Chiunque cagiona ad  alcuno  una  lesione  personale,  dalla  quale deriva una malattia nel  corpo  o  nella  mente,  è punito  con  la 
%%% reclusione da sei mesi a tre anni. 

%%% In entrambe si ha: harmful_intention(R), la distinzione tra le due si trova nella presenza e assenza di malattia rispettivamente 
% in lesioni personali e percosse (riferimenti giuridici: Cass. pen., sent. V, 5 giugno 2019, 25116 , (c.c. 12 febbraio 2019 ); 
% Cass. pen., sent. II, 23 maggio 2019, 22534 , (ud. 21 febbraio 2019 ))

% illness(I): malattia, fisica o mentale, da cui deriva limitazione funzionale o un significativo processo patologico o una compromissione di 
% funzioni dell'organismo (Cassazione penale sez. IV, 19/04/2016, n.22156)
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

%%% Cassazione penale sez. V, 14/09/2015, n.4272: Il termine "percuotere" previsto dall'art. 581 cod. pen. (reato di percosse) non è assunto 
%%% nel suo significato letterale di battere, colpire, picchiare, ma in quello più lato, comprensivo di ogni violenta manomissione dell'altrui 
%%% persona fisica.
%%% Con damage(R,V) si intende quindi ogni violenta manomissione dell'altrui persona fisica.

personal_injuries(R, V, I) :- harmful_intention(R), damage(R, V), derive_illness(V), derive(V, I), illness(I), agent(R), agent(V), R!=V.

% lego la malattia alla vittima mediante il predicato derive, se presente ne derivo: illness(I) e derive_illness(V)
derive_illness(V) :- derive(V, I), illness(I).
illness(I) :- derive(V, I).

%%%% Art. 581 percosse
%%% Chiunque percuote taluno, se dal fatto non deriva una malattia nel corpo o nella mente, e' punito, a querela della persona offesa, 
%%% salvo che ricorra la circostanza aggravante prevista dall'art. 61, numero 11-octies), con la reclusione fino a sei mesi o con la multa 
%%% fino a 01euro 309.

beatings(R, V) :- harmful_intention(R), damage(R, V), not derive_illness(V), agent(R), agent(V), R!=V.

% Vaghezza contusione: D è il grado delle contusioni (da 1 a 3, contusione più lieve a 1, più grave a 3)

degree(1..3).

1{bruises(R, V, D): degree(D)}1 :- unknown_bruises(R, V).

minor_bruises(R, V) :- bruises(R, V, D), agent(R), agent(V), D=1.
serious_bruises(R, V) :- bruises(R, V, D), agent(R), agent(V), D>1.

:- minor_bruises(R, V), personal_injuries(R, V, I).
:- serious_bruises(R, V), beatings(R, V).

degree(D) :- bruises(R, V, D).
