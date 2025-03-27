agent("R").
agent("V").

%%% CODICI IDENTIFICATIVI SENTENZE
%  #1: Cassazione penale sez. II, 12/03/2008, n.15420
%  #2: Cassazione penale, sez. V, 19/01/2010, n. 6371
%  #3: Cassazione penale sez. V, 29/09/2010, n.43763
%  #4: Tribunale Bologna sez. II, 18/03/2013, n.1181
%  #5: Cassazione penale sez. V, 14/06/2013, n.46787
%  #6: Cassazione penale sez. V, 26/06/2013 n. 27990
%  #7: Cassazione penale sez. V, 25/10/2013, n.51393
%  #8: Cassazione penale sez. V, 13/06/2014, n.51085
%  #9: Cassazione penale sez. III, 16/10/2014 n. 43316 
% #10: Cassazione penale sez. V, 18/05/2015, n.34390
% #11: Cassazione penale ord. sez. VII, 31/05/2016, n. 29786
% #12: Tribunale Nola, 11/09/2018, n.1603
% #13: Cassazione penale sez. I, 06/11/2020 n. 31008
% #14: Cassazione penale sez. V, 06/05/2021, n.31665
% #15: Tribunale Rovigo, 14/11/2022, n.707
% #16: Tribunale Bologna, 20/04/2023, n.1398

1{using_judgment("#1")}1 :- illness("contusione escoriata").
1{using_judgment("#1")}1 :- illness("cervicalgia").
2{damage(R, V); using_judgment("#2")}2 :- illness("lesione cutanea"), caused_by(R, V, H, I), substance(H). 
1{using_judgment("#3")}1 :- illness("escoriazione").
2{damage(R, V); using_judgment("#4")}2 :- push(R, V).
2{damage(R, V); using_judgment("#5")}2 :- illness("irritazione cutanea"), illness("nausea"), illness("conati vomito"), caused_by(R, V, H, I), substance(H).
2{damage(R, V); using_judgment("#6")}2 :- hands_around_throat(R, V).
1{using_judgment("#7")}1 :- physical_illness("graffio").
2{damage(R, V); using_judgment("#8")}2 :- tug(R, V, P), part_of_body(V, P), push(R, V), minor_bruises(R, V), not derive_illness(V).
2{damage(R, V); using_judgment("#9")}2 :- slap(R, V), not derive_illness(V).
1{using_judgment("#10")}1 :- physical_illness("acufene").
2{damage(R, V); using_judgment("#11")}2 :- illness("contusione"), serious_bruises(R, V), derive_illness(V), derive(V, "contusione"). 
2{damage(R, V); using_judgment("#12")}2 :- slap(R, V), derive_illness(V).
1{using_judgment("#13")}1 :- illness("ematoma").
2{damage(R, V); using_judgment("#14")}2 :- use_object(R, V, O), blunt(O).
1{using_judgment("#15")}1 :- illness("insonnia"), illness("ansia").
2{damage(R, V); using_judgment("#16")}2 :- punch(R, V).

%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 1  --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Tribunale Roma, 13/11/1992: Integra il delitto di tentate lesioni personali gravissime (pericolo di causazione di una 
%%%% malattia certamente o probabilmente insanabile) e non quello di tentato omicidio, il fatto 
%%%% del tossicodipendente, certamente affetto da H.I.V., il quale colpisca un altro soggetto, 
%%%% conficcandogli l'ago nella mano, con la siringa appena utilizzata per assumere sostanza stupefacente.

% injuries_intention("R").
% illness("H.I.V.").
% severity("H.I.V.", 3).
% hit("R", "V").
% use_object("R", "V", "ago").
% danger_of_illness("V", "H.I.V.").
% :- derive_illness("V"). % si può omettere
% damage(R, V) :- hit(R, V), use_object(R, V, O).



%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 2 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Cassazione penale sez. II, 12/03/2008, n.15420: Ricorre il delitto di lesioni, e non già quello meno grave di percosse, 
%%%% sia in caso di contusione escoriata che di cervicalgia, rientrando entrambe nella nozione di "malattia".

% physical_illness("contusione escoriata").
% physical_illness("cervicalgia").
% derive_illness("V").
% derive("V", "cervicalgia").
% derive("V", "contusione escoriata").
% harmful_intention("R").
% damage("R", "V").

