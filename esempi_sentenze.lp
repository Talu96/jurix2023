reo("R").
victim("V").
theft_intention("R").
physical_object("oggetto").
own("V", "oggetto").
subtract("R", "oggetto").


%%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 1 --------- %%%%%%%%%%%%%%%%%%%%%%%
%%%% Cassazione penale sez. I, 10/01/1979:afferrare il polso della vittima
%%%% e torcerlo con violenza significa fare una rapina. Sarebbe furto se invece
%%%% l’effetto della forza dell’aggressore si riflettesse sulla vittima in modo
%%%% indiretto e involontario.

% tight_physical_adherence("V", "oggetto").     %si può anche omettere
% twist("R", "V", "polso").
% part_of_body("V", "polso").
% take_possession("R", "oggetto").


%%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 1 --------- %%%%%%%%%%%%%%%%%%%%%%%
%%%% Cassazione penale sez. I, 07/04/1982: trascinare la vittima per metri e farla cadere è rapina 

drag("R", "V").
make_fall("R", "V").
take_possession("R", "oggetto").


%%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 2 --------- %%%%%%%%%%%%%%%%%%%%%%%
%%%% Tribunale minorenni Catania, 25/11/1983: parzialmente difforme: se la violenza impressa sulla
%%%% cosa si trasmette alla persona della vittima (per la sua particolare connessione o adesione al
%%%% corpo del detentore o per la resistenza da questo volontariamente o involontariamente opposta,) allora è rapina 

% resistence("V", "R").
% take_possession("R", "oggetto").


%%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 3 --------- %%%%%%%%%%%%%%%%%%%%%%%
%%%% Cassazione penale sez. II, 08/11/1984: per aversi rapina la violenza deve ripercuotersi sulla vittima 

% person_violence("R", "V").
% take_possession("R", "oggetto").


%%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 4 --------- %%%%%%%%%%%%%%%%%%%%%%%
%%%% Cassazione penale sez. II, 30/04/1985 “Nella specie è stata ritenuta la sussistenza del reato di rapina
%%%% a carico di soggetto che sporgendosi da un'auto in marcia e dando strappi ad una bag che tenuta a tracolla
%%%% da una donna aveva trascinato costei per qualche metro sulla carreggiata facendola rotolare a terra
%%%% fino a quando non si era spezzata la cinghia della bag).” 

% make_fall("R", "V").
% tug("R", "V").
% take_possession("R", "oggetto").


%%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 5 --------- %%%%%%%%%%%%%%%%%%%%%%%
%%%% Cassazione penale sez. II, 02/04/2014, n.17348: “Rispetto alla linea di discrimine fra il furto con strappo 
%%%% e la rapina, integra il reato di furto con strappo la condotta di violenza immediatamente rivolta verso 
%%%% la cosa e solo in via del tutto indiretta verso la persona che la detiene,

% res_violence("R", "oggetto").
% indirect_person_violence("R", "V").
% take_possession("R", "oggetto").


%%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 6 --------- %%%%%%%%%%%%%%%%%%%%%%%
%%%% mentre ricorre il delitto di rapina quando la "res" sia particolarmente aderente al corpo del possessore 
%%%% e la violenza si estenda necessariamente alla persona, dovendo il soggetto attivo vincerne la resistenza 
%%%% e non solo superare la forza di coesione inerente alla normale relazione fisica tra il possessore e la cosa sottratta”. 

% tight_physical_adherence("V", "oggetto").
% resistence("V", "R").
% take_possession("R", "oggetto").



%%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 7 --------- %%%%%%%%%%%%%%%%%%%%%%%
%%%% Tribunale Firenze sez. I, 08/04/2016, n.2247 (Nel caso di specie, è stato ritenuto sussistente la fattispecie 
%%%% di furto con strappo in quanto l'imputato si era limitato a strappare il telefono di mano alla vittima del reato
%%%% mentre questa era distratta da un complice). 

% :- person_violence("V", "R").
% :- indirect_person_violence("V", "R").
% snatch("R", "oggetto").
% take_possession("R", "oggetto").



%%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 8 --------- %%%%%%%%%%%%%%%%%%%%%%%
%%%% Corte appello Roma sez. I, 19/10/2017, n.7573 (Nel caso di specie, la Corte d'appello ha confermato la condanna 
%%%% per il reato di rapina nei confronti dell'imputato che, al fine di vincere la resistenza opposta dalla vittima, 
%%%% aveva strattonato e spinto la stessa, riuscendo così a sottrarle il telefono cellulare.) 

% push("R", "V").
% resistence("V", "R").
% take_possession("R", "oggetto").



