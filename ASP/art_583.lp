%%%% Art. 583 lesioni personali aggravate 

illness(I) :- physical_illness(I).
illness(I) :- mental_illness(I).

reo(R, "serious_personal_injuries") :- serious_personal_injuries(R, V, I, "lesioni gravi").
victim(V, "serious_personal_injuries") :- serious_personal_injuries(R, V, I, "lesioni gravi").

reo(R, "serious_personal_injuries") :- serious_personal_injuries(R, V, I, "lesioni gravissime").
victim(V, "serious_personal_injuries") :- serious_personal_injuries(R, V, I, "lesioni gravissime").

crime(R, V, "serious_personal_injuries") :- serious_personal_injuries(R, V, I, "lesioni gravi").
crime(R, V, "serious_personal_injuries") :- serious_personal_injuries(R, V, I, "lesioni gravissime").

functionality(F) :- sense(F).
functionality(F) :- limb(F).
functionality(F) :- organ(F).
functionality(F) :- procreate(F).
functionality(F) :- speach(F).

serious_personal_injuries(R, V, I, "lesioni gravi") :- personal_injuries(R, V, I), severity(I, 2).
serious_personal_injuries(R, V, I, "lesioni gravi") :- personal_injuries(R, V, I), weakening(V, F), functionality(F).

serious_personal_injuries(R, V, I, "lesioni gravissime") :- personal_injuries(R, V, I), severity(I, 3).
serious_personal_injuries(R, V, I, "lesioni gravissime") :- personal_injuries(R, V, I), loss(V, F), functionality(F).


severity(I, 2) :- serious_personal_injuries(R, V, I, "lesioni gravi").

severity(I, 3) :- serious_personal_injuries(R, V, I, "lesioni gravissime").

%% La gravità di una malattia è una discriminante per le lesioni (art 582 e 583, gravi e gravissime): illness ha grado 1, dangerous_illness 2, untreatable_illness 3

dangerous_illness(I):- severity(I, 2), illness(I). % malattia che metta in pericolo la vita della persona offesa: una malattia o incapacità di attendere alle ordinarie occupazioni per un tempo superiore ai 40 giorni
untreatable_illness(I) :- severity(I, 3), illness(I). % malattia certamente o probabilmente insanabile


agent("R").
agent("V").

%%% CODICI IDENTIFICATIVI SENTENZE
%  #1: Cassazione penale sez. IV, 13/10/1988, n.9933
%  #2: Tribunale Firenze sez. I, 11/03/2016, n.1713

2{damage(R, V); using_judgment("#1")}2 :- illness("silicosi"), caused_by(R, V, H, I), substance(H).
2{damage(R, V); using_judgment("#2")}2 :- avulsion(R, V, F), organ(F).

%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 1 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Cassazione penale, Sez. V, sentenza n. 5087 del 24 aprile 1987
%%%% Qualora a seguito di un’aggressione, la vittima riporti una alterazione psicopatica che è in rapporto diretto di 
%%%% causalità con la condotta dell’agente, questi risponde di lesioni personali aggravate se la malattia derivata da esse 
%%%% presenta un carattere insanabile, a nulla rilevando i preesistenti stati patologici della vittima, allorché sia 
%%%% accertato che il trauma ad essa inferto abbia posto in luce tale preesistente patologia. In tale ipotesi non può 
%%%% dirsi che l’azione criminosa sia solo occasione delle gravi conseguenze manifestatesi, ma deve ritenersene sicuro 
%%%% il contributo causale.

% harmful_intention("R").
% mental_illness("alterazione psicopatica").
% derive_illness("V").
% derive("V", "alterazione psicopatica").
% damage("R", "V").
% severity("alterazione psicopatica", 3).

%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 2 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Cassazione penale, Sez. IV, sentenza n. 9933 del 13 ottobre 1988
%%%% In tema di malattie professionali, la contrazione della malattia denominata silicosi, ritenuta sicuramente sclerogena 
%%%% in conseguenza alla prolungata esposizione in ambiente di lavoro inquinato da polveri aereodiffuse contenenti 
%%%% particelle di quarzo, comportando una grave compromissione degli organi deputati alla funzione respiratoria, integra 
%%%% l’aggravante dell’indebolimento permanente di un senso o di un organo (di cui all’art. 583, primo comma, n. 2, c.p.).

% illness("silicosi").
% derive_illness("V").
% derive("V","silicosi").
% harmful_intention("R").
% caused_by("R", "V", "particelle di quarzo", "silicosi").
% substance("particelle di quarzo").
% weakening("V", "organi respiratori").
% organ("organi respiratori").

