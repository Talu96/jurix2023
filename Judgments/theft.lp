agent("R").
agent("V").


%%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 1 --------- %%%%%%%%%%%%%%%%%%%%%%%
%%%% Cassazione penale sez. I, 10/01/1979:afferrare il polso della vittima
%%%% e torcerlo con violenza significa fare una rapina. Sarebbe furto se invece
%%%% l’effetto della forza dell’aggressore si riflettesse sulla vittima in modo
%%%% indiretto e involontario.

% theft_intention("R").
% physical_object("oggetto").
% own("V", "oggetto").
% subtract("R", "oggetto").
% tight_physical_adherence("V", "oggetto").     %si può anche omettere
% twist("R", "V", "polso").
% part_of_body("V", "polso").
% take_possession("R", "oggetto").



%%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 2 --------- %%%%%%%%%%%%%%%%%%%%%%%
%%%% Cassazione penale sez. I, 07/04/1982: trascinare la vittima per metri e farla cadere è rapina 

% theft_intention("R").
% physical_object("oggetto").
% own("V", "oggetto").
% subtract("R", "oggetto").
% drag("R", "V").
% make_fall("R", "V").
% take_possession("R", "oggetto").



%%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 3 --------- %%%%%%%%%%%%%%%%%%%%%%%
%%%% Tribunale minorenni Catania, 25/11/1983: parzialmente difforme: se la violenza impressa sulla
%%%% cosa si trasmette alla persona della vittima (per la sua particolare connessione o adesione al
%%%% corpo del detentore o per la resistenza da questo volontariamente o involontariamente opposta,) allora è rapina 

% theft_intention("R").
% physical_object("oggetto").
% own("V", "oggetto").
% subtract("R", "oggetto").
% resistence("V", "R").
% take_possession("R", "oggetto").



%%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 4 --------- %%%%%%%%%%%%%%%%%%%%%%%
%%%% Cassazione penale sez. II, 08/11/1984: per aversi rapina la violenza deve ripercuotersi sulla vittima 

% theft_intention("R").
% physical_object("oggetto").
% own("V", "oggetto").
% subtract("R", "oggetto").
% person_violence("R", "V").
% take_possession("R", "oggetto").



%%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 5 --------- %%%%%%%%%%%%%%%%%%%%%%%
%%%% Cassazione penale sez. II, 30/04/1985 “Nella specie è stata ritenuta la sussistenza del reato di rapina
%%%% a carico di soggetto che sporgendosi da un'auto in marcia e dando strappi ad una bag che tenuta a tracolla
%%%% da una donna aveva trascinato costei per qualche metro sulla carreggiata facendola rotolare a terra
%%%% fino a quando non si era spezzata la cinghia della bag).” 

% theft_intention("R").
% physical_object("borsa").
% own("V", "borsa").
% subtract("R", "borsa").
% drag("R", "V").
% tug("R", "V").
% take_possession("R", "borsa").



%%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 6.a --------- %%%%%%%%%%%%%%%%%%%%%%%
%%%% Cassazione Penale 49832/2013: se all’azione del reo corrisponde una resistenza della vittima, 
%%%% la fattispecie potrà assumere una qualificazione variabile,  e più precisamente: 
%%%% a) se il reo interrompe immediatamente la propria condotta al momento della reazione della “controparte”, 
%%%% si avrà tentato furto con strappo; 

% theft_intention("R").
% physical_object("oggetto").
% own("V", "oggetto").
% subtract("R", "oggetto").
% resistence("V", "R").
% interruption("R").


%%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 6.b --------- %%%%%%%%%%%%%%%%%%%%%%%
%%%% b) se il reo cerca di superare la resistenza altrui senza riuscirvi ed abbandona l’azione, si configura 
%%%% il tentativo di rapina; 

% theft_intention("R").
% physical_object("oggetto").
% own("V", "oggetto").
% subtract("R", "oggetto").
% resistence("V", "R").
% :- interruption("R").
% :- take_possession("R", "oggetto").


