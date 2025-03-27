agent("R").
agent("V").

%%%% Regole generali
blamed_for("manslaughter") :- manslaughter(R, V), personal_injuries(R, V, I).
blamed_for("manslaughter") :- manslaughter(R, V), beatings(R, V).
blamed_for("robbery") :- robbery(R, V), beatings(R, V), not manslaughter(R, V).


%%% CODICI IDENTIFICATIVI SENTENZE ARTT. 575 - 579
%  #1: Cassazione penale, sez. I, 05/10/2017, n. 56701
%  #2: Cassazione penale, sez. I, 22/12/2017, n. 3619
%  #3: Cassazione penale, sez. I, 29/01/2019, n. 16116
%  #4: Tribunale Taranto sez. II, 14/10/2020, n. 795
%  #5: Corte appello Ancona, 17/02/2021, n. 1604
%  #6: Cassazione penale, sez. I, 30/03/2022, n. 29611
%  #7: Cassazione penale, sez. I, 05/04/2022, n. 24173
%  #8: Cassazione penale, sez. I, 21/07/2022, n. 40819
%  #9: Cassazione penale, sez. I, sent., 23/12/2022 n. 48944
% #10: Corte appello Ancona, 23/01/2023, n.2104
% #11: Cassazione penale sez. I, 19/06/2023 n. 26316
% #12: Tribunale Lecce sez. I, 13/07/2023, n.2529
% #13: Corte assise Roma, 10/12/1983
% #14: Corte assise Trieste, 02/05/1988

2{aware_of_consequences(R); using_judgment("#1")}2 :- robbery(R, V), bind(R, V), gag(R, V).
2{death_intention(R); using_judgment("#1")}2 :- aware_of_consequences(R).
2{aware_of_consequences(R); using_judgment("#2")}2 :- robbery(R, V), obstruct(R, V, "naso"), obstruct(R, V, "bocca").
3{death_intention(R); damage(R, V); using_judgment("#3")}3:- stab(R, V), number_of_wounds(V, 11).
3{death_intention(R); damage(R, V); using_judgment("#4")}3 :- use_object(R, V, "arma da fuoco"), shoot(R, V, "volto", 5), number_of_shots(V, 5).
2{death_intention(R); using_judgment("#5")}2 :- stab_body(R, V, "addome"), part_of_body(V, "addome"), violence(R, V).
3{death_intention(R); damage(R, V); using_judgment("#6")}3 :- throw(R, V, "sasso"), go_through(V, "auto").
3{death_intention(R); damage(R, V); using_judgment("#7")}3 :- stab_body(R, V, "zona orbitale"), part_of_body(V, "zona orbitale").
2{death_intention(R); using_judgment("#8")}2 :- robbery(R, V), use_object(R, V, "arma da fuoco").
2{murder(R, V); using_judgment("#9")}2 :- administer(R, V, N), medicine(N), cause_death(R, V).
2{damage(R, V); using_judgment("#10")}2 :- stab(R, V).
2{death_intention(R); using_judgment("#11")}2 :- caused_by(R, V, "alcol denaturato", "ustione"), substance("alcol denaturato").
3{death_intention(R); damage(R, V); using_judgment("#12")}3 :- stab_body(R, V, "organi vitali"), part_of_body(V, "organi vitali").
2{handicap(V); using_judgment("#13")}2 :- has_illness(V, "idrocefalo congenito"), illness("idrocefalo congenito").
2{handicap(V); using_judgment("#14")}2 :- has_illness(V, "affezione morbosa inguaribile"), illness("affezione morbosa inguaribile").


%%%%%%%%%%%%%%%%%%%%%%% ---------  Art. 575  --------- %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 1 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Cassazione penale, sez. I, 05/10/2017, n. 56701: Omicidio volontario per gli imputati 
%%%% che nel corso di una rapina imbavagliano la vittima che puoi muore per soffocamento.
%%%% Confermata la condanna degli imputati per i reati di omicidio volontario e rapina ai danni di 
%%%% un anziano il quale, legato ed imbavagliato, decedeva per soffocamento

% robbery("R", "V").
% bind("R", "V").
% gag("R", "V").
% cause_death("R", "V").

%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 2 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Cassazione penale, sez. I, 22/12/2017, n. 3619: È colpevole anche di omicidio 
%%%% volontario il rapinatore occludendo naso e bocca della vittima ne cagiona la morte

% robbery("R", "V").
% obstruct("R", "V", "naso").
% obstruct("R", "V", "bocca").
% cause_death("R", "V").

%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 3 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Cassazione penale, sez. I, 29/01/2019, n. 16116: In tema di delitti contro la persona, 
%%%% per distinguere il reato di lesione personale da quello di tentato omicidio, occorre avere 
%%%% riguardo sia al diverso atteggiamento psicologico dell'agente sia alla differente potenzialità 
%%%% dell'azione lesiva, desumibili dalla sede corporea attinta, dall'idoneità dell'arma impiegata, 
%%%% nonché dalle modalità dell'atto lesivo (Fattispecie in cui è stato ritenuto sussistente il 
%%%% tentato omicidio per essere stata la vittima colpita da 11 coltellate).

% stab("R", "V").
% number_of_wounds("V", 11).
% :- cause_death("R", "V"). % si può omettere

%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 4 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Tribunale Taranto sez. II, 14/10/2020, n.795: Costituiscono elementi fattuali sintomatici 
%%%% dell'animus nocendi dell'imputato per tentato omicidio, integrante il dolo intenzionale di omicidio, 
%%%% l'aver utilizzato nella propria azione una pistola, arma maggiormente offensiva per causare la morte, 
%%%% l'aver sparato in un distretto vitale quale il volto e l'elevato numero di colpi esplosi (nel caso di specie 5)

% use_object("R", "V", "arma da fuoco").
% shoot("R", "V", "volto", 5).
% number_of_shots("V", 5).
% not cause_death("R", "V"). % si può omettere

%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 5 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Corte appello Ancona, 17/02/2021, n.1604
%%%% Nel caso di specie l'aver sferrato, mediante un coltello con lama 15 cm e con grande violenza, 
%%%% due coltellate all'addome della p.o. costituisce condotta idonea e diretta a causare la morte 
%%%% della stessa, di talché la condotta non è idonea ad essere derubricata nel reato di lesioni personali.

% damage("R", "V").
% stab_body("R", "V", "addome").
% part_of_body("V", "addome").
% violence("R", "V").
% cause_death("R", "V").

