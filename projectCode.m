// modulo di BOB
//! N
moduloBob := 14134776518227074636666380005944327148232518622232484997602186133888683727;
//esponente privato di BOB precedente
//! e
expPrivatoBob := 8010963493005485093288967649630608484348295826998492370171301288165153411;
//esponente pubblico di BOB precedente
//! d
expPubblicoBob := 13689800311114019893803019889120589217133488423376523476547511279214184499;
//nuovo esponente pubblico di BOB
//! e'
nuovoExpPubblicoBob := 9908520024335141283260544937017903458797784642754147317653289220740038861;

//codifica di k1 con chiave pubblica di bob
m := 5751259865077956157511021340137587114507436969558676223765789827333660992;

//messaggio in chiaro 1
m1 := 0x2EB2BF16;

//messaggio codificato 1
c1 := 0x9D1FC809;


//messaggio codificato 2
c2 := 0xCD08485F;

//messaggio in chiaro 3
m3 := 0xB7BC7150;

//messaggio codificato 3
c3 := 0xEECB535F;

//? FIND

//nuovo esponente privato di BOB
//! d'
nuovoExpPrivatoBob := 0;

//da trovare 
k1 := 0x0;
k2 := 0x0;
k := Append(k1,k2);

//messaggio in chiaro 2
m2 := 0x0;

//da trovare
kPrime := 0x0;

// xBad32()
//Integers Ring
Z := Integers();
//Integers Ring mod N
modN := Integers(moduloBob);

function FindPhi(N, e, d)
    p := 0;
    q := 0;
    X := {2..9};
    x := Random(X);

    i := 2;
    exp := (e * d) - 1;
    y := modN!x^(Z!(exp/i));

    while y eq 1 do
        i := i * 2;
        y := modN!x^(Z!(exp/i));       
    end while;


    p := Z!GCD(y-1, N);
    q := Z!(N / p);

    phiN := (p - 1) * (q - 1);

    return phiN;
end function;

phiN := FindPhi(moduloBob, expPrivatoBob, expPubblicoBob);

// Integers Ring modulo Phi(N)
modPhiN := Integers(phiN);

nuovoExpPrivatoBob := Z!modPhiN!(nuovoExpPubblicoBob^(-1));

"found d' : ", modPhiN!(nuovoExpPrivatoBob * nuovoExpPubblicoBob) eq 1;
"d' : ", nuovoExpPrivatoBob;

k1 := modN!m^nuovoExpPrivatoBob;

k1;

