/* Übung 6 Concurrency, University of Duisburg-Essen */

typedef Semaphore {
	byte V; /* S.V */
	bool blocked[2]; /* S.L - 2 for two processes*/ 
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
	}
}

/* init (main) process */
init {
	S.V = 1; /* Initialize S.V with value 1 */
	atomic {
		run p();
		run q();
	}

}

proctype p() {

}

proctype q() {

}