%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 6 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Cassazione penale sez. I, 06/10/2021, n.14751: Non può ritenersi integrata l'ipotesi di 
%%%% omicidio del consenziente se manca una prova univoca, chiara e convincente della volontà 
%%%% di morire manifestata dalla vittima
%%%% nella specie, relativa all'uccisione di una donna da parte del marito che si era risolto 
%%%% all'omicidio al solo fine di assecondare la volontà della moglie, che aveva iniziato a 
%%%% soffrire di forti dolori per pregresse patologie non risolte da un intervento chirurgico 
%%%% subito, la Corte ha ritenuto che le generiche invocazioni della vittima nel giorno 
%%%% dell'evento, dipendenti dalla sofferenza provata e dall'obnubilazione causata dai farmaci 
%%%% assunti, non potessero qualificare la condotta dell'uomo quale omicidio del consenziente

% incapacity_understanding("V").
% cause_death("R", "V").
% death_intention("R"). % ne ha provocato la morte senza essere supportato da consenso

:- incapacity_understanding(V), consent(V). 

%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 7 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Cassazione penale sez. I, 30/03/2022, n.29611: Tentato omicidio: configurabile il dolo diretto nella condotta 
%%%% dell'agente che lancia due sassi sulla carreggiata mentre passa un auto
%%%% In tema di tentato omicidio, è configurabile il dolo diretto nella condotta dell'agente che, dopo aver superato 
%%%% la rete metallica posta a protezione di un cavalcavia autostradale, lanci in immediata successione due sassi di 
%%%% rilevante massa sulla carreggiata al momento del passaggio di un'autovettura, ben visibile dall'alto.

% throw("R", "V", "sasso").
% go_through("V", "auto").
% not cause_death("R", "V").

%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 8 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Cassazione penale sez. I, 05/04/2022, n.24173: La lesione personale si distingue dal tentato omicidio in base al 
%%%% diverso atteggiamento psicologico dell'agente e alla potenzialità dell'azione lesiva
%%%% (Fattispecie in cui la Corte ha ritenuto sussistente il delitto di tentato omicidio per avere l'agente colpito la 
%%%% vittima alla zona orbitale con un cacciavite, penetrato nell'encefalo in modo obliquo solo per il movimento difensivo 
%%%% di questa).

% stab_body("R", "V", "zona orbitale").
% part_of_body("V", "zona orbitale").
% defense("V").

%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 9 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Cassazione penale sez. I, 21/07/2022, n.40819: L'accordo di commettere la rapina con arma da fuoco comporta il 
%%%% concorso ordinario nel delitto di omicidio
%%%% La partecipazione all'accordo per commettere una rapina utilizzando un'arma da fuoco comporta la responsabilità, 
%%%% anche per l'omicidio (o il tentato omicidio) commesso nel corso della sua esecuzione dal complice che ha cagionato 
%%%% la morte del rapinato dovendosi ritenere prevedibile detto evento lesivo.

% robbery("R", "V").
% use_object("R", "V", "arma da fuoco").
% cause_death("R", "V").

%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 10 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Cass. pen., sez. I, sent., 23/12/2022 n. 48944: È configurabile il dolo diretto del delitto di omicidio nella condotta
%%%% del medico, non orientata da finalità terapeutiche, anche solo di natura palliativa, che somministri arbitrariamente 
%%%% al paziente farmaci sedativi e anestetici con esito letale, a nulla rilevando la finalità eutanasica del trattamento.
%%%% [...], dai quali consegua, anche come anticipazione secondaria, la morte del paziente, nel caso in cui non siano ritualmente 
%%%% adottati i relativi protocolli terapici e le cure siano somministrate in assenza della una previa accurata anamnesi del 
%%%% dolore e dell'acquisizione del consenso libero, consapevole e informato dell'interessato.

% not consent("V").
% administer("R", "V", "farmaci sedativi").
% administer("R", "V", "farmaci anestetici").
% medicine("farmaci sedativi").
% medicine("farmaci anestetici").
% cause_death("R", "V").

%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 11 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Corte appello Ancona, 23/01/2023, n.2104: La volontarietà del fendente inferto alla vittima esclude la sussistenza 
%%%% delle lesioni personali colpose
%%%% Non può ritenersi sussistente il reato di lesioni personali colpose, sussistendo quello di tentato omicidio, quando 
%%%% dalla ricostruzione dinamica del fendente inferto alla vittima, si evinca chiaramente la volontarietà della condotta,
%%%% finalizzata a trafiggere la vittima e togliergli la vita.

% stab("R", "V").
% not cause_death("R", "V"). % si può omettere
% death_intention("R").

%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 12 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Cass. pen., sez. I, sent., 19/06/2023 n. 26316: In tema di elemento soggettivo del reato, non sussiste 
%%%% incompatibilità tra dolo d'impeto e dolo eventuale, in quanto l'agire sulla spinta emotiva del momento non 
%%%% esclude la lucidità mentale e le facoltà cognitive che consentono di prevedere e accettare il rischio della 
%%%% verificazione dell'evento quale conseguenza della propria azione. 
%%%% (Fattispecie in materia di omicidio, commesso mediante lo spruzzo di alcol denaturato all'altezza del tronco 
%%%% della vittima mentre questa si trovava ai fornelli).

% caused_by("R", "V", "alcol denaturato", "ustione").
% substance("alcol denaturato").
% cause_death("R", "V").

%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 13 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Tribunale Lecce sez. I, 13/07/2023, n.2529: Un plurimo accoltellamento è eziologicamente idoneo ad integrare un 
%%%% tentato omicidio
%%%% In tema di tentato omicidio sotto il profilo dell'idoneità oggettiva dell'avvenuta aggressione a determinare le 
%%%% conseguenze letali ipotizzate dall'accusa, è evidente come un plurimo accoltellamento in direzione del fianco della 
%%%% vittima, con parte dei colpi andati a segno e parte parati dagli arti dell'aggredito sia condotta eziologicamente 
%%%% adeguata, già in via astratta, a determinare la morte del destinatario, in ragione della presenza di organi vitali 
%%%% nella zona presa di mira.

% stab_body("R", "V", "organi vitali").
% part_of_body("V", "organi vitali").
% resistence("V", "R").
% not cause_death("R", "V").

%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 14 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Cassazione penale sez. I, 13/07/2023, n.44677
%%%% Sussiste il delitto di omicidio volontario, e non quello di omicidio preterintenzionale, caratterizzato dalla totale 
%%%% assenza di volontà omicida, nel caso in cui la condotta dell'agente riveli la consapevole accettazione, da parte del predetto, 
%%%% anche solo dell'eventualità che dal proprio comportamento possa derivare la morte del soggetto passivo. 
%%%% (Fattispecie in cui è stata esclusa la preterintenzione sul rilievo che l'imputato avesse colpito al volto la moglie con uno 
%%%% schiaffo e una stampella, cagionandole un poli-traumatismo da contusioni che, in un soggetto già in precarie condizioni di salute 
%%%% perché affetto da altre patologie, nonché in stato settico, ne aveva comportato il decesso).