%%% anche in "Cassazione penale sez. V, 18/05/2015, n.34387: in tema di lesioni personali, integra la malattia di cui all'art
%%% 582 c.p. la "cervicalgia" in quanto "dolore cervicale" localizzato nella parte posteriore del collo, che determina
%%% sofferenza e ridotta motilità del collo e della testa e, quindi, una alterazione funzionale dell'organismo.


%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 3 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Cass. pen., sent. V, 19 gennaio 2010, n. 6371: la lesione cutanea provocata da una sostanza 
%%%% urticante costituisce malattia e configura, pertanto, una lesione personale ex art. 582 c.p.

% physical_illness("lesione cutanea").
% caused_by("R", "V", "sostanza urticante", "lesione cutanea").
% substance("sostanza urticante").
% derive_illness("V").
% derive("V", "lesione cutanea").
% harmful_intention("R").



%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 4 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Cassazione penale sez. V, 29/09/2010, n.43763: In tema di lesioni personali, costituisce "malattia" qualsiasi 
%%%% alterazione anatomica o funzionale dell'organismo, ancorché localizzata, di lieve entità e non influente sulle 
%%%% condizioni organiche generali, onde lo stato di malattia perdura fino a quando sia in atto il suddetto processo di alterazione. 
%%%% (Fattispecie relativa ad escoriazioni).

% physical_illness("escoriazione").
% derive_illness("V").
% derive("V", "escoriazione").
% harmful_intention("R").
% damage("R", "V").



%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 5 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Tribunale Torino sez. uff. indagini prel., 07/04/2011: Cagionare delle semplici abrasioni della cute integra 
%%%% il reato di lesioni personali poiché consistono in qualsiasi alterazione anatomofunzionale

% physical_illness("abrasione").
% derive_illness("V").
% derive("V", "abrasione").
% harmful_intention("R").
% damage("R", "V").



%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 6 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Tribunale Bologna sez. II, 18/03/2013, n.1181: Integra il reato di percosse ex art. 581 c.p., 
%%%% la condotta di colui che colpisca la persona offesa ripetutamente sulla spalla al fine di spintonarla fuori da un negozio, 
%%%% considerato che il termine percuotere non è assunto nell'art. 581 c.p. nel solo significato di battere, colpire, picchiare ma 
%%%% anche in quello più lato, comprensivo di ogni violenza o manomissione dell'altrui persona fisica, con la conseguenza che in tale
%%%% ambito previsionale rientra anche la spinta, la quale si concreta in un'energia fisica esercitata con violenza e direttamente 
%%%% sulla persona. Né, ai fini dell'integrazione del reato "de quo", occorre che vi sia prova del dolore sofferto dalla persona offesa.

% push("R", "V").
% harmful_intention("R").



%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 7 --------- %%%%%%%%%%%%%%%%%%%%%%%
%%%% Cassazione penale sez. V, 14/06/2013, n.46787: In tema di lesioni personali, integrano la malattia di cui all'art. 
%%%% 582 c.p. gli effetti derivanti dal getto sul viso di gas urticante consistenti non soltanto in una irritazione cutanea 
%%%% prolungata, ma anche in fenomeni di nausea e conati di vomito accompagnati da senso di soffocamento, in quanto produttivi 
%%%% di alterazioni funzionali dell'organismo.

% caused_by("R", "V", "gas urticante", "irritazione cutanea").
% caused_by("R", "V", "gas urticante", "nausea").
% caused_by("R", "V", "gas urticante", "conato vomito").
% substance("gas urticante").
% physical_illness("irritazione cutanea").
% physical_illness("nausea").
% physical_illness("conato vomito").
% illness("soffocamento").
% derive_illness("V").
% derive("V", "irritazione cutanea").
% derive("V", "nausea").
% derive("V", "conato vomito").
% harmful_intention("R").



%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 8 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Cassazione penale sez. V, 26/06/2013 n. 27990: cingere le mani intorno al collo costituisce esempio di percosse 
%%%% nel portare le mani al collo della vittima, l'imputato avesse stretto in maniera sufficiente a recare una violenza 
%%%% fisica, così da integrare il delitto di percosse, pur senza cagionare una malattia.

% hands_around_throat("R", "V").
% harmful_intention("R").



