%Dostane sudoku v podobě seznamu čísel po jednotlivých řádcích
%Vrátí seznam čísel po řádcích vyřešeného sudoku
%změní čísla/proměnné na celé šuplíky s souřadnicemi a možnostmi (change)
%rozdělí do šuplíků podle počtu možností(sortToPackages), poté aplikuje 
%nejnižší neprázdný šuplík dokud sudoku není vyřešené(applyOnesOnAll), nakonec výsledek seřadí 
%dle souřadnic(myMergeSort) a odstraní souřadnice
start(X,Done) :- change(0,X,Y),
    sortToPackages(Y,DoneM,[],One,[],Two,[],Three,[],Four,[],Five,[],Six,[],Seven,[],Eight,[],Nine,[]),
    applyOnesOnAll(DoneM,DoneUnsorted,One,[],Two,[],Three,[],Four,[],Five,[],Six,[],Seven,[],Eight,[],Nine,[]),
    myMergeSort(DoneUnsorted,DoneWithCoordinates),removeCoordinates(DoneWithCoordinates,Done).

%dostane seznam políček s souřadnicemi a vrátí seznam pouze hodnot
removeCoordinates([],[]).
removeCoordinates([_-_-_-V|Rest],[V|Rest2]) :- removeCoordinates(Rest,Rest2).

%Voláno ze startu, stará se o aplikaci políček z šuplíku s jednou možností na ostatní šuplíky, pokud jsou všechny šuplíky, kromě
%done prázdné tak dojde k vrácení výsledku, pokud nejsou všechny prázdné a je prázdný jedničkový šuplík, tak se zavolá applyLowest,
%Který vybere "nejnižší" šuplík a otipuje hodnotu prvního políčka ze seznamu.
applyOnesOnAll(Done,Done,[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]).

applyOnesOnAll(Dones,Done,[],One,Twos,Two,Threes,Three,Fours,Four,Fives,Five,Sixs,Six,Sevens,Seven,Eights,Eight,Nines,Nine) :-
	applyLowest(Dones,Done,[],One,Twos,Two,Threes,Three,Fours,Four,Fives,Five,Sixs,Six,Sevens,Seven,Eights,Eight,Nines,Nine).  

applyOnesOnAll(Dones,Done,[X|Ones],One,Twos,Two,Threes,Three,Fours,Four,Fives,Five,Sixs,Six,Sevens,Seven,Eights,Eight,Nines,Nine) :-
    playOnes([X|Ones],Twos,Twom,Un1,[]),playOnes([X|Ones],Threes,Threem,Un2,Un1),playOnes([X|Ones],Fours,Fourm,Un3,Un2),
     playOnes([X|Ones],Fives,Fivem,Un4,Un3),playOnes([X|Ones],Sixs,Sixm,Un5,Un4),playOnes([X|Ones],Sevens,Sevenm,Un6,Un5),
    playOnes([X|Ones],Eights,Eightm,Un7,Un6),playOnes([X|Ones],Nines,Ninem,Un8,Un7), moveUsedOnesToDone([X|Ones],Dones,Donem),
    sortToPackages(Un8,DoneD,Donem,OneD,[],TwoD,Twom,ThreeD,Threem,FourD,Fourm,FiveD,Fivem,SixD,Sixm,SevenD,Sevenm,EightD,Eightm,NineD,Ninem),
    applyOnesOnAll(DoneD,Done,OneD,One,TwoD,Two,ThreeD,Three,FourD,Four,FiveD,Five,SixD,Six,SevenD,Seven,EightD,Eight,NineD,Nine).

%Dle pattern matchingu je vybrán nejnižší neprázdný šuplík, první políčko je otipováno a program pokračuje applyOnesOnAll
applyLowest(Dones,Done,[],One,[],Two,[],Three,[],Four,[],Five,[],Six,[],Seven,[],Eight,[N|Ines],Nine) :-
    selectRandomValue([N|Ines],Step,NewNines),
    applyOnesOnAll(Dones,Done,[Step],One,[],Two,[],Three,[],Four,[],Five,[],Six,[],Seven,[],Eight,NewNines,Nine).

applyLowest(Dones,Done,[],One,[],Two,[],Three,[],Four,[],Five,[],Six,[],Seven,[E|Ights],Eight,Nines,Nine):-
     selectRandomValue([E|Ights],Step,NewEights),
    applyOnesOnAll(Dones,Done,[Step],One,[],Two,[],Three,[],Four,[],Five,[],Six,[],Seven,NewEights,Eight,Nines,Nine).