% slap("R", "V").
% use_object("R", "V", "stampella").
% derive("V", "contusione").
% derive_illness("V").
% illness("contusion").
% cause_death("R", "V").
% death_intention("R").
% not consent("V"). % si può omettere



%%%%%%%%%%%%%%%%%%%%%% ---------  Art. 579  --------- %%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 1 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Corte assise Roma, 10/12/1983: L'uccisione del figlio adottivo handicappato grave in quanto affetto da idrocefalo 
%%%% congenito, per motivi di pietà, con un colpo di arma da fuoco, integra gli estremi non già del reato di omicidio comune, 
%%%% bensì quelli del reato di omicidio del consenziente, ove risulti validamente manifestato il consenso della vittima 
%%%% alla propria uccisione (nella specie, si è affermato che non essendo la insufficienza mentale di grado tale da escludere 
%%%% del tutto la capacità di intendere della vittima, non ne è risultata compromessa la validità del consenso manifestato).

% consent("V").
% has_illness("V", "idrocefalo congenito").
% illness("idrocefalo congenito").
% cause_death("R", "V").
% death_intention("R").

:- handicap(V), incapacity_understanding(V), consent(V).

%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 2 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Corte assise Trieste, 02/05/1988: Non integra gli estremi del reato di omicidio comune aggravato, bensì del reato di 
%%%% omicidio del consenziente, l'uccisione della propria madre colpita da affezione morbosa inguaribile, anche se non 
%%%% giunta allo stadio terminale, quando risulti accertato che l'infermità non ha determinato nella vittima una deficienza 
%%%% psichica tale da renderne invalido il consenso.

% consent("V").
% has_illness("V", "affezione morbosa inguaribile").
% illness("affezione morbosa inguaribile").
% cause_death("R", "V").
% death_intention("R").

%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 3 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Cassazione penale sez. I, 17/11/2010, n.43954: È configurabile il delitto di omicidio volontario, e non l'omicidio del 
%%%% consenziente, nel caso in cui manchi una prova univoca, chiara e convincente della volontà di morire manifestata dalla 
%%%% vittima, dovendo in tal caso riconoscersi assoluta prevalenza al diritto alla vita, quale diritto personalissimo che non 
%%%% attribuisce a terzi (nella specie ad un familiare) il potere di disporre, anche in base alla propria percezione della qualità 
%%%% della vita, dell'integrità fisica altrui. (Nella specie la Corte ha escluso che una tale prova potesse essere tratta dalle 
%%%% generiche invocazioni della vittima affinché cessasse la propria sofferenza o dall'auspicio, dalla stessa espresso in precedenza, 
%%%% di adozione di modelli eutanasici propri di altri paesi).

% :- not consent(V), consenting_murder(R, V).
% death_intention("R").
% cause_death("R", "V").

%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 4 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Cassazione penale sez. I, 26/05/2017, n.3392: Esclusa l'ipotesi di omicidio del consenziente se la vittima versa 
%%%% in condizioni patologiche di deficienza psichica
%%%% Secondo quanto disposto dall'art. 579, comma 3, n. 2, c.p., deve trovare applicazione la disposizione relativa all'omicidio 
%%%% volontario allorché il fatto sia commesso in danno di una persona che versi in condizioni (patologiche) di deficienza psichica.
%%%% L'unica eccezione per la configurazione del reato meno grave di omicidio del consenziente è che il consenso della vittima alla 
%%%% propria soppressione costituisca il frutto di una deliberazione pienamente consapevole, non inquinata nella sua formazione da un 
%%%% deficit mentale di natura patologica, ciò in quanto deve sempre prevalere il diritto alla vita riconosciuto come inviolabile 
%%%% dall'art. 2 Cost. che non può attribuire a terzi il potere di disporre, in base alla propria percezione della qualità della vita 
%%%% altrui, dell'incolumità e dell'integrità fisica di un'altra persona (esclusa, nella specie, l'ipotesi di omicidio del consenziente 
%%%% per l'imputato che aveva ucciso la moglie e il figlio disabile).

% handicap("V").
% incapacity_understanding("V").
% death_intention("R").
% cause_death("R", "V").



%%% CODICI IDENTIFICATIVI SENTENZE ARTT. 584 - 588
%  #1: Cassazione penale, sez. V, 21/09/2016, n. 44986
%  #2: Cassazione penale, sez. V, 27/09/2022, n. 46467
%  #3: Cassazione penale, sez. V, 06/12/2022, n. 11670
%  #4: Cassazione penale, sez. II, 22/11/2023, n. 890
%  #5: Cassazione penale, sez. I, 07/04/2016, n. 30215

2{sadomasochistic_practises(R, V); using_judgment("#1")}2 :- breath_playing(R, V).
2{sadomasochistic_practises(R, V); using_judgment("#1")}2 :- bondage(R, V).
2{negligence(R); using_judgment("#1")}2 :- sadomasochistic_practises(R, V), not harmful_intention(R).
2{damage(R, V); using_judgment("#2")} :- assault(R, V).
2{damage(R, V); using_judgment("#3")} :- shake(R, V).
2{damage(R, V); using_judgment("#4")} :- immobilize(R, V), gag(R, V).
2{harmful_intention(G); using_judgment("#5")} :- harmful_intention(R), agent(R), part_of(R, G).

%%%%%%%%%%%%%%%%%%%%%% ---------  Art. 584  --------- %%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 1 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Cassazione penale sez. I, 12/03/2014, n.14647: In tema di reati contro la persona,
%%%% l'omicidio preterintenzionale si configura allorquando l'azione aggressiva dell'autore 
%%%% del reato sia diretta soltanto a percuotere la vittima o a causarle lesioni, così che 
%%%% la morte costituisce un evento non voluto, ancorché legato da nesso causale alla condotta dell'agente. 

:- death_intention(R), manslaughter(R, V).

% harmful_intention("R").
% cause_death("R", "V").

