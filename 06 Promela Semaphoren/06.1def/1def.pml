/* Übung 6 Concurrency, University of Duisburg-Essen */

typedef Semaphore {
	byte V; /* S.V */
	bool blocked[3]; /* S.L - 3 for two processes*/ 
};

Semaphore S;

/* the following function is defined using the keyword inline */
/* you can think of it as a subroutine called inside one of the processes */
inline wait() {
	atomic {
		if 
		:: S.V >= 1 -> S.V-- /* Decrement S.V */
		:: else -> /* S.V = 0 -> block process*/
			S.blocked[_pid-1] = true; /* set process to state blocked. (init is process 0, so p,q will have 1,2 but the array starts at 0 -> do -1) */
			!S.blocked[_pid-1] /* wait until being unblocked */
		fi
	}
}

/* the following function is defined using the keyword inline */
/* you can think of it as a subroutine called inside one of the processes */
inline signal() {
	atomic {
		/* Define the signal() function here */
		if											// Wir können nicht wie in der Aufgabe gezeigt überprüfen ob S.L/S.blocked[] leer ist, da S.blocked[]
		::  S.blocked[0] -> S.blocked[0] = false;	// von Natur aus die bools für beide Prozesse enthält. Daher geben wir einfach, wie in der Aufgabe
		::  S.blocked[1] -> S.blocked[1] = false;	// verlangt, einen der beiden Prozesse frei.
		::  S.blocked[2] -> S.blocked[2] = false;	
		::  else -> S.V++;							// Der "if S.L = ∅" ist hier das else, da, wie oben erwähnt, keine Prüfung auf ein leeres Array erfolgen
		fi											// kann, da das Array hier nie leer ist.
	}
}

/* init (main) process */
init {
	S.V = 1; /* Initialize S.V with value 1 */
	atomic {
		run p();
		run q();
		run z();
	}

}

// 1e)
int critical = 0;
#define mutex (critical <=1)

// 1f)
bool csp = false;


proctype p() {
	do									// loop forever
	::  true ->							// loop forever
		printf("P Noncritical.\n");		// p1
		wait();							// p2
		critical++;
		printf("P Critical!\n");		// p3
		csp = true;
		critical--;
		signal();						// p4
	od									// loop forever
}

proctype q() {
	do									// loop forever
	::  true ->							// loop forever
		printf("P Noncritical.\n");		// q1
		wait();							// q2
		critical++;
		printf("P Critical!\n");		// q3
		critical--;
		signal();						// q4
	od									// loop forever
}

proctype z() {
	do									// loop forever
	::  true ->							// loop forever
		printf("Z Noncritical.\n");		// z1
		wait();							// z2
		critical++;
		printf("Z Critical!\n");		// z3
		critical--;
		signal();						// z4
	od									// loop forever
}