%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 9 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Cassazione penale sez. V, 25/10/2013, n.51393: Ai fini della configurazione della nozione di "malattia", rilevante ai fini della 
%%%% sussistenza del reato di lesione personale di cui all'art. 582 c.p., è sufficiente qualsiasi alterazione anatomica o funzionale
%%%% dell'organismo, ancorché localizzata, di lieve entità e non influente sulle condizioni organiche generali, onde lo stato di malattia 
%%%% perdura fino a quando sia in atto il suddetto processo di alterazione (nella specie, la Corte ha ritenuto incongrua e giuridicamente 
%%%% erronea l'affermazione secondo la quale il graffio riportato dalla vittima nell'ambito di una lite non fosse qualificabile come lesione) 

% physical_illness("graffio").
% derive_illness("V").
% derive("V", "graffio").
% harmful_intention("R").
% damage("R", "V").



%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 10 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Cassazione penale sez. V, 13/06/2014, n.51085: Integra il reato di percosse la condotta di 
%%%% colui che strattona per un braccio la persona offesa, spingendola contro un muro in modo da procurarle lievi contusioni, 
%%%% considerato che il termine percuotere non è assunto nell'art. 581 c.p. nel solo significato di battere, colpire, picchiare, ma anche in %%%% quello più lato, comprensivo di ogni violenta manomissione dell'altrui persona fisica.

% part_of_body("V", "braccio").
% tug("R", "V", "braccio").
% push("R", "V").
% minor_bruises("R", "V").
% :- derive_illness("V"). %%% non serve
% harmful_intention("R").



%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 11 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Corte di cassazione penale, sez. III, 16 ottobre 2014 n. 43316: nella nozione di "percosse" rientrano anche gli schiaffi, 
%%%% in quanto intrinsecamente caratterizzati da energia fisica esercitata con violenza e direttamente sulla persona, 
%%%% purché non siano produttivi di malattia  (ricadendosi in tal caso nel reato di lesioni) o non manifestino una 
%%%% violenza di entità inavvertibile e simbolica, indice dell'esclusivo proposito di arrecare sofferenza morale o 
%%%% disprezzo (in tale ipotesi configurandosi il reato di ingiuria)

% slap("R", "V").
% :- derive_illness("V"). %%%% non serve
% harmful_intention("R").



%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 12 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Tribunale Nola, 22/04/2015, n.795: In tema di lesioni personali (art. 582 c.p.), ai fini del perfezionamento del delitto, 
%%%% il concetto di malattia deve essere inteso come comprensivo di qualsivoglia alterazione, anatomica o funzionale, dell'organismo, 
%%%% ancorché lieve e circoscritta, che comporti un processo di reintegrazione, sia pure di breve durata, della salute della vittima. 
%%%% (Nella specie, le lesioni consistevano in traumi, contusioni multiple ed escoriazioni).

% physical_illness("trauma").
% physical_illness("contusione").
% physical_illness("escoriazione").
% derive_illness("V").
% derive("V", "trauma").
% derive("V", "contusione").
% derive("V", "escoriazione").
% harmful_intention("R").
% damage("R", "V").



%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 13 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Cassazione penale sez. V, 18/05/2015, n.34390: In tema di lesioni personali, integra la malattia di cui all'art. 582
%%%% c.p. l'acufene, in quanto disturbo caratterizzato dalla percezione di suoni non legati a stimoli esterni e, come tale,
%%%% determinativo di un'alterazione funzionale dell'organismo

% physical_illness("acufene").
% derive_illness("V").
% derive("V", "acufene").
% harmful_intention("R").
% damage("R", "V").



%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 14 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Cassazione penale sez. V, 14/10/2015, n.6460: È configurabile la figura del delitto circostanziato tentato 
%%%% anche alle ipotesi aggravate in cui la circostanza non si sia interamente realizzata solo per fattori estranei 
%%%% alla volontà dell'agente ma risulti dalle modalità del fatto che si sarebbe realizzata nel più grave esito 
%%%% preordinato. (Fattispecie in cui l'imputato è stato condannato per il reato di maltrattamenti e tentate lesioni 
%%%% gravissime nei confronti della moglie, alla quale durante l'azione delittuosa diceva «ti rovino la faccia così 
%%%% non ti guarda più nessuno», facendo uso di un taglierino per unghie).

% interruption("R").
% damage("R", "V").
% danger_of_illness("V", "illness").
% illness("illness").
% severity("illness", 3).
% injuries_intention("R").
% threat("R", "V").