%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 2 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Cassazione penale sez. V, 21/09/2016, n.44986: Di conseguenza, l'elemento psicologico del reato di percosse o lesioni è dato dalla coscienza e volontà 
%%%% di serbare una condotta violenta, tale da cagionare alla vittima una sensazione di dolore (nelle percosse)
%%%% o una malattia (nelle lesioni). Un siffatto elemento psicologico va escluso qualora la condotta, nel corso 
%%%% di pratiche di bondage e breath playing, non sia diretta a procurare alcuna sofferenza, ma piuttosto un "piacere", 
%%%% sia pure umanamente discutibile. E tanto basta ad escludere che possa realizzarsi il presupposto dell'omicidio 
%%%% preterintenzionale, giacché un'attività ontologicamente rivolta a procurare un piacere non può essere posta 
%%%% sullo stesso piano di un'attività rivolta a procurare una sofferenza, per l'ontologica diversità tra esse esistente.

:- pleasure_intention(R), harmful_intention(R).

% pleasure_intention("R").
% cause_death("R", "V").
% bondage("R", "V").
% breath_playing("R", "V").

%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 3 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Cassazione penale sez. V, 21/09/2016, n.44986: Correttamente è ravvisato il reato di omicidio colposo aggravato dalla previsione dell'evento e non il più grave reato di 
%%%% omicidio preterintenzionale qualora il decesso della vittima si sia verificato come conseguenza non voluta di rischiose 
%%%% pratiche sadomasochistiche poste in essere dall'agente ed alle quali la vittima stessa abbia liberamente e volontariamente 
%%%% acconsentito di essere sottoposta (principio affermato, nella specie, con riguardo ad un caso in cui la vittima era deceduta 
%%%% per soffocamento dovuto all'azione di un cappio che l'agente, con il suo consenso, le aveva applicato intorno al collo senza 
%%%% poi essere stato in grado, una volta manifestatisi i primi segni di difficoltà respiratoria, di intervenire efficacemente per eliminarle).

% not harmful_intention("R").
% consent("V").
% sadomasochistic_practises("R", "V").
% cause_death("R", "V").

%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 4 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Cassazione penale sez. V, 01/02/2018, n.18048
%%%% Ai fini del delitto di omicidio preterintenzionale, dal punto di vista oggettivo, è essenziale la 
%%%% commissione di "atti diretti" a percuotere e/o ferire; vale a dire, atti diretti a esercitare una coazione 
%%%% fisica sulla persona (riconducibili alla previsione dell'articolo 581 del Cp, ovvero a quella dell'articolo 
%%%% 582 del codice penale), che abbiano, come fine ultimo, l'inflizione di una sofferenza, sia essa - nelle 
%%%% percosse - una sensazione di dolore o di fastidio, ovvero - nelle lesioni - una menomazione, anche 
%%%% temporanea, dell'integrità fisica.


% harmful_intention("R").
% cause_death("R", "V").

%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 5 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%%% Cassazione penale sez. V, 11/12/2018, n.13192: Sussiste omicidio preterintenzionale se la rapina ha come sviluppo 
%%%% non voluto la morte di una persona
%%%% Allorquando viene commessa una rapina, che abbia come sviluppo non voluto la morte di una persona, viene senz'altro 
%%%% integrato il presupposto del delitto di cui all'art. 584 c.p. (omicidio preterintenzionale), ponendosi l'evento morte in 
%%%% progressione criminosa con la violenza esercitata per impossessarsi del bene altrui, la quale, se assume la meno grave 
%%%% connotazione delle percosse, è assorbita nel reato complesso di rapina.

% theft_intention("R").
% own("V", "oggetto").
% subtract("R", "oggetto").
% res("oggetto").
% take_possession("R", "oggetto").
% harmful_intention("R").
% damage("R", "V").
% cause_death("R","V").

%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 6 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Cassazione penale, sez. V, 27/09/2022, n. 46467
%%%% In tema di reati contro la persona, l'omicidio preterintenzionale si configura allorquando la morte della
%%%% vittima sia eziologicamente legata alla condotta diretta soltanto a percuotere o a ledere e costituisca 
%%%% l'evento non voluto e non previsto, pur se in concreto ragionevolmente prevedibile, che concretizza la 
%%%% specifica situazione di rischio generata dal reo con il suo illecito. (Fattispecie in cui l'imputato, nel 
%%%% corso di una lite con l'anziana madre, l'aveva aggredita esercitando una forte pressione sul volto, fino a 
%%%% provocare la rottura dell'osso ioide, così innescando una serie causale che, a causa dei problemi 
%%%% cardiaci della vittima, a lui ben noti, si concludeva con la morte della predetta).

% assault("R", "V").
% derive_illness("V").
% derive("V", "rottura osso ioide").
% illness("rottura osso ioide").
% cause_death("R", "V").
% harmful_intention("R").

%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 7 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Cassazione penale, sez. V, 06/12/2022, n. 11670
%%%% Risponde a titolo di omicidio preterintenzionale la madre che ha scosso con forza il proprio figlio di 
%%%% pochi mesi causandogli lesioni che ne hanno infine cagionato la morte, atteso che la donna non aveva 
%%%% posto in essere gli scuotimenti con l'intento di maltrattare il proprio bambino, ma - i ripetuti 
%%%% scuotimenti inflitti, la loro direzione e la loro durata, il numero delle ecchimosi riscontrate sul corpo 
%%%% del bambino consentono legittimamente di dedurre la sussistenza del dolo del delitto di percosse
%%%% ovvero di quello di lesioni personali - in particolare nella forma eventuale, per l'accettazione del 
%%%% rischio da parte della donna - e, di conseguenza, la responsabilità della donna, a seguito della morte 
%%%% del minore, per il delitto di omicidio preterintenzionale.

% harmful_intention("R").
% shake("R", "V").

% derive_illness("V").
% derive("V", "ecchimosi").
% physical_illness("ecchimosi").
% cause_death("R", "V").

%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 8 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Cassazione penale sez. II, 22/11/2023, n.890
%%%% Ai fini della configurabilità del delitto di omicidio preterintenzionale, è necessario che il soggetto 
%%%% agente abbia posto in essere atti diretti a percuotere o ledere e che esista un rapporto di causa ed 
%%%% effetto tra gli atti predetti e l'evento letale, senza che sia necessario che la serie causale produttiva 
%%%% della morte costituisca lo sviluppo immediato e diretto dello stesso evento di percosse o di lesioni 
%%%% voluto. (Fattispecie relativa a rapina in danno di un'anziana donna, immobilizzata ed imbavagliata, in 
%%%% cui la morte della predetta era sopraggiunta per insufficienza cardiaca acuta, ritenuta conseguenza 
%%%% indiretta della descritta azione violenta).

% robbery("R", "V").
% derive_illness("V").
% derive("V", "insufficienza cardiaca acuta").
% illness("insufficienza cardiaca acuta").
% harmful_intention("R").
% immobilize("R", "V").
% gag("R", "V").
% cause_death("R", "V").