%%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 6.c --------- %%%%%%%%%%%%%%%%%%%%%%%
%%%% c) se il reo cerca di superare la resistenza altrui e vi riesce, si configura una rapina consumata.

% theft_intention("R").
% physical_object("oggetto").
% own("V", "oggetto").
% subtract("R", "oggetto").
% resistence("V", "R").
% :- interruption("R").
% take_possession("R", "oggetto").



%%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 7.a --------- %%%%%%%%%%%%%%%%%%%%%%%
%%%% Cassazione penale sez. II, 02/04/2014, n.17348: “Rispetto alla linea di discrimine fra il furto con strappo 
%%%% e la rapina, integra il reato di furto con strappo la condotta di violenza immediatamente rivolta verso 
%%%% la cosa e solo in via del tutto indiretta verso la persona che la detiene,

% theft_intention("R").
% physical_object("oggetto").
% own("V", "oggetto").
% subtract("R", "oggetto").
% res_violence("R", "oggetto").
% indirect_violence_person("R", "V").
% take_possession("R", "oggetto").


%%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 7.b --------- %%%%%%%%%%%%%%%%%%%%%%%
%%%% mentre ricorre il delitto di rapina quando la "res" sia particolarmente aderente al corpo del possessore 
%%%% e la violenza si estenda necessariamente alla persona, dovendo il soggetto attivo vincerne la resistenza 
%%%% e non solo superare la forza di coesione inerente alla normale relazione fisica tra il possessore e la cosa sottratta”. 

% theft_intention("R").
% physical_object("oggetto").
% own("V", "oggetto").
% subtract("R", "oggetto").
% tight_physical_adherence("V", "oggetto").
% resistence("V", "R").
% take_possession("R", "oggetto").



%%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 8 --------- %%%%%%%%%%%%%%%%%%%%%%%
%%%% Tribunale Firenze sez. I, 08/04/2016, n.2247 (Nel caso di specie, è stato ritenuto sussistente la fattispecie 
%%%% di furto con strappo in quanto l'imputato si era limitato a strappare il telefono di mano alla vittima del reato
%%%% mentre questa era distratta da un complice). 

% theft_intention("R").
% physical_object("telefono").
% own("V", "telefono").
% subtract("R", "telefono").
% :- person_violence("R", "V").
% :- indirect_violence_person("R", "V"). % se non ho person_violence non avrò nemmeno indirect_violence_person
% snatch("R", "telefono").
% take_possession("R", "telefono").



%%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 9 --------- %%%%%%%%%%%%%%%%%%%%%%%
%%%% Corte appello Roma sez. I, 19/10/2017, n.7573 (Nel caso di specie, la Corte d'appello ha confermato la condanna 
%%%% per il reato di rapina nei confronti dell'imputato che, al fine di vincere la resistenza opposta dalla vittima, 
%%%% aveva strattonato e spinto la stessa, riuscendo così a sottrarle il telefono cellulare.) 

% theft_intention("R").
% physical_object("telefono").
% own("V", "telefono").
% subtract("R", "telefono").
% push("R", "V").
% resistence("V", "R").
% take_possession("R", "telefono").



%%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 10 --------- %%%%%%%%%%%%%%%%%%%%%%%
%%%% Cassazione penale sez. II, 21/02/2019, n.16899 (Fattispecie in cui la Corte ha ritenuto corretta la qualificazione 
%%%% come rapina dei fatti commessi dall'imputato che, avvicinate da tergo le persone offese, di età avanzata, afferrava 
%%%% loro la testa e la bloccava con una manovra di compressione, garantendosi l'immobilità necessaria a sfilare gli 
%%%% orecchini dai lobi delle vittime). 

 theft_intention("R").
 physical_object("orecchini").
 own("V", "orecchini").
 subtract("R", "orecchini").
% snatch("R", "orecchini").
 block("R", "V", "testa").
 part_of_body("V", "testa").
 take_possession("R", "orecchini").
 :- res_violence("R","orecchini"). % si attiva damage



