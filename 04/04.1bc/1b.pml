bool wantp = false;
bool wantq = false;
bool nostarve = false;

active proctype p(){
    do
    ::  wantp = true;        //p2
        do                   //p3 while
        ::  wantq ->         //p3 wantq == true
            wantp = false;   //p4
            wantp = true;    //p5
        ::  else -> break;   //--
        od;                  //p3 while
        printf("P in CS\n"); //p6
        nostarve = true;
        wantp = false;       //p7
    od
}

active proctype q(){
    do
    ::  wantq = true;        //p2
        do                   //p3 while
        ::  wantp ->         //wantp == true
            wantq = false;   //q4
            wantq = true;    //q5
        ::  else -> break;   //--
        od                   //q3 while
        printf("Q in CS\n"); //q6
        wantq = false;       //q7
    od
}