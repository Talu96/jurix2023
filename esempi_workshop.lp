% La condotta delittuosa consistita nella sottrazione con strappo, in danno della persona offesa,
% della bag nella disponibilità della stessa (nella specie contenente una modesta somma di denaro
% e le chiavi di casa) integra il delitto previsto e punito dall'articolo 624 bis, comma 2, c.p.
% In circostanze siffatte deve, invero, dirsi realizzato l'impossessamento della bag e del suo
% contenuto con sottrazione della stessa alla persona offesa, compiuta mediante strappo, così come
% previsto dalla richiamata norma codicistica.

% agent("Mario Rossi").
% agent("Giorgio Bianchi").
% theft_intention("Mario Rossi").
% res("bag").
% own("Giorgio Bianchi", "bag").
% take_possession("Mario Rossi", "bag").
% snatch("Mario Rossi", "bag").


%% Tribunale Lecce sez. II, 21/04/2021, n.942
% In tema di rapina si configura l’ipotesi di cui al comma 2 dell’art. 628 c.p. nella condotta di colui che,
% al fine di impossessarsi di quanto sottratto o per conseguire l’impunità, impedisca alle persone offese di
% intervenire costringendole a fuggire o comunque coartando la loro volontà e libertà di movimento con
% comportamenti violenti, minacciosi o aggressivi. A riguardo va precisato che per violenza alla persona
% s’intende non solo la violenza propria (cioè l’impiego di forza fisica nei confronti della persona
% offesa al fine di togliergli la libertà di movimento), ma anche la c.d. violenza impropria (che consiste
% in una privazione coatta della volontà di autodeterminazione della persona offesa che, quindi, è costretta
% a fare, tollerare od omettere di fare qualcosa contro la propria volontà).


% agent("Mario Rossi").
% agent("Giorgio Bianchi").
% theft_intention("Mario Rossi").
% subtract("Mario Rossi", "bag").
% res("bag").
% own("Giorgio Bianchi", "bag").
% selfdetermination_limitation("Mario Rossi", "Giorgio Bianchi").

%% Corte di Cassazione, sez. II Penale, sentenza 2 – 18 aprile 2014, n. 17348
% Nel caso di specie, correttamente la Corte territoriale ha ritenuto integrato il delitto di rapina in
% quanto la violenza è stata direttamente esercitata contro la persona poiché l'agente ha strappato con
% violenza la necklace, cioè una cosa particolarmente aderente al corpo del possessore, che non poteva
% essere sottratta se non con violenza alla persona.


agent("Mario Rossi").
agent("Giorgio Bianchi").
theft_intention("Mario Rossi").
subtract("Mario Rossi", "necklace").
res("necklace").
own("Giorgio Bianchi", "necklace").
take_possession("Mario Rossi", "necklace").
unknown_adherence("Giorgio Bianchi", "necklace").
% adherence("Giorgio Bianchi", "necklace", 3).

#show robbery/2.
#show theft_snatch/2.
#show attempted_robbery/2.
#show attempted_theft_snatch/2.
#show adherence/3.



%% Esempio dove non assegnamo un livello di aderenza all'oggetto

% agent("Mario Rossi").
% agent("Giorgio Bianchi").
% theft_intention("Mario Rossi").
% subtract("Mario Rossi", "necklace").
% res("necklace").
% own("Giorgio Bianchi", "necklace").
% unknown_adherence("Giorgio Bianchi", "necklace").