%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 15 --------- %%%%%%%%%%%%%%%%%%%%%% 
%%%% Cassazione penale ord. sez. VII, 31/05/2016, n. 29786
%%%% La contusione, in quanto alterazione anatomica e funzionale dell'organismo, 
%%%% costituisce malattia ai sensi dell'art. 582 c.p.

% physical_illness("contusione").
% derive_illness("V").
% derive("V", "contusione").
% serious_bruises("R", "V").
% harmful_intention("R").
% damage("R", "V").



%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 16 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Corte appello Torino sez. I, 28/03/2018, n.2349: La contusione ricevuta a seguito di un’aggressione integra 
%%%% il reato di lesioni personali in quanto è un’ alterazione anatomica funzionale dell’organismo. 
%%%% (Nel caso di specie, l’imputato, al quale il carabiniere voleva notificare un ordine di carcerazione, 
%%%% reagiva cagionando al Carabiniere lesioni consistite in un trauma sternale guaribile in giorni cinque).

% assault("R", "V").
% physical_illness("trauma sternale").
% physical_illness("contusione"):- physical_illness("trauma sternale").
% serious_bruises("R", "V").
% derive_illness("V").
% derive("V", "contusione").
% harmful_intention("R").



%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 17 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Tribunale Bari sez. I, 22/05/2018, n.2400: Rilevano in tal senso anche le alterazioni lievi della integrità fisica della persona, 
%%%% comprese le ecchimosi, risultato di una rottura dei vasi sanguigni e di un'infiltrazione di sangue nel tessuto sottostante l'epidermide. 
%%%% Nel caso di specie, il Tribunale ha riconosciuto la sussistenza di una malattia rilevante in tal senso, posto che la vittima era stata 
%%%% ripetutamente e violentemente colpita dall'imputato al capo con una bottiglia di vetro, riportando svariate ferite da taglio.

% physical_illness("ecchimosi").
% caused_by("R", "V", "bottiglia di vetro", "ecchimosi").
% substance("bottiglia di vetro").
% derive_illness("V").
% derive("V", "ecchimosi").
% harmful_intention("R").
% damage("R", "V").



%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 18 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Tribunale Torre Annunziata, 30/07/2018, n.1997: Commette il delitto di lesioni personali chi aizzi il proprio cane 
%%%% ad azzannare un’altra persona provocandole lesioni
%%%% Integra il delitto di cui all’art. 582 c.p. la condotta dell’imputato consistita nell’aizzare il proprio cane ad 
%%%% azzannare un’altra persona che abbia riportato, a seguito dei morsi ricevuti, lesioni personali.

% agitate("R", "cane").
% bite("cane", "V").
% derive("V", "lesione").
% illness("lesione").
% derive_illness("V").
% agent("cane").
% damage(R, V) :- agitate(R, T), bite(T, V), agent(T), V!=R, R!=T, V!=T.
% harmful_intention("R").


%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 19 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Tribunale Nola, 11/09/2018, n.1603: Schiaffeggiare il partner provocandogli lesioni personali 
%%%% integra il reato di lesioni dolose. Integra il reato di lesioni dolose costringere la ex fidanzata scendere dall’auto e colpirla con uno 
%%%% schiaffo all’altezza dell’orecchio o provocandole lesioni personali. (Nel caso di specie si trattava di un otorragia traumatica con  
%%%% perforazione timpanica).

% slap("R", "V").
% derive_illness("V").
% derive("V", "otorragia"). % dove con "otorragia" si intende "otorragia traumatica con perforazione timpanica"
% illness("otorragia").
% harmful_intention("R").



%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 20 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Corte appello Ancona, 09/09/2019, n.949: Nella fattispecie, la Corte d'appello ha rigettato il gravame dell'imputato, 
%%%% già condannato in primo grado per il reato ex art. 582 c.p. per aver colpito l'ex moglie e il suo compagno provocando 
%%%% loro traumi e distorsioni lievi; per i giudici tali conseguenze dell'aggressione depongono inequivocabilmente a favore 
%%%% della configurabilità del reato di lesioni e non di quello di percosse.

% hit("R", "V").
% agent("compagno v").
% hit("R", "compagno v").
% damage("R", "compagno v").
% physical_illness("trauma con distorsione").
% derive_illness("V").
% derive_illness("compagno v").
% derive("V", "trauma con distorsione").
% derive("compagno v", "trauma con distorsione").
% harmful_intention("R").
% damage("R", "V").