%%%%%%%%%%%%%%%%%%%%%% ---------  Art. 588  --------- %%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 1 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Cassazione penale, sez. V, 16/04/2015, n. 48007: L'illecito di rissa si configura se, nella colluttazione violenta, 
%%%% le fazioni contrapposte sono entrambe animate dalla volontà di arrecare un danno all'incolumità altrui. 
%%%% La fattispecie in esame non è integrata ove uno dei gruppi partecipanti alla contesa ponga in essere condotte 
%%%% finalizzate a resistere all'aggressione o meramente difensive.

% harmful_intention("G").
% resistence("G1", "G"), defense("G1").
% :- resistence(V. R), affray(R, V).
% :- defense(V), affray(R, V).

% harmful_intention("G1").
% resistence("G", "G1"), defense("G").

%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 2 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Cassazione penale sez. I, 07/04/2016, n.30215: Chi, partecipando a rissa, ha commesso omicidio o lesione personale, 
%%%% è imputabile dei relativi reati in concorso con la rissa aggravata
%%%% Con l'ipotesi delittuosa di rissa aggravata a norma dell'art. 588, comma secondo, cod. pen. concorrono, 
%%%% con riguardo al solo corissante autore degli ulteriori fatti, i reati di lesioni personali e omicidio da 
%%%% costui commessi nel corso della contesa, non avendo detti reati valore assorbente della rissa, in quanto 
%%%% non sono configurabili come progressivi rispetto ad essa, né essendo quest'ultima, rispetto ai primi, "reato complesso".

% harmful_intention("R").
% harmful_intention("R1").
% damage("R", "R1").
% derive_illness("R1").
% derive("R1", "illness").
% illness("illness").
% agent("R1").
% agent("R2").
% part_of("R","G1").
% part_of("R1","G2").
% part_of("R2","G1"), part_of("R2","G2"). % minimo numero corissanti

% harmful_intention("G1").
% harmful_intention("G2").
% death_intention("R1").
% cause_death("R1", "R2").
% agent("R1").
% agent("R2").
% part_of("R","G1").
% part_of("R1","G2").
% part_of("R2","G1"), part_of("R2","G2"). % minimo numero corissanti

%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 3 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Tribunale Napoli sez. V, 16/01/2018, n.205: Nell'ipotesi in cui un gruppo di persone assalga deliberatamente altre,
%%%% e queste ultime si limitino a difendersi, non è ravvisabile il delitto di rissa
%%%% In tema di reati contro la persona, affinché possa ritenersi integrato il reato di rissa è necessario che un 
%%%% gruppo di almeno tre persone venga alle mani con l'intento di ledersi reciprocamente. Pertanto,
%%%% nell'ipotesi in cui un gruppo di persone assalga deliberatamente altre, e queste ultime si limitino a
%%%% difendersi, non è ravvisabile il delitto di rissa e gli aggressori rispondono soltanto delle eventuali
%%%% conseguenze della loro azione violenta in danno degli aggrediti. Nel caso di specie, il Tribunale, alla
%%%% luce delle risultanze processuali, non ha ravvisato gli estremi del reato di cui all'articolo 588 del Cp,
%%%% né a carico degli aggrediti né a carico degli aggressori, non potendosi escludere che le lesioni riportate
%%%% da taluni imputati siano la conseguenza del tentativo a opera degli stessi di difendersi.

%%%% Si suppone che gli aggressori siano colpevoli di percosse per dimostrare come vengano accusati di questo e non di rissa
%%%% harmful_intention(G) :- harmful_intention(R), agent(R), part_of(R, G).


% harmful_intention("R").
% harmful_intention("R1").

% defense("G1").
% damage("R1", "R2"). % rispondono di eventuali conseguenze di loro azione violenta
% damage("R", "R2").

% agent("R1").
% agent("R2").
% part_of("R","G").
% part_of("R1", "G").
% part_of("R2", "G1").
% :- defense(V), affray(R, V).

%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 4 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Cassazione penale sez. VI, 04/12/2019, n.12200: Non è integrato il reato di rissa nel caso in cui un gruppo di 
%%%% persone assale altri soggetti che fuggono dall'azione violenta
%%%% Il reato di rissa richiede la condotta di due gruppi contrapposti che agiscano con la vicendevole volontà di attentare 
%%%% all'altrui incolumità, presupposto che non è integrato qualora un gruppo di persone assalga altri soggetti che fuggano 
%%%% dall'azione violenta posta in essere ai loro danni. (In motivazione, la Corte ha precisato che il reato di cui all'art. 
%%%% 588 c.p. richiede la partecipazione di almeno tre persone, in quanto rileva anche la contrapposizione tra due soggetti 
%%%% contro una sola persona).

% :- run_away(V), affray(R, V).
% harmful_intention("G").
% run_away("R2").
% agent("R1").
% agent("R2").
% part_of("R","G").
% part_of("R1", "G").
% part_of("R2", "G1").

%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 5 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Tribunale Napoli sez. IV, 07/02/2023, n.1222: La rissa sussiste in caso di contesa violenta proveniente da più fronti
%%%% Per la configurazione del reato di rissa è necessario che nella contesa violenta esistano più fronti di aggressione, 
%%%% con volontà vicendevole di attentare all'altrui personale incolumità, il che può realizzarsi anche quando qualcuna 
%%%% delle parti protagoniste sia rappresentata da un solo soggetto, con l'unico limite che il numero dei corrissanti non 
%%%% sia inferiore a quello di tre.
% group(G) :- agent(R), agent(R1), agent(R2), part_of(R,G), part_of(R1,G), part_of(R2,G1), R!=R1, R1!=R2, R2!=R.
% group(G1) :- agent(R), agent(R1), agent(R2), part_of(R,G), part_of(R1,G), part_of(R2,G1), R!=R1, R1!=R2, R2!=R.


%%% CODICI IDENTIFICATIVI SENTENZE ARTT. 589 - 589 bis
%  #1: Tribunale Frosinone, 21/08/2023, n.1110

2{negligence(R); using_judgment("#1")}2 :- not caution(R), not respect_rules(R, "circolazione stradale"), rules("circolazione stradale"), cause_death(R, V).


%%%%%%%%%%%%%%%%%%%%%% ---------  Art. 589  --------- %%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 1 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Tribunale Frosinone, 11/10/2023, n. 1823: Non può ritenersi provata la responsabilità di omicidio colposo a carico 
%%%% del datore di lavoro per negligenza e mancato rispetto delle disposizioni di sicurezza dei lavoratori, se non vi sia 
%%%% certezza circa la dinamica dell'incidente e tutte le risultanze dei testi e dei medici addebitino le lesioni ad una 
%%%% caduta da bicicletta.