%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 3 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Cassazione penale, Sez. V, sentenza n. 10644 del 24 ottobre 1991
%%%% La totale perdita della milza costituisce non già indebolimento del sistema reticolo-endoteliare, ma perdita dell’uso 
%%%% di un organo, che integra l’ipotesi di lesione gravissima prevista dall’art. 583, secondo comma, n. 2, c.p., e ciò 
%%%% perché le numerose funzioni cui assolve la milza, sebbene tutte perfettamente compensabili, non possono tuttavia 
%%%% ritenersi propriamente vicariate, nella loro entità globale, da singole attività svolte separatamente da organi diversi.

% personal_injuries("R", "V", "perdita milza").
% loss("V", "milza").
% organ("milza").

%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 4 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Cassazione penale, Sez. V, sentenza n. 4130 del 12 aprile 1994
%%%% In tema di lesioni personali, la perdita dell’uso (art. 583, comma 2, n. 2, c.p.) per gli organi a costituenti 
%%%% plurimi o a funzione similare si verifica solo quando tutti gli elementi che li compongono siano perduti, mentre 
%%%% la perdita di una sola parte comporta effetti che variano dall’irrilevanza all’indebolimento permanente (art. 583, 
%%%% comma 1, n. 2, c.p.). Pertanto, la perdita di un occhio, risolvendosi nella perdita di un organo geminato (esempio 
%%%% rene, testicolo), configura l’aggravante dell’indebolimento permanente e non quella della perdita dell’uso di organo.

% personal_injuries("R", "V", "perdita occhio").
% weakening("V", "vista").
% sense("vista").
% weakening("V", "occhio").
% organ("occhio").

:- loss("V", "vista"), personal_injuries("R", "V", "perdita occhio").
:- loss("V", "occhio"), personal_injuries("R", "V", "perdita occhio").

% personal_injuries("R", "V", "perdita rene").
% weakening("V", "rene").
% organ("rene").

:- loss("V", "rene"), personal_injuries("R", "V", "perdita rene").

% personal_injuries("R", "V", "perdita testicolo").
% weakening("V", "testicolo").
% organ("testicolo").

:- loss("V", "testicolo"), personal_injuries("R", "V", "perdita testicolo").

% personal_injuries("R", "V", "perdita occhi").
% loss("V", "occhi").
% organ("occhi").

% personal_injuries("R", "V", "perdita reni").
% loss("V", "reni").
% organ("reni").

% personal_injuries("R", "V", "perdita testicoli").
% loss("V", "testicoli").
% procreate("testicoli").

%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 5 --------- %%%%%%%%%%%%%%%%%%%%%%
%%% Cassazione penale, Sez. V, sentenza n. 27986 del 26 giugno 2013: In tema di lesioni personali, anche una menomazione 
%%% minima, purché apprezzabile di un organo integra l’aggravante di cui all’art. 583, comma primo, n. 2, c.p.. 
%%% (Fattispecie in cui la Corte ha ritenuto sussistente l’aggravante in presenza di plurime fratture dentarie da cui 
%%% era derivato un indebolimento permanente dell’organo della masticazione).

% illness("frattura").
% derive_illness("V").
% derive("V","frattura").
% harmful_intention("R").
% damage("R", "V").
% weakening("V", "masticazione").
% organ("masticazione").

%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 6 --------- %%%%%%%%%%%%%%%%%%%%%%
%%% Cassazione penale sez. V, 18/05/2015, n.34390: l'acufene, o tinnitus, è un disturbo caratterizzato dalla percezione
%%% di suoni non legati a stimoli esterni. [...] Allorché l'affezione sia conseguente a traumi prodotti dall'azione 
%%% dell'uomo essa può rientrare nel concetto di malattia rilevante ai sensi degli artt. 582 e 583 c.p. comportando
%%% nei casi più gravi - un indebolimento dell'udito, compromesso dalla percezione di rumori endogeni conseguenti
%%% alla provocata alterazione anatomica.

% illness("acufene").
% derive_illness("V").
% derive("V","acufene").
% harmful_intention("R").
% damage("R", "V").
% weakening("V", "udito").
% sense("udito").

%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 7 --------- %%%%%%%%%%%%%%%%%%%%%%
%%% Tribunale Firenze sez. I, 11/03/2016, n.1713: integra lesione personale anche la mera avulsione di un dente
%%% integra la fattispecie di cui all'art. 583, comma 1 n. 2, c.p. anche l'avulsione di un solo dente incisivo
%%% dovendosi far riferimento alla naturale funzionalità dell'organo

% illness("illness").
% derive_illness("V").
% derive("V","illness").
% harmful_intention("R").
% avulsion("R", "V", "dente").
% organ("dente").
% weakening("V", "dente").

%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 8 --------- %%%%%%%%%%%%%%%%%%%%%%
%%% Cassazione penale sez. VI, 19/12/2019, n.7271: Il reato di lesioni è aggravato dall'indebolimento permanente di un organo
%%% se risulta menomato nella sua potenzialità funzionale.
%%% Fattispecie in cui la Corte ha ritenuto sussistente la circostanza in un caso nel quale la dolenzia causata alla vittima
%%% dal movimento dell'arto lesionato, specie durante la flessione, ne menomava la funzione statico-deambulatoria, rendendo
%%% più difficoltosi e dolorosi i movimenti