%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 21 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Corte di cassazione penale, sez. I, 6 novembre 2020 n. 31008: Il semplice 
%%%% ematoma è di per sé sintomo di malattia del corpo e rientra nelle lesioni
%%%% In tema di lesioni personali, l'ematoma rientra nella nozione di "malattia" 
%%%% in quanto consiste in un versamento ematico nei tessuti sottocutanei che 
%%%% comporta un'alterazione anatomica alla quale segue un naturale processo 
%%%% riabilitativo. (Conf. Sez. 1, n. 11000 del 1978, Rv. 139944). 

% physical_illness("ematoma").
% derive_illness("V").
% derive("V", "ematoma").
% harmful_intention("R").
% damage("R", "V").



%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 22 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Cassazione penale sez. V, 06/05/2021, n.31665: Il reato di percosse si configura 
%%%% anche se il contatto fra agente e vittima è mediato dall'uso di oggetto contundente
%%%% Ai fini della configurabilità del reato di percosse, la condotta di violenta manomissione 
%%%% dell'altrui persona richiede un contatto fisico tra l'agente e la vittima, ancorché mediato 
%%%% dall'uso di un oggetto contundente.

% use_object("R", "V", "oggetto").
% blunt("oggetto").
% harmful_intention("R").



%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 23 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Tribunale Rovigo, 14/11/2022, n.707: Le lesioni personali sono integrate 
%%%% anche in caso di malattia della mente come uno stato di ansia prolungato e insonnia
%%%% È integrato il reato di lesioni personali di cui all'art. 582 c.p., quando dalla condotta minacciosa 
%%%% ed aggressiva del soggetto agente nella vittima sia derivato uno stato di ansia caratterizzato da disturbi 
%%%% del sonno per un periodo prolungato, essendo stata prodotta una malattia della mente nella vittima.

% mental_illness("insonnia").  % disturbi del sonno
% mental_illness("ansia"). % stato di ansia per un periodo prolungato
% derive_illness("V").
% derive("V", "insonnia").
% derive("V", "ansia").
% harmful_intention("R").
% damage("R", "V").



%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 24 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Tribunale Potenza, 06/12/2023, n.1625: Non può esserci condanna per lesioni personali se non c'è certezza sulla dinamica 
%%%% e vi sia stata reciprocità dei colpi
%%%% Non può esserci condanna per lesioni personali nel caso in cui in sede dibattimentale la dinamica dei fatti non abbia 
%%%% una ricostruzione chiara, ma sia emersa una reciprocità dei colpi inferti e dell'aggressività manifestata.

% uncertain_dynamics("R", "V").
% damage("V", "R").
% damage("R", "V").
% :- uncertain_dynamics(R, V), damage(V, R), personal_injuries(R, V, I).



%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 25 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Tribunale Napoli sez. III, 13/01/2022, n.259: Lesioni personali a seguito di minacce per rapina.
%%%% Integra il reato di lesioni personali la condotta del prevenuto che al fine di porre in essere una rapina abbia 
%%%% minacciato la persona offesa di arrecare un danno al di lei figlio di tenera età, provocando nella vittima una malattia 
%%%% della mente accertata da un certificato medico, inquadrata in uno stato di ansia post traumatico da aggressione guaribile 
%%%% in dieci giorni, unitamente alle lesioni scaturite dalla colluttazione nata a seguito della minaccia.

% theft_intention("R").
% physical_object("oggetto").
% own("V", "oggetto").
% subtract("R", "oggetto").
% take_possession("R", "oggetto").
% threat("R", "V").
% foreshadowing_violence("R").
% damage("R", "V").
% mental_illness("ansia").
% derive("V", "ansia").
% derive_illness("V").

%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 26 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Tribunale Bologna, 20/04/2023, n.1398: In tema di lesioni personali, il reato risulta 
%%%% provato nella sua materialità, nell'ipotesi di condotta consistita in un pugno al volto, 
%%%% con conseguente escoriazione del labbro da cui è derivata una malattia del corpo 
%%%% guaribile in giorni 6. La condotta, invero, integra perfettamente la fattispecie di 
%%%% lesioni personali.

% illness("escoriazione").
% derive("V", "escoriazione").
% derive_illness("V").
% punch("R", "V").
% harmful_intention("R").