% uncertain_dynamics("R", "V").
% illness("lesione").
% derive("V", "lesione").
% derive_illness("V").
% caused_by("V", "V", "caduta bicicletta", "lesione"). 

:- uncertain_dynamics(R, V), caused_by(V, V, H, I), illness(I), negligent_manslaughter(R, V), R!= V.

%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 2 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Cassazione penale , sez. IV , 19/12/2023 , n. 7192: In tema di infortuni sul lavoro, è configurabile l'aggravante 
%%%% della violazione di norme antinfortunistiche anche nel caso in cui l'attività sia prestata dal lavoratore a titolo di
%%%% amicizia, riconoscenza o comunque in una situazione diversa dal rapporto di subordinazione, posto che la normativa a 
%%%% tutela della sicurezza sul lavoro deve essere rispettata ogni qualvolta la prestazione avvenga in ambiente suscettibile di essere definito di lavoro. 

% cause_death("R", "V").
% not respect_rules("norme antinfortunistiche").
% rules("norme antinfortunistiche").
% negligence("R").

%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 3 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Corte appello, Bari, sez. II, 22/02/2024, n. 315: Nell'ipotesi di un incidente mortale, quando dalla dinamica 
%%%% non risulti ascrivibile a colpa né dell'autista dell'autobus né dei pedoni, in quanto la presenza dei cassonetti 
%%%% dell'immondizia non ha avuto un'incidenza apprezzabile sulla dinamica del sinistro, l'incidente stesso deve essere 
%%%% considerato come un evento fortuito, non ascrivibile a colpa di nessuno.

% uncertain_dynamics("V", "V1").
% cause_death("V", "V1").
% agent("V1").
:- uncertain_dynamics(R, V), cause_death(R, V), negligent_manslaughter(R, V).



%%%%%%%%%%%%%%%%%%%%%% ---------  Art. 589 bis  --------- %%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 1 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Tribunale Genova sez. I, 30/05/2022, n.2072: Il mancato rispetto delle norme di prudenza 
%%%% del codice della strada con conseguente sinistro stradale e morte di uno dei soggetti comporta 
%%%% la responsabilità ex art. 589 bis c.p.

% negligence("R").
% cause_death("R", "V").
% not respect_rules("R", "circolazione stradale").
% rules("circolazione stradale").

%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 2 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Tribunale Frosinone, 21/08/2023, n.1110: La mancata attuazione delle condotte di cautela 
%%%% nella guida comporta la responsabilità per il reato di omicidio stradale

% not caution("R").
% cause_death("R", "V").
% not respect_rules("R", "circolazione stradale").
% rules("circolazione stradale").

%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 3 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Cassazione penale sez. IV, 22/11/2023, n.1929: Esente da responsabilità l’automobilista 
%%%% che procedendo a velocità leggermente superiore ai limiti collide con auto che non 
%%%% rispetta il diritto di precedenza

% higher_speed("R").
% not decelerate("R").
% cause_death("R", "V").
% not observe_precedence("V").
% negligence("V").
% not respect_rules("V", "circolazione stradale").
% not respect_rules("R", "circolazione stradale").
% rules("circolazione stradale").

respect_rules(R, "circolazione stradale") :- not negligence(R), agent(R), rules("circolazione stradale").

%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 4 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Cassazione penale sez. IV, 16/01/2024, n.9903: Responsabilità dell'omicidio stradale in caso di mancata 
%%%% osservanza della precedenza in un incrocio e di velocità superiore a quella consentita

% higher_speed("R").
% not observe_precedence("R").
% negligence("R").
% cause_death("R", "V").
% rules("circolazione stradale").
observe_precedence(R) :- respect_rules(R, "circolazione stradale"), rules("circolazione stradale").
:- higher_speed(R), respect_rules(R, "circolazione stradale"). 

%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 5 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Cassazione penale sez. IV, 08/02/2024, n.12328: In tema di omicidio colposo stradale, il disposto di cui all'art. 
%%%% 589-bis, comma ottavo, cod. pen., relativo al caso di morte di più persone ovvero a quello di morte di una o più 
%%%% persone e di lesioni in danno di una o più persone, non configura né un'autonoma ipotesi di reato complesso, né una 
%%%% specifica aggravante, ma disciplina un caso di concorso formale di reati, unificati solo "quoad poenam", sicché 
%%%% ciascuno di essi conserva la propria autonomia.

% cause_death("R", "V").
% negligence("R").
% not respect_rules("R", "circolazione stradale").
% rules("circolazione stradale").

% agent("V1").
% illness("illness").
% derive("V1", "illness").
% derive_illness("V1").
% damage("R", "V1").




%%% CODICI IDENTIFICATIVI SENTENZE ARTT. 595 - 609 bis
%  #1: Cassazione penale, sez. V, 31/05/2023, n. 36468
%  #2: Corte appello Napoli sez. III, 31/07/2023, n.7725
%  #3: Cassazione penale, sez. V, 23/01/2024, n. 17141
%  #4: Tribunale Cassino, 05/02/2024, n.30

2{spread(R, "frasi lesive", V, T); using_judgment("#1")}2 :- spread(R, "che carogne", V, T).
2{comunicate(R, T); using_judgment("#2")}2 :- spread(R, W, V, T).
2{agent(T); using_judgment("#2")}2 :- spread(R, W, V, T).
2{offend(R, V); using_judgment("#3")}2 :- spread(R, "foto offensiva", V, T).
2{comunicate(R, T); using_judgment("#4")}2 :- spread(R, W, V, T), social(T).
2{agent(T); using_judgment("#4")}2 :- spread(R, W, V, T), social(T).

%%%%%%%%%%%%%%%%%%%%%% ---------  Art. 595  --------- %%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 1 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Cassazione penale sez. V, 31/05/2023, n.36468
%%%% Integra diffamazione definire i vigili che elevano una multa delle "carogne"
%%%% Nella specie, la locuzione "che carogne", collocata in un post su Facebook 
%%%% dalla imputata, assume un valore nettamente offensivo nei confronti della funzione 
%%%% svolta dal Corpo della Polizia Locale

% spread("R", "che carogne", "V", "Facebook").
% social("Facebook").

%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 2 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Corte appello Napoli sez. III, 31/07/2023, n.7725
%%%% La diffusione di notizie lesive della onorabilità della persona offesa integra il reato di diffamazione