% illness("dolenzia").
% derive_illness("V").
% derive("V","dolenzia").
% harmful_intention("R").
% damage("R", "V").
% weakening("V", "arto").
% limb("arto").

%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 9 --------- %%%%%%%%%%%%%%%%%%%%%%
%%% Tribunale Treviso, 18/05/2021, n.149: Lesioni personali aggravate dall'indebolimento permanente di un senso.
%%% Il reato di lesioni perpetrato nei confronti della vittima mediante calci, pugni ed oggetti contundenti è da 
%%% ritenersi aggravato ai sensi dell'art. 583 c.p. comma 1 nel caso in cui alla p.o. siano derivate lesioni gravi 
%%% con indebolimento permanente di un senso.

% use_object("R", "V", "oggetto").
% blunt("oggetto").
% harmful_intention("R").
% illness("illness").
% derive_illness("V").
% derive("V", "illness").

% weakening("V", "udito").
% sense("udito").

% weakening("V", "vista").
% sense("vista").

% weakening("V", "olfatto").
% sense("olfatto").

% weakening("V", "tatto").
% sense("tatto").

% weakening("V", "gusto").
% sense("gusto").

%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 10 --------- %%%%%%%%%%%%%%%%%%%%%%
%%% Tribunale Trieste, 02/02/2022, n.1776: Lesioni personali: aggravanti, casistica
%%% In tema di lesioni personali, sussiste l'aggravante di cui all'art. 583 comma 1 n. 1 c.p. quando le lesioni cagionate 
%%% dall'aggressione perpetrata ai danni della vittima, pur non avendone determinato un rischio per la vita, ne abbiano 
%%% comportato un indebolimento permanente
%%% Nel caso di specie la vittima a seguito dell'aggressione subita da due soggetti riportava una lussazione che 
%%% determinava un indebolimento permanente di un arto.

% illness("lussazione").
% derive_illness("V").
% derive("V", "lussazione").
% damage("R", "V").
% weakening("V", "arto").
% limb("arto").
% harmful_intention("R").

%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 11 --------- %%%%%%%%%%%%%%%%%%%%%%
%%% Tribunale Vicenza, 15/06/2022, n.381: In tema di lesioni personali, sussiste l'aggravante dell'indebolimento 
%%% permanente di un organo qualora, in conseguenza del fatto lesivo, qualora esso risulti menomato nella sua potenzialità
%%% funzionale. Sussiste, dunque, la piena configurazione dell'aggravante, laddove la persona offesa 
%%% abbia riportato una ridotta funzionalità del timpano sinistro in maniera, seppur lieve, irreversibile.

% personal_injuries("R", "V", "illness").
% weakening("V", "timpano").
% organ("timpano").

%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 12 --------- %%%%%%%%%%%%%%%%%%%%%%
%%% Tribunale Trieste, 19/09/2022, n.1443: Lesioni personali gravi con incapacità di attendere alle ordinarie occupazioni 
%%% per oltre 40 gg. Incorrono nell'imputazione per il reato p. e p. dagli artt. 582 e 583 comma c.p. i prevenuti che in 
%%% concorso di volontà e/o azione tra di loro, con più azioni esecutive di un medesimo disegno criminoso, cagionavano 
%%% lesioni personali ad un'altra persona, dapprima aggredendola afferrandolo al collo e colpendolo con un pugno al viso e
%%% poi scagliandosi contro un altro soggetto intervenuto per soccorrere la p.o. cagionando loro lesioni gravi con incapacità 
%%% di attendere alle ordinarie occupazioni per oltre 40 gg.

% severity("lesione", 2).
% illness("lesione").
% derive_illness("V").
% derive("V", "lesione").
% hands_around_throat("R", "V").
% hit("R", "V").
% harmful_intention("R").

%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 13 --------- %%%%%%%%%%%%%%%%%%%%%%
%%% Cassazione penale sez. V, 23/11/2022, n.6911: confermata, nella specie, la condanna dell'imputato per il delitto di 
%%% lesioni personali gravissime, avendo egli consumato ripetuti rapporti sessuali non protetti con il compagno nell'arco 
%%% di dieci anni, con la consapevolezza di essere affetto da virus HIV e sottacendo tale circostanza al partner e accettando, 
%%% in tal modo, il rischio del contagio e delle conseguenti lesioni personali per il partner

% illness("H.I.V.").
% severity("H.I.V.", 3). % untreatable_illness
% derive_illness("V").
% derive("V", "H.I.V.").
% damage("R", "V").
% harmful_intention("R").