applyLowest(Dones,Done,[],One,[],Two,[],Three,[],Four,[],Five,[],Six,[S|Evens],Seven,Eights,Eight,Nines,Nine) :-
         selectRandomValue([S|Evens],Step,NewSevens),
    applyOnesOnAll(Dones,Done,[Step],One,[],Two,[],Three,[],Four,[],Five,[],Six,NewSevens,Seven,Eights,Eight,Nines,Nine).

applyLowest(Dones,Done,[],One,[],Two,[],Three,[],Four,[],Five,[Si|Xs],Six,Sevens,Seven,Eights,Eight,Nines,Nine) :-
      selectRandomValue([Si|Xs],Step,NewSixs),
    applyOnesOnAll(Dones,Done,[Step],One,[],Two,[],Three,[],Four,[],Five,NewSixs,Six,Sevens,Seven,Eights,Eight,Nines,Nine).

applyLowest(Dones,Done,[],One,[],Two,[],Three,[],Four,[Fi|Ves],Five,Sixs,Six,Sevens,Seven,Eights,Eight,Nines,Nine) :-
       selectRandomValue([Fi|Ves],Step,NewFives),
    applyOnesOnAll(Dones,Done,[Step],One,[],Two,[],Three,[],Four,NewFives,Five,Sixs,Six,Sevens,Seven,Eights,Eight,Nines,Nine).

applyLowest(Dones,Done,[],One,[],Two,[],Three,[F|Ours],Four,Fives,Five,Sixs,Six,Sevens,Seven,Eights,Eight,Nines,Nine) :-
        selectRandomValue([F|Ours],Step,NewFours),
    applyOnesOnAll(Dones,Done,[Step],One,[],Two,[],Three,NewFours,Four,Fives,Five,Sixs,Six,Sevens,Seven,Eights,Eight,Nines,Nine).
                                         
applyLowest(Dones,Done,[],One,[],Two,[Th|Rees],Three,Fours,Four,Fives,Five,Sixs,Six,Sevens,Seven,Eights,Eight,Nines,Nine):-
     selectRandomValue([Th|Rees],Step,NewThrees),
    applyOnesOnAll(Dones,Done,[Step],One,[],Two,NewThrees,Three,Fours,Four,Fives,Five,Sixs,Six,Sevens,Seven,Eights,Eight,Nines,Nine).

applyLowest(Dones,Done,[],One,[Tw|Os],Two,Threes,Three,Fours,Four,Fives,Five,Sixs,Six,Sevens,Seven,Eights,Eight,Nines,Nine):-
      selectRandomValue([Tw|Os],Step,NewTwos),
    applyOnesOnAll(Dones,Done,[Step],One,NewTwos,Two,Threes,Three,Fours,Four,Fives,Five,Sixs,Six,Sevens,Seven,Eights,Eight,Nines,Nine).

%Voláno z applyLowest, Dostane seznam, vezme z něj první prvek a vrátí ho s náhodnou pro něj možnou hodnotou a vrátí zbytek seznamu
selectRandomValue([R/C/S-Values|List],R/C/S-[Value],List) :- select(Value,Values,_).

% používáno k závěrečnému seřazení, dostane seznam a vrátí ho setřízený dle souřadnic
%seznam nulové či jednotkové délky je setřízený, jinak rozděl na dvě, srovnej části a slij
myMergeSort([],[]).
myMergeSort([X],[X]).
myMergeSort([X,Y|Unsorted],Sorted) :- divide([X,Y|Unsorted],UnsortedA,UnsortedB),
    myMergeSort(UnsortedA,A),myMergeSort(UnsortedB,B),myMerger(A,B,Sorted).

%rozdělí zadaný seznam na dva výstupní, v případě liché délky je první delší
divide([],[],[]).
divide([X],[X],[]).
divide([X,Y|Rest],[X|Rest1],[Y|Rest2]) :- divide(Rest,Rest1,Rest2).

%slije dva vzestupně setříděné seznamy do jednoho. 
myMerger([],[X|Rest],[X|Rest]).
myMerger(X,[],X).
myMerger([R1-C1-S1-V1|Rest1],[R2-C2-S2-V2|Rest2],[R1-C1-S1-V1|Rest3]) :- R1<R2,myMerger(Rest1,[R2-C2-S2-V2|Rest2],Rest3).
myMerger([R1-C1-S1-V1|Rest1],[R1-C2-S2-V2|Rest2],[R1-C1-S1-V1|Rest3]) :- C1<C2,myMerger(Rest1,[R1-C2-S2-V2|Rest2],Rest3).
myMerger([R1-C1-S1-V1|Rest1],[R2-C2-S2-V2|Rest2],[R2-C2-S2-V2|Rest3]) :- R1>R2,myMerger([R1-C1-S1-V1|Rest1],Rest2,Rest3).
myMerger([R2-C1-S1-V1|Rest1],[R2-C2-S2-V2|Rest2],[R2-C2-S2-V2|Rest3]) :- C1>C2,myMerger([R2-C1-S1-V1|Rest1],Rest2,Rest3).