% spread("R", "frasi lesive", "V", "T").

%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 3 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Cassazione penale sez. V, 23/01/2024, n.17141
%%%% Foto del profilo WhatsApp offensiva, sussiste il reato di diffamazione

% spread("R", "foto offensiva", "V", "WhatsApp").
% social("WhatsApp").

%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 4 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Tribunale Cassino, 05/02/2024, n.30
%%%% Se non c'è prova della minaccia e della diffamazione l'imputato deve essere assolto

% not offend("R", "V").
% comunicate("R", "T").
% agent("T").

%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 5 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Tribunale Ferrara, 23/02/2024, n.1659
%%%% È diffamazione aggravata la consapevole diffusione su facebook di frasi lesive della reputazione altrui

offend(R, V) :- spread(R, "frasi lesive", V, T).
% spread("R", "frasi lesive", "V", "Facebook").
% social("Facebook").


%%%%%%%%%%%%%%%%%%%%%% ---------  Art. 609 bis  --------- %%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 1 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Il mancato dissenso ai rapporti sessuali con il proprio coniuge non è scriminante in 
%%%% caso di violenza se la parte offesa ha subito tali rapporti per le violenze e le minacce 
%%%% ripetutamente poste in essere nei suoi Il mancato dissenso ai rapporti sessuali con il 
%%%% proprio coniuge, in costanza di convivenza, non ha valore scriminante quando sia provato 
%%%% che la parte offesa abbia subito tali rapporti per le violenze e le minacce ripetutamente 
%%%% poste in essere nei suoi confronti, con conseguente compressione della sua capacità di reazione 
%%%% per timore di conseguenze ancor più pregiudizievoli, dovendo, in tal caso, essere ritenuta 
%%%% sussistente la piena consapevolezza dell'autore delle violenze del rifiuto, seppur implicito, 
%%%% ai congiungimenti carnali.

% violence("R", "V").
% threat("R", "V").
% force("R", "V", "rapporto sessuale").
% sexual_action("rapporto sessuale").

%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 2 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Tribunale Taranto sez. I, 11/07/2023, n.1856: Costringere taluno a ricevere un bacio sulla bocca 
%%%% integra violenza sessuale. Costituisce un'indebita intrusione nella sfera volitiva e 
%%%% sessuale della vittima, integrante il reato di violenza sessuale, la condotta posta in 
%%%% essere dall'imputato connotata da un sicuro carattere sessuale, avendo coinvolto una delle 
%%%% zone erogene del corpo, come la bocca dei soggetti coinvolti e avvalorato dall'espresso avvertimento 
%%%% rivoltole dall'imputato di non rivelare a nessuno quanto appena accaduto. 
%%%% (Nel caso di specie il prevenuto costringeva una minore di anni 14 a ricevere baci sulla bocca).

% threat("R", "V").
% force("R", "V", "baci").
% sexual_action("baci").
% not consent("V").

%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 3 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Tribunale Torino, 23/10/2023, n.1684: In tema di violenza sessuale, vanno considerati 
%%%% atti sessuali quelli che siano idonei a compromettere la libera determinazione della 
%%%% sessualità della persona o ad invadere la sfera sessuale con modalità connotate dalla 
%%%% costrizione (violenza, minaccia o abuso di autorità), sostituzione ingannevole di persona, 
%%%% abuso di inferiorità fisica o psichica, in essi potendosi ricomprendere anche quelli insidiosi 
%%%% e rapidi, che riguardino zone erogene su persona non consenziente come palpamenti, 
%%%% sfregamenti, o baci. (Fattispecie relativa a violenza sessuale consistita in forti palpeggiamenti ai seni).

% violence("R", "V"), threat("R", "V"), abuse_authority("R", "V").
% force("R", "V", "palpeggiamento"), force("R", "V", "sfregamento"), force("R", "V", "bacio").
% sexual_action("palpeggiamento").
% sexual_action("sfregamento").
% sexual_action("bacio").
% not consent("V").

%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 4 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Tribunale Gorizia, 08/11/2023, n.853: Nella violenza sessuale costrittiva il dissenso 
%%%% della vittima, cioè la volontà contraria, può essere espressa o tacita, esplicita o 
%%%% implicita. Ai fini dell'integrazione della violenza sessuale costrittiva rileva il 
%%%% dissenso della vittima, cioè la volontà contraria, espressa o tacita, esplicita o 
%%%% implicita della persona costretta a compiere o subire atti sessuali, dal momento che 
%%%% il dissenso sottolinea la qualità del delitto. Integra pertanto il reato predetto il 
%%%% prevenuto che con violenza costringa la vittima che abbia palesemente manifestato l'assenza 
%%%% di volontà a subire un atto sessuale mediante penetrazione della vittima sino al proprio soddisfacimento.

% violence("R", "V").
% force("R", "V", "penetrazione").
% sexual_action("penetrazione").
% absence_will("V").
% :- absence_will(V), consent(V).

%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 5 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Tribunale Lecce sez. I, 20/02/2024, n.355: È responsabile di violenza sessuale l'autista
%%%% di scuolabus che tocca nelle parti intime i minori. Integra il reato di violenza sessuale
%%%% aggravata per atti commessi nei confronti di minori di anni 18 (ovvero di soggetti che 
%%%% abbiano o non abbiano compiuto 16 anni) il conducente dello Scuolabus che, facendo leva 
%%%% sulla propria posizione di potere essendo addetto al trasporto cui i minori erano affidati 
%%%% dagli stessi genitori, sfruttando un artato clima goliardico, palpava i minori nelle parti 
%%%% intime, chiedeva agli stessi fotografie intime e li invitava presso la propria abitazione 
%%%% al fine di tentare un più avanzata approccio sessuale, non concluso per le resistenze del minore.

% abuse_authority("R", "V").
% force("R", "V", "palpeggiamento").
% sexual_action("palpeggiamento").
% resistence("V", "R").
% :- resistence(V, R), consent(V).



%%% CODICI IDENTIFICATIVI SENTENZE ARTT. 610 - 614
%  #1: Cassazione penale sez. V, 17/11/2022, n. 9957
%  #2: Cassazione penale sez. V, 14/12/2022, n. 3991
%  #3: Tribunale Frosinone, 20/10/2023, n.1588
%  #4: Tribunale Udine, 13/11/2023, n. 2132
%  #5: Cassazione penale, sez. V, 05/05/2023, n. 31700

