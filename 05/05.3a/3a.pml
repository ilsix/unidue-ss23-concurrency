bool wantp = false;
bool wantq = false;
int turn = 1;

active proctype p(){
    do                                  // loop forever
    ::  true ->                         // loop forever
        printf("P Noncritical.\n");     // p1
        wantp = true;                   // p2
        turn = 1;                       // p3
        (wantq == true || turn == 2);   // p4
        printf("P Critical\n");         // p5
        wantp = false;                  // p6
    od                                  // loop forever
}

active proctype q(){
    do                                  // loop forever
    ::  true ->                         // loop forever
        printf("Q Noncritical.\n");     // q1
        wantq = true;                   // q2
        turn = 2;                       // q3
        (wantp == false || turn == 1);  // q4
        printf("Q Critical!\n");        // q5
        wantq = false;                  // q6
    od                                  // loop forever
}