%voláno z applyOnesOnAll, Dostane seznam použitých políček a aktuální stav šuplíku "done" a přidá do něj tyto prvky (přetypovaně) 
moveUsedOnesToDone([],D,D).
moveUsedOnesToDone([R/C/S-[V]|Rest],Dones,[R-C-S-V|Done]) :- moveUsedOnesToDone(Rest,Dones,Done).

%projede sudoku, přidá souřadnice (řádek,sloupec,čtverec) a možnosti. Voláno z start
%Dostane počáteční index a seznam čísel/proměnných a vrátí seznam políček s souřadnicemi a možnostmi
change(_,[],[]).
change(N,[X|Rest],[R/C/S-[X]|Rest2]) :- nonvar(X),R is N // 9, C is N mod 9,S is (R//3)*3 + C // 3,N1 is N+1, change(N1,Rest,Rest2).
change(N,[Y|Rest],[R/C/S-[1,2,3,4,5,6,7,8,9]|Rest2]) :-var(Y),R is N // 9, C is N mod 9,S is (R // 3)*3 + (C // 3),N1 is N+1, change(N1,Rest,Rest2).

%Dostane informace o políčku(souřadnice a hodnotu) a šuplíček na něž má být aplikován a 
%vrátí šuplíček nezměněných prvků a list změněných (nezatříděných) prvků,které se dále musí zatřídit. 
%Počáteční stav změněných prvků dostal jako pátý argument.
processListAndDivide(_,[],[],UnsortedEnd,UnsortedEnd).
processListAndDivide(R/C/S-[V],[X|Rest],Rest2,[Y|UnsortedEnd],UnsortedStart) :- deleteOnePossibility(R,C,S,V,X,Y),X \= Y,
    processListAndDivide(R/C/S-[V],Rest,Rest2,UnsortedEnd,UnsortedStart).
processListAndDivide(R/C/S-[V],[X|Rest],[X|Rest2],UnsortedEnd,UnsortedStart) :- deleteOnePossibility(R,C,S,V,X,X),
    processListAndDivide(R/C/S-[V],Rest,Rest2,UnsortedEnd,UnsortedStart).

%Dostane šuplíček(box) s jednou možností, šuplíček(box) na který má být aplikován, 
%vrátí nový šuplíček(box) a nezatříděné prvky, dostane počáteční nezatřídě prvky
%nejdtříve zahraje jedničky na nezatříděné prvky, tím dostane nový jejich seznam a ten použije jako počáteční
%při aplikování jedniček na zadaný box, poté se ještě přesvědčíme, že nevznikne políčko s nula možnostmi a pokračujeme
playOnes([],X,X,UnsortedEnd,UnsortedEnd).
playOnes([X|Rest],BoxStart,BoxEnd,UnsortedEnd,UnsortedStart) :- processList(X,UnsortedStart,Unsorted1),
    processListAndDivide(X,BoxStart,Box1,Unsorted2,Unsorted1),processListAndDivide(X,Rest,Rest,[],[]),
    playOnes(Rest,Box1,BoxEnd,UnsortedEnd,Unsorted2).

%Voláno z playOnes,pro aplikaci jedniček na seznam nesetříděných prvků (tam již nechci dělit na změněné a nezměněné)
%Dostane políčko, seznam a vrátí změněný seznam po aplikaci
processList(_,[],[]).
processList(R/C/S-[V],[X|Rest],[Y|Rest2]) :- deleteOnePossibility(R,C,S,V,X,Y),processList(R/C/S-[V],Rest,Rest2).

%na lichých pozicích dostane list k rozřízení a počátek done,počátek nul možností, počátek jedněch možností atd.
%na sudých pozicích vrátí roztřízené přihrádky (počáteční pozice je lichá!)
sortToPackages([],SD,SD,S1,S1,S2,S2,S3,S3,S4,S4,S5,S5,S6,S6,S7,S7,S8,S8,S9,S9).

sortToPackages([X|Rest],Done,SD,[X|One],S1,Two,S2,Three,S3,Four,S4,Five,S5,Six,S6,Seven,S7,Eight,S8,Nine,S9) :-
    X = _/_/_-L, length(L,Length),Length =:=1,
    sortToPackages(Rest,Done,SD,One,S1,Two,S2,Three,S3,Four,S4,Five,S5,Six,S6,Seven,S7,Eight,S8,Nine,S9).

sortToPackages([X|Rest],Done,SD,One,S1,[X|Two],S2,Three,S3,Four,S4,Five,S5,Six,S6,Seven,S7,Eight,S8,Nine,S9) :- 
    X = _/_/_-L, length(L,Length),Length =:=2,
    sortToPackages(Rest,Done,SD,One,S1,Two,S2,Three,S3,Four,S4,Five,S5,Six,S6,Seven,S7,Eight,S8,Nine,S9).