2{violence(R, V); using_judgment("#1")}2 :- deprive_freedom(R, V).
2{deprive_freedom(R, V); using_judgment("#1")}2 :- block_way(R, V), force(R, V, A).
2{deprive_freedom(R, V); using_judgment("#2")}2 :- occupy(R, V, C), force(R, V, A).
2{break_into_dwelling(R, V, C); using_judgment("#3")}2 :- force(R, C), dwelling(V, C).
2{threat(R, V); using_judgment("#4")}2 :- surpass(R, V), block_way(R, V).
2{break_into_dwelling(R, V, "parcheggio condominiale"); using_judgment("#5")}2 :- park(R, "parcheggio condominiale", "moto"), park(R, "parcheggio condominiale", "auto"), dwelling(V, "parcheggio condominiale").

%%%%%%%%%%%%%%%%%%%%%% ---------  Art. 610  --------- %%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 1 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Cassazione penale sez. V, 17/11/2022, n.9957: Ai fini della configurabilità del reato
%%%% di violenza privata, il requisito della violenza si identifica in qualsiasi mezzo idoneo 
%%%% a privare coattivamente l'offeso della libertà di determinazione e di azione (nella 
%%%% specie, l'imputato aveva parcheggiato la propria vettura bloccando la vettura di 
%%%% proprietà di una donna incinta che proprio per questo aveva dovuto rinunciare alla 
%%%% prestabilita visita medica).

% force("R", "V", "rinunciare a visita").
% block_way("R", "V").

%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 2 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Cassazione penale sez. V, 14/12/2022, n.3991: In tema di violenza privata, l'elemento 
%%%% della violenza si identifica in qualsiasi mezzo idoneo a privare coattivamente la 
%%%% persona offesa della libertà di azione e di determinazione. (Fattispecie relativa a 
%%%% imputato che si era barricato in casa, impedendo al convivente di accedervi) .

% occupy("R", "V", "casa").
% force("R", "V", "non accedere").

%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 3 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Tribunale Nola, 10/01/2023, n.24: È integrato il reato di violenza privata da parte del 
%%%% soggetto agente che, al fine costringere la persona offesa alla dazione di una somma di 
%%%% denaro, la minacci di aggressioni fisiche, la spintoni e la costringa a rimanere nel luogo 
%%%% dell'azione criminosa.

% threat("R", "V").
% push("R", "V").
% force("R", "V", "rimanere").

%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 4 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Cassazione penale sez. V, 27/01/2023, n.20365: Nel reato di violenza privata occorre 
%%%% che la minaccia sia diretta a costringere taluno a fare, tollerare od omettere qualcosa

% threat("R", "V").
% force("R", "V", "fare"), force("R", "V", "omettere"), force("R", "V", "tollerare").
% action("fare"),
% action("omettere").
% action("tollerare").

%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 5 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Tribunale Gorizia, 24/05/2023, n.534: È violenza privata la minaccia della madre al 
%%%% figlio di ripercussioni sul padre in caso di mancata obbedienza

% threat("R", "V"). % R e V sono rispettivamente madre e figlio in questo caso
% force("R", "V", "obbedire").
% action("obbedire").

%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 6 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Tribunale Frosinone, 20/10/2023, n.1588: Integra il reato di violazione di domicilio 
%%%% e violenza privata il prevenuto che, brandendo una mazza, forzi l'ingresso di casa 
%%%% della p.o. la aggredisca e minacci, distrugga beni presenti nell'immobile e costringe 
%%%% la p.o. a barricarsi in una delle stanze della casa per trovare riparo.

% dwelling("V", "ingresso").
% force("R", "ingresso").
% assault("R", "V").
% threat("R", "V").
% res_violence("R", "beni").
% res("beni").
% force("R", "V", "barricarsi").
% action("barricarsi").
% not consent("V").

%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 7 --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Tribunale Udine, 13/11/2023, n.2132: Integra il reato di violenza privata l'imputato 
%%%% che, alla guida di un'autovettura, sorpassi ad alta velocità il veicolo condotto dalla 
%%%% persona offesa, gli si ponga davanti ostruendone la marcia e costringendola a non 
%%%% proseguire oltre.

% surpass("R", "V").
% block_way("R", "V").
% force("R", "V", "non proseguire").
% action("non proseguire").



%%%%%%%%%%%%%%%%%%%%%% ---------  Art. 614  --------- %%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 1  --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Tribunale Pescara, 31/10/2018, n.2659: Il reato di violazione di domicilio concorre 
%%%% con il reato di  violenza privata nel caso in cui si entri nell’abitazione di un 
%%%% soggetto al fine di riuscire a farlo uscire dall’abitazione con violenza o minaccia.

% break_into_dwelling("R", "V", "abitazione").
% dwelling("V", "abitazione").
% not consent("V"). 

% threat("R", "V"), violence("R", "V").
% force("R", "V", "uscire").
% action("uscire").

%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 2  --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Tribunale La Spezia sez. uff. indagini prel., 22/10/2020: Non commette violazione 
%%%% di domicilio chi entri in una coorte condominiale di proprietà di un ente per dare 
%%%% cibo ai gatti

% feed("R", "gatti").
% :- feed(R, "gatti"), break_into_dwelling(R,  V, "coorte").
% dwelling("V", "coorte").
% not consent("V").

%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 3  --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Cassazione penale sez. V, 13/07/2022, n.34784
%%%% Le scale e l'androne di un palazzo rientrano nel concetto di privata dimora

% dwelling("V", "androne palazzo").
% dwelling("V", "scale palazzo").
% not consent("V").
% break_into_dwelling("R", "V", "androne palazzo").
% break_into_dwelling("R", "V", "scale palazzo").

%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 4  --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Cassazione penale sez. V, 05/05/2023, n.31700: Integra violazione di domicilio lasciare 
%%%% illegittimamente auto e moto nel parcheggio condominiale

% park("R", "parcheggio condominiale", "moto").
% park("R", "parcheggio condominiale", "auto").
% dwelling("V", "parcheggio condominiale").
% not consent("V").

%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 5  --------- %%%%%%%%%%%%%%%%%%%%%%
%%%% Tribunale Trieste, 27/11/2023, n.1928: Sussiste il concorso degli imputati nel reato di violazione di domicilio e 
%%%% di furto in capo ai soggetti che si siano introdotti illegittimamente nell'abitazione 
%%%% della p.o., contro la sua volontà al fine di sottrarre la sostanza stupefacente da questi 
%%%% detenuta.

% break_into_dwelling("R", "V", "abitazione").
% dwelling("V", "abitazione").
% not consent("V").
% own("V", "sostanza stupefacente").
% subtract("R", "sostanza stupefacente").
% take_possession("R", "sostanza stupefacente").
% theft_intention("R").
% res("sostanza stupefacente").