%%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 9 --------- %%%%%%%%%%%%%%%%%%%%%%%
%%%% Cassazione penale sez. II, 21/02/2019, n.16899 (Fattispecie in cui la Corte ha ritenuto corretta la qualificazione 
%%%% come rapina dei fatti commessi dall'imputato che, avvicinate da tergo le persone offese, di età avanzata, afferrava 
%%%% loro la testa e la bloccava con una manovra di compressione, garantendosi l'immobilità necessaria a sfilare gli 
%%%% orecchini dai lobi delle vittime). 

% snatch("R", "orecchini").
% block("R", "V", "testa").
% part_of_body("V", "testa").
% take_possession("R", "oggetto").



%%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 10 --------- %%%%%%%%%%%%%%%%%%%%%%%
%%%% Tribunale Pescara, 07/05/2019, n.1639 (Nel caso di specie, lo strappo tentato della bag nei confronti della vittima caduta
%%%% in terra a seguito della minaccia con le forbici e la spinta, integra il reato di rapina aggravata poiché l’imputato aveva
%%%% tentato di vincere la resistenza passiva della vittima, a cui aveva già cagionato lesioni, esercitando un’ulteriore violenza 
%%%% sulla stessa nel pervicace tentativo di impossessarsi della bag, insistendo nell’azione di strappo benché la bag si fosse
%%%% attorcigliata intorno al corpo della persona offesa e senza  preoccuparsi di arrecare ulteriori lesioni alla stessa). 
 
% threat("R", "V").
% push("R", "V").
% damage("R", "V").
% tug("R", "V").
% take_possession("R", "oggetto").



%%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 11 --------- %%%%%%%%%%%%%%%%%%%%%%%
%%%% Tribunale Trieste, 11/05/2021, n.746 Nel caso di specie, il Tribunale ha ritenuto corretta l'imputazione per il delitto di rapina
%%%% nei confronti di un uomo che strattonando l'impiegata della cancelleria, si impossessava dell'originale del certificato di eredità
%%%% che quest'ultima aveva cercato di trattenere. 

% tug("R", "V").
% take_possession("R", "oggetto").

 

%%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 12 --------- %%%%%%%%%%%%%%%%%%%%%%%
%%%% Cassazione penale sez. II, 14/09/2021, n.36178 “In tema di rapina, l'elemento oggettivo del reato può essere costituito anche dal 
%%%% compimento di un'azione violenta nei confronti di una cosa qualora questa forma di violenza sia tale da esprimere un messaggio minatorio
%%%% nei confronti della persona al fine di annullarne o limitarne la capacità di autodeterminazione.  (Fattispecie in cui l'azione violenta 
%%%% era consistita nella contemporanea rottura dei vetri delle portiere anteriori di vettura ferma al semaforo da parte di due persone travisate). 
 
% res_violence("R", "finestrini").
% selfdetermination_limitation("R", "V"). 
% take_possession("R", "oggetto").
 


%%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 13 --------- %%%%%%%%%%%%%%%%%%%%%%%
%%%% Cassazione penale sez. II, 10/02/2022, n.12453 (nella specie, la Corte ha ritenuto che la particolare tipologia dell'oggetto sottratto alla vittima,
%%%% un orologio tenuto al polso da apposito cinturino, dovesse fare escludere la possibilità di ritenere configurabile il semplice furto con strappo posto 
%%%% che la sottrazione alla vittima comporta, necessariamente, un quantum di violenza in danno della stessa che doveva essere pur brevemente immobilizzata 
%%%% e comunque subire lo sganciamento dell'orologio contro la sua volontà). 

% foreshadowing_violence("R").
% take_possession("R", "oggetto").



%%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 14.a --------- %%%%%%%%%%%%%%%%%%%%%%%
%%%% Cassazione Penale 49832/2013: se all’azione del reo corrisponde una resistenza della vittima, la fattispecie potrà assumere una qualificazione variabile, 
%%%% e più precisamente: a) se il reo interrompe immediatamente la propria condotta al momento della reazione della “controparte”, si avrà tentato furto con strappo; 

% resistence("V", "R").
% interruption("R").


%%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 14.b --------- %%%%%%%%%%%%%%%%%%%%%%%
%%%% b) se il reo cerca di superare la resistenza altrui senza riuscirvi ed abbandona l’azione, si configura il tentativo di rapina; 

% resistence("V", "R").
% :- interruption("R").
% :- take_possession("R", "oggetto").


%%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 14.c --------- %%%%%%%%%%%%%%%%%%%%%%%
%%%% c) se il reo cerca di superare la resistenza altrui e vi riesce, si configura una rapina consumata.

% resistence("V", "R").
% :- interruption("R").
% take_possession("R", "oggetto").