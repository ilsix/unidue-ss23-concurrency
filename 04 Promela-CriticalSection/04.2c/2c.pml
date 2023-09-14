bool wantp = false;
bool wantq = false;
byte turn = 1;
byte crit = 0;

#define mutex (crit <= 1)

active proctype p(){
    do
    ::  wantp = true;
        do
        ::  wantp ->
            if
            ::  (turn == 1)
            ::  (turn == 2) ->
                wantp = false;
                (turn == 1);
                wantp = true;
            fi
        ::  else -> break;
        od
        crit++;
        printf("P in CS\n");
        crit--;
        turn = 2;
        wantp = false;
    od
}

active proctype q(){
    do
    ::  wantq = true;
        do
        ::  wantp ->
            if
            ::  (turn == 2)
            ::  (turn == 1) ->
                wantq = false;
                (turn == 2);
                wantq = true;
            fi
        ::  else -> break;
        od
        crit++;
        printf("Q in CS\n");
        crit--;
        turn = 1;
        wantq = false;
    od
}