%%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 11 --------- %%%%%%%%%%%%%%%%%%%%%%%
%%%% Tribunale Pescara, 07/05/2019, n.1639 (Nel caso di specie, lo strappo tentato della bag nei confronti della vittima caduta
%%%% in terra a seguito della minaccia con le forbici e la spinta, integra il reato di rapina aggravata poiché l’imputato aveva
%%%% tentato di vincere la resistenza passiva della vittima, a cui aveva già cagionato lesioni, esercitando un’ulteriore violenza 
%%%% sulla stessa nel pervicace tentativo di impossessarsi della bag, insistendo nell’azione di strappo benché la bag si fosse
%%%% attorcigliata intorno al corpo della persona offesa e senza  preoccuparsi di arrecare ulteriori lesioni alla stessa). 

% theft_intention("R").
% physical_object("borsa").
% own("V", "borsa").
% subtract("R", "borsa").
% threat("R", "V").
% push("R", "V").
% tug("R", "V").
% take_possession("R", "borsa").



%%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 12 --------- %%%%%%%%%%%%%%%%%%%%%%%
%%%% Tribunale Trieste, 11/05/2021, n.746 Nel caso di specie, il Tribunale ha ritenuto corretta l'imputazione per il delitto di rapina
%%%% nei confronti di un uomo che strattonando l'impiegata della cancelleria, si impossessava dell'originale del certificato di eredità
%%%% che quest'ultima aveva cercato di trattenere. 

% theft_intention("R").
% physical_object("certificato eredità").
% own("V", "certificato eredità").
% subtract("R", "certificato eredità").
% tug("R", "V").
% take_possession("R", "certificato eredità").

 

%%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 13 --------- %%%%%%%%%%%%%%%%%%%%%%%
%%%% Cassazione penale sez. II, 14/09/2021, n.36178 “In tema di rapina, l'elemento oggettivo del reato può essere costituito anche dal 
%%%% compimento di un'azione violenta nei confronti di una cosa qualora questa forma di violenza sia tale da esprimere un messaggio minatorio
%%%% nei confronti della persona al fine di annullarne o limitarne la capacità di autodeterminazione.  (Fattispecie in cui l'azione violenta 
%%%% era consistita nella contemporanea rottura dei vetri delle portiere anteriori di vettura ferma al semaforo da parte di due persone travisate). 
 
% theft_intention("R").
% physical_object("oggetto").
% own("V", "oggetto").
% subtract("R", "oggetto").
% res_violence("R", "finestrini").
% selfdetermination_limitation("R", "V"). 
% take_possession("R", "oggetto").
 


