coupValideL([A|_], C, L, L, R1) :- extract2(A, 0, C, R), get(R,R1),!.
coupValideL([_|B], C, L, L1, R1) :- L1 < L, L2 is L1 + 1, coupValideL(B, C, L, L2, R1).


extract2([_|B], C, C1, X) :- C < C1, C2 is C + 1, extract2(B, C2, C1, X).
extract2([A|_], C, C, X) :- get(A,X).


get(A,A).