sortToPackages([X|Rest],Done,SD,One,S1,Two,S2,[X|Three],S3,Four,S4,Five,S5,Six,S6,Seven,S7,Eight,S8,Nine,S9) :- 
    X = _/_/_-L, length(L,Length),Length =:=3,
   sortToPackages(Rest,Done,SD,One,S1,Two,S2,Three,S3,Four,S4,Five,S5,Six,S6,Seven,S7,Eight,S8,Nine,S9).

sortToPackages([X|Rest],Done,SD,One,S1,Two,S2,Three,S3,[X|Four],S4,Five,S5,Six,S6,Seven,S7,Eight,S8,Nine,S9) :- 
    X = _/_/_-L, length(L,Length),Length =:=4,
   sortToPackages(Rest,Done,SD,One,S1,Two,S2,Three,S3,Four,S4,Five,S5,Six,S6,Seven,S7,Eight,S8,Nine,S9).

sortToPackages([X|Rest],Done,SD,One,S1,Two,S2,Three,S3,Four,S4,[X|Five],S5,Six,S6,Seven,S7,Eight,S8,Nine,S9) :- 
    X = _/_/_-L, length(L,Length),Length =:=5,
   sortToPackages(Rest,Done,SD,One,S1,Two,S2,Three,S3,Four,S4,Five,S5,Six,S6,Seven,S7,Eight,S8,Nine,S9).

sortToPackages([X|Rest],Done,SD,One,S1,Two,S2,Three,S3,Four,S4,Five,S5,[X|Six],S6,Seven,S7,Eight,S8,Nine,S9) :- 
    X = _/_/_-L, length(L,Length),Length =:=6,
  sortToPackages(Rest,Done,SD,One,S1,Two,S2,Three,S3,Four,S4,Five,S5,Six,S6,Seven,S7,Eight,S8,Nine,S9).

sortToPackages([X|Rest],Done,SD,One,S1,Two,S2,Three,S3,Four,S4,Five,S5,Six,S6,[X|Seven],S7,Eight,S8,Nine,S9) :- 
    X = _/_/_-L, length(L,Length),Length =:=7,
    sortToPackages(Rest,Done,SD,One,S1,Two,S2,Three,S3,Four,S4,Five,S5,Six,S6,Seven,S7,Eight,S8,Nine,S9).

sortToPackages([X|Rest],Done,SD,One,S1,Two,S2,Three,S3,Four,S4,Five,S5,Six,S6,Seven,S7,[X|Eight],S8,Nine,S9) :- 
    X = _/_/_-L, length(L,Length),Length =:=8,
    sortToPackages(Rest,Done,SD,One,S1,Two,S2,Three,S3,Four,S4,Five,S5,Six,S6,Seven,S7,Eight,S8,Nine,S9).

sortToPackages([X|Rest],Done,SD,One,S1,Two,S2,Three,S3,Four,S4,Five,S5,Six,S6,Seven,S7,Eight,S8,[X|Nine],S9) :- 
    X = _/_/_-L, length(L,Length),Length =:=9,
    sortToPackages(Rest,Done,SD,One,S1,Two,S2,Three,S3,Four,S4,Five,S5,Six,S6,Seven,S7,Eight,S8,Nine,S9).


%dostane řádek,sloupec,čtvrtec a hodnotu a koukne se na políčko a pokud souvisí s zadaným a mělo v možnostech jeho 
%hodnotu tak ji vymaže z možností, jinak ho nechá původní, kontroluje aby každé políčko mělo možnost.
deleteOnePossibility(R,_,_,V,R/C/S-X,R/C/S-Y) :- deleteElement(X,V,Y),length(Y,Length),Length > 0.
deleteOnePossibility(R1,C,_,V,R/C/S-X,R/C/S-Y) :-R1 \= R,deleteElement(X,V,Y),length(Y,Length),Length > 0.
deleteOnePossibility(R1,C1,S,V,R/C/S-X,R/C/S-Y) :- R1 \= R,C1 \= C,deleteElement(X,V,Y),length(Y,Length),Length > 0.
deleteOnePossibility(R1,C1,S1,_,R/C/S-X,R/C/S-X) :- R1 \= R,C1 \= C, S1 \= S.

%Projede si seznam možností (nějakého políčka) a smaže zadanou možnost
deleteElement([],_,[]).
deleteElement([V|Rest],V,Y) :- deleteElement(Rest,V,Y).
deleteElement([X|Rest],V,[X|Y]) :- X \= V,deleteElement(Rest,V,Y).