%%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 14 --------- %%%%%%%%%%%%%%%%%%%%%%%
%%%% Cassazione penale sez. II, 10/02/2022, n.12453 (nella specie, la Corte ha ritenuto che la particolare tipologia dell'oggetto sottratto alla vittima,
%%%% un orologio tenuto al polso da apposito cinturino, dovesse fare escludere la possibilità di ritenere configurabile il semplice furto con strappo posto 
%%%% che la sottrazione alla vittima comporta, necessariamente, un quantum di violenza in danno della stessa che doveva essere pur brevemente immobilizzata 
%%%% e comunque subire lo sganciamento dell'orologio contro la sua volontà). 

% theft_intention("R").
% physical_object("orologio").
% own("V", "orologio").
% subtract("R", "orologio").
% foreshadowing_violence("R").
% take_possession("R", "orologio").



%%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 15 ---------- %%%%%%%%%%%%%%%%%%%%%
%%%% Tribunale Potenza, 02/12/2022, n.1178: Non vi è responsabilità per furto se è la stessa p.o. ad escludere la 
%%%% volontà degli agenti di sottrarre i beni al legittimo proprietario
%%%% Non può esservi condanna per il furto di olive, nei confronti del prevenuto per il quale non sia emersi elementi 
%%%% attestanti la sua condotta di raccolta abusiva e violenta dei frutti dagli alberi di proprietà di terzi e per i 
%%%% quali dallo stesso soggetto danneggiato sia stata esclusa la volontà di sottrarre i beni al legittimo proprietario, 
%%%% ma che l'azione fosse stata espletata nella convinzione del totale abbandono del campo.

% physical_object("olive").
% subtract("R", "oggetto").
% :- theft_intention("R").
% subtract("R","olive").
% own("V","olive").
% take_possession("R","olive").



%%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 16 ---------- %%%%%%%%%%%%%%%%%%%%%
%%%% Tribunale Nola, 04/01/2023, n.1801: La sottrazione di una collana dal collo del proprietario integra 
%%%% furto con strappo
%%%% Integra il reato di furto con strappo di cui al secondo comma dell'art. 624 bis c.p. la condotta del prevenuto 
%%%% che sottragga una collana dal proprietario che la stia indossando mentre questi è in pubblica via, al fine di 
%%%% trarne profitto.

% theft_intention("R").
% physical_object("collana").
% own("V","collana").
% subtract("R","collana").
% take_possession("R","collana").
% unknown_adherence("V","collana").



%%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 17.a ---------- %%%%%%%%%%%%%%%%%%%%%
%%%% Cassazione penale sez. II, 24/01/2023, n.23932: Differenza tra il delitto di rapina e il delitto di furto con 
%%%% strappo nell'ipotesi di violenza esercitata sul braccio della vittima per sottrargli l'orologio
%%%% Ricorre il delitto di rapina quando la condotta violenta sia stata esercitata per vincere la resistenza della 
%%%% persona offesa, anche ove la "res" sia particolarmente aderente al corpo del possessore e la violenza si estenda 
%%%% necessariamente alla persona, dovendo il soggetto attivo superarne la resistenza e non solo la forza di coesione 
%%%% inerente alla normale relazione fisica tra possessore e cosa sottratta, giacché in tal caso è la violenza stessa 
%%%% - e non lo strappo - a costituire il mezzo attraverso il quale si realizza la sottrazione; 

% theft_intention("R").
% res("res").
% own("V","res").
% subtract("R","res").
% tight_physical_adherence("V","res"). % la person_violence è data da subtract e tight_physical_adherence  
% resistence("V","R").
% take_possession("R","res").


%%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 17.b ---------- %%%%%%%%%%%%%%%%%%%%%
%%%% si configura, invece, il delitto di furto con strappo quando la violenza sia immediatamente rivolta verso la cosa, 
%%%% seppur possa avere ricadute sulla persona che la detiene (fattispecie relativa alla condotta degli imputati che 
%%%% per impossessarsi dell'orologio della ne avevano bloccato il braccio).
% theft_intention("R").
% physical_object("orologio").
% own("V","orologio").
% subtract("R","orologio").
% block("R","V","braccio").
% part_of_body("V","braccio").
% res_violence("R","orologio").
% take_possession("R","orologio").



%%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 18 ---------- %%%%%%%%%%%%%%%%%%%%%
%%%% Tribunale Genova sez. II, 06/09/2023, n.2622: Il furto anche aggravato resta nella forma tentata se non 
%%%% c'è impossessamento di alcun bene 
%%%% In materia di furto, anche aggravato, il reato resta nella forma tentata nel caso in cui pur essendo state 
%%%% poste in essere condotte dirette in modo non equivoco all'impossessamento (di beni come l'apertura e/o la forzatura 
%%%% di armadietti e porte) il soggetto agente non abbia asportato alcunché.

% open("R","armadietti").
% open("R","porte").
% force("R","armadietti").
% force("R","porte").
% own("V","oggetto").
% subtract("R","oggetto").
% physical_object("oggetto").
% :- take_possession("R","oggetto"). % si può omettere 

% theft_intention(R) :- open(R,C), force(R,C).



%%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 19 ---------- %%%%%%%%%%%%%%%%%%%%%
%%%% Corte appello Roma sez. IV, 03/10/2023, n.9885: Usare violenza contro la vittima per sottrarre la borsa 
%%%% integra rapina e non furto con strappo
%%%% Non integra il reato di furto con strappo bensì quello di rapina la condotta dei coimputati che si sostanzi 
%%%% nella sottrazione della borsa della persona offesa, come atto finale di un concorso dei due soggetti che con 
%%%% l'uso della violenza abbiano aggredito la vittima per poi scappare con il bottino, svolgendo la condotta senza 
%%%% soluzione di continuità.

% theft_intention("R").
% physical_object("borsa").
% own("V","borsa").
% subtract("R","borsa").
% take_possession("R","borsa").
% assault("R","V").

% damage(R,V) :- assault(R,V), agent(R), agent(V), R!=V.



%%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 20 ---------- %%%%%%%%%%%%%%%%%%%%%
%%%% Corte appello Ancona, 11/10/2023, n.2307: In ordine al reato di furto, l'illecito sussiste nell'ipotesi 
%%%% in cui il reo l'imputato sottragga merce dagli scaffali, occultandola in una borsa, senza pagare il prezzo 
%%%% della stessa
%%%% Risulta pienamente integrato il delitto di furto, nell'ipotesi in cui l'imputato venga avvistato mentre sottraeva
%%%% dagli scaffali del negozio un trapano ed una latta d'olio e li inseriva in una borsa in tela scura che aveva con 
%%%% sé, per poi recarsi verso l'uscita, senza corrisponderne il prezzo.

% theft_intention("R").
% own("V","merce").
% subtract("R","merce").
% take_possession("R","merce").
% hide("R","merce").
% :- pay("R","merce").
% res("merce").



%%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 21 ---------- %%%%%%%%%%%%%%%%%%%%%
%%%% Tribunale Nocera Inferiore, 02/11/2023, n.2208: Integra il furto e non la rapina la condotta repentina 
%%%% e violenta del soggetto agente non abbia dovuto superare alcuna resistenza della vittima
%%%% Integra il reato di furto e non quello di rapina se il soggetto agente non abbia dovuto superare alcuna 
%%%% resistenza della vittima, in forza anche dell'effetto sorpresa derivante dalla repentinità dell'azione, 
%%%% attuando una violenza diretta sulla refurtiva e solo indirettamente coinvolgente la vittima, la quale non ha 
%%%% riportato alcun pregiudizio fisico. Il furto è quello in abitazione, di cui all'art. 624 bis c.p., se la condotta 
%%%% criminosa sopra descritta si sia verificata nell'abitazione della vittima, anche se il soggetto agente è stato fatto 
%%%% entrare dalla stessa vittima.

% theft_intention("R").
% own("V","oggetto").
% subtract("R","oggetto").
% take_possession("R","oggetto").
% :- resistence("V","R"). % si può omettere
% res_violence("R","oggetto").
% physical_object("oggetto").



%%%%%%%%%%%%%%%%%%%%%%% --------- Esempio 22 ---------- %%%%%%%%%%%%%%%%%%%%%
%%%% Tribunale Frosinone, 06/11/2023, n.1571: Forzare le condutture dell'acqua per sottrarne ingenti quantità è furto
%%%% Integra il reato di furto di cui all'art. 624 comma 2, il soggetto che forzando delle condutture sigillate per 
%%%% la sua stessa morosità, sottragga ingenti quantità di acqua alla società gestore delle risorse idriche, dal 
%%%% momento che la risorsa idrica è qualificabile come energia con rilevanza economica.

% own("società idrica","acqua").
% take_possession("R","acqua").
% subtract("R","acqua").
% force("R","condutture acqua").
% seal("società idrica","condutture acqua").
% energy("acqua").
% economic_value("acqua").
% agent("società idrica").

% theft_intention(R): force(R,O), seal(V,O), agent(V), agent(R), R!=